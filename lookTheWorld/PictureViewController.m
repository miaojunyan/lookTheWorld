//
//  PictureViewController.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "PictureViewController.h"
#import "Define.h"
#import "InformationModel.h"
#import "NetDataEngie.h"
#import "PictureCollectionViewCell.h"

#import "JHRefresh.h"
#import "NewsCachManager.h"
#import "PicViewController.h"
@interface PictureViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic)NSInteger offset;

@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadingMore;

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createCollectionView];
    [self createRefreshView];
    [self fetchDataSource];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    CATransition *transition = [CATransition animation];
    transition.duration = 3;
    transition.type = @"rippleEffect";
    [self.view.layer addAnimation:transition forKey:nil];
    
}
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    CATransition *transition = [CATransition animation];
//        transition.duration = 1;
//        transition.type = @"rippleEffect";
//       [self.view.layer addAnimation:transition forKey:nil];
//}
#pragma mark 接收数据
- (void)initData {
    self.offset = 0;
    self.dataSource = [NSMutableArray array];
}
- (void)createRefreshView {
    __weak typeof (self)weakSelf = self;
    [self.collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.offset = 0;
        [weakSelf updateSource];
    }];
    [self.collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.offset +=15;
        weakSelf.isLoadingMore = YES;
    }];
}

- (void)endUpDateing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [self.collectionView footerEndRefreshing];
    }
}
- (void)fetchDataSource {
    if (![self fetchDataSourceFromLocal]) {
        [self updateSource];
    }
}
- (BOOL)fetchDataSourceFromLocal {
    if ([NewsCachManager isCacheInvalid:[self customUrl]]) {
        id respondDate = [NewsCachManager readDataAtUrl:[self customUrl]];
        
        self.dataSource = [InformationModel parseRespondData:respondDate];
        [self.indicatorView stopAnimating];
        [self.collectionView reloadData];
        return YES;
    }

    return NO;
}
- (NSString *)customUrl {
    
    return [NSString stringWithFormat:kPicture,self.offset];
}
- (void)updateSource {
    NSString *url = [self customUrl];
    [[NetDataEngie sharedInstence]requestDataSourceFrom:url success:^(id responsData) {
        if (self.offset == 0) {
            [self.dataSource removeAllObjects];
            self.dataSource = [InformationModel parseRespondData:responsData[@"list"]];
            [NewsCachManager saveData:responsData[@"list"] atUrl:[self customUrl]];
        }
        else {
            [self.dataSource addObjectsFromArray:[InformationModel parseRespondData:responsData[@"list"]]];
            
        }

        [self.collectionView reloadData];
         [self endUpDateing];
       
    } failed:^(NSError *error) {
         [self endUpDateing];
    }];
    
}
- (void)customNavigationLeftItem {}
#pragma mark -
#pragma mark 创建界面
- (void)customBackground {
    
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(kScreenWidth/3-7, kScreenWidth/3 /204 * 230);
    
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) collectionViewLayout:flowLayout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate  = self;
    UINib *nib = [UINib nibWithNibName:@"PictureCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"PictureId"];
    [self.view addSubview:self.collectionView];
    
}
#pragma mark - 
#pragma mark delegate 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureId" forIndexPath:indexPath];
    InformationModel *model = self.dataSource[indexPath.row];
    [cell updateWith:model atIndexPath:indexPath];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    InformationModel *model = self.dataSource[indexPath.row];
   //kutu.gid = model.id;
    PicViewController *picVC = [[PicViewController alloc]init];
    picVC.hidesBottomBarWhenPushed = YES;
    picVC.model = model;
    picVC.dataSource = self.dataSource;
    picVC.index = indexPath.row;
    [self.navigationController pushViewController:picVC animated:YES];
//    kutu.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:kutu animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
