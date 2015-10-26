//
//  ResCollectionViewController.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "ResCollectionViewController.h"
#import "NewsDBManager.h"
#import "ResViewController.h"
@interface ResCollectionViewController ()

@end

@implementation ResCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微言收藏列表";
}
- (void)fetchDataSource {
    self.dataSource = [[NewsDBManager sharedInstance]readNewsInfoList:@"Res"];
    [self.tableView reloadData];

}
- (void)jumpToDetailViewController:(InformationModel *)model atIndexPath:(NSInteger)row {
    ResViewController *resVC = [[ResViewController alloc]init];
    resVC.dataSource = self.dataSource;
    resVC.index = row;
    resVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resVC animated:YES];
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
