//
//  MagazineViewController.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "MagazineViewController.h"
#import "InformationModel.h"
#import "NetDataEngie.h"
#import "Define.h"
#import "MagaCollectionViewCell.h"
#import "MagaViewController.h"
#import "JHRefresh.h"
#import "NewsCachManager.h"
@interface MagazineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic)NSInteger offset;
@property (nonatomic)NSMutableArray *dataSource;
@property (nonatomic)UICollectionView *collectionView;
@property (nonatomic)BOOL isRefreshing;
@end

@implementation MagazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createCollectionView];
    [self createRefreshView];
    //[self updataSource];
    [self fetchDataSource];
    
}
#pragma mark -
#pragma mark 数据
- (void)initData {
    
    self.dataSource = [NSMutableArray array];
    self.offset = 0;
    
}
- (void)createRefreshView {
    __weak typeof (self)weakSelf = self;
    [self.collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.offset = 0;
        [weakSelf updataSource];
    }];
}
- (void)endUpDateing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
}
- (void)fetchDataSource {
    if (![self fetchDataSourceFromLocal]) {
        [self updataSource];
    }
}
- (BOOL)fetchDataSourceFromLocal {
    if ([NewsCachManager isCacheInvalid:[self customUrl]]) {
        id responsDate = [NewsCachManager readDataAtUrl:[self customUrl]];
        self.dataSource = [InformationModel parseRespondData:responsDate];
        [self.indicatorView stopAnimating];
        [self.collectionView reloadData];
        return YES;
    }
    return NO;
}
- (NSString *)customUrl {
    
    return [NSString stringWithFormat:kMagazine];
}
- (void)updataSource {
    NSString *url = [self customUrl];
    [[NetDataEngie sharedInstence]requestDataSourceFrom:url success:^(id responsData) {
        if (self.offset == 0) {
            [self.dataSource removeAllObjects];
            self.dataSource = [InformationModel parseRespondData:responsData[@"cats"]];
        }
        else {
            [self.dataSource addObjectsFromArray:[InformationModel parseRespondData:responsData[@"cats"]]];
        }


        
        [self.collectionView reloadData];
        [self.indicatorView stopAnimating];
        [self endUpDateing];
    } failed:^(NSError *error) {
        [self endUpDateing];
    }];
}
- (void)customNavigationLeftItem {

}
- (void)createCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((kScreenWidth - 95)/2,((kScreenWidth - 95)/140)*59);
    
    flowLayout.minimumLineSpacing = 10;

    flowLayout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"MagaCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"magaCellId"];
    [self.view addSubview:self.collectionView];
}
#pragma mark -
#pragma mark delegate 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MagaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"magaCellId" forIndexPath:indexPath];
    InformationModel *model = self.dataSource[indexPath.row];
    [cell updateModel:model];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MagaViewController *mageVC = [[MagaViewController alloc]init];
    InformationModel *model = self.dataSource[indexPath.row];
    mageVC.model = model;
    mageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mageVC animated:YES];
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
