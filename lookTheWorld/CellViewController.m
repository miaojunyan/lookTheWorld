//
//  CellViewController.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "CellViewController.h"
#import "NetDataEngie.h"
#import "InformationModel.h"
#import "Define.h"
#import "InforMationTableViewCell.h"
#import "JHRefresh.h"
#import "NewsCachManager.h"
#import "MONActivityIndicatorView.h"
@interface CellViewController ()<UITableViewDataSource,UITableViewDelegate,MONActivityIndicatorViewDelegate>


@property (nonatomic)MONActivityIndicatorView *indicatorView;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadingMore;

@end

@implementation CellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initData];
    
    [self createTableView];
    [self createRefreshView];
    
    [self fetchDataSource];
}
- (void)customIndicatorView {
    
    self.indicatorView = [[MONActivityIndicatorView alloc] init];
    self.indicatorView.delegate = self;
    self.indicatorView.numberOfCircles = 3;
    self.indicatorView.radius = 20;
    self.indicatorView.internalSpacing = 3;
    self.indicatorView.center = self.view.center;
    [self.indicatorView startAnimating];
    [self.view addSubview:self.indicatorView];
    
}
- (void)createTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , kScreenWidth, kScreenHeight - 64)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib *nib = [UINib nibWithNibName:@"InforMationTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"InCellId"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}
- (void)initData {
    self.dataSource = [NSMutableArray array];
    self.offset = 0;
}
- (void)createRefreshView {
    __weak typeof (self)weakSelf = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.offset = 0;
        [weakSelf updateSource];
    }];
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.offset +=15;
        weakSelf.isLoadingMore = YES;
    }];
}
- (void)endUpDateing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [self.tableView footerEndRefreshing];
    }
}
#pragma mark -
#pragma mark 请求数据
- (void)fetchDataSource {
    if (![self fetchDataSourceFromLocal]) {
        [self updateSource];
    }
}
- (BOOL)fetchDataSourceFromLocal {
    if ([NewsCachManager isCacheInvalid:[self composeRequestUrl]]) {
        id respondDate = [NewsCachManager readDataAtUrl:[self composeRequestUrl]];
    
        self.dataSource = [InformationModel parseRespondData:respondDate];
        
        [self.tableView reloadData];
        [self.indicatorView stopAnimating];
        return YES;
    }
    return NO;
}
- (void)updateSource {
   NSString *url = [self composeRequestUrl];
    [[NetDataEngie sharedInstence]requestDataSourceFrom:url success:^(id responsData) {
        if (self.offset == 0) {
            [self.dataSource removeAllObjects];
            self.dataSource = [InformationModel parseRespondData:responsData[@"list"]];
            [NewsCachManager saveData:responsData[@"list"] atUrl:[self composeRequestUrl]];
        }
        else {
            [self.dataSource addObjectsFromArray:[InformationModel parseRespondData:responsData[@"list"]]];
             
        }

        [self.indicatorView stopAnimating];
        [self.tableView reloadData];
        [self endUpDateing];
        
    } failed:^(NSError *error) {
        [self endUpDateing];
    }];
}

//- (NSString *)composeRequestUrl {
//    return nil;
//}
#pragma mark -
#pragma mark UITableViewDelegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InforMationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InCellId" forIndexPath:indexPath];
    InformationModel *model = self.dataSource[indexPath.row];
    [cell updateWith:model];
    cell.block = ^(InformationModel *model){
        [self jumpToDetailViewController:model atIndexPath:indexPath.row];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}
- (void)jumpToDetailViewController:(InformationModel *)model atIndexPath:(NSInteger)row{

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InformationModel *model = self.dataSource[indexPath.row];
    [self jumpToDetailViewController:model atIndexPath:indexPath.row];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
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
