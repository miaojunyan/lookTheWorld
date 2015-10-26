//
//  CollectionViewController.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "CollectionViewController.h"
#import "NewsDBManager.h"

#import "InforDetailViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯收藏列表";

   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   [self fetchDataSource];
}
- (void)fetchDataSource {
    self.dataSource = [[NewsDBManager sharedInstance]readNewsInfoList:@"infor"];
    [self.tableView reloadData];
    
}
- (void)jumpToDetailViewController:(InformationModel *)model atIndexPath:(NSInteger)row{

    InforDetailViewController *inforDetailVC = [[InforDetailViewController alloc]init];
    inforDetailVC.dataSource = self.dataSource;
    inforDetailVC.index = row;
    inforDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:inforDetailVC animated:YES];
    
}
- (void)createRefreshView {}
- (void)customNavigationItem {}
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
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
