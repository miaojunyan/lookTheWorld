//
//  PicCollectionViewController.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "PicCollectionViewController.h"
#import "NewsDBManager.h"

@interface PicCollectionViewController ()

@end

@implementation PicCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (void)viewWillAppear:(BOOL)animated {
    [self fetchDataSource];
}
- (void)fetchDataSource {
    self.dataSource = [[NewsDBManager sharedInstance]readNewsInfoList:@"Picture"];
    [self.collectionView reloadData];

}
- (void)customNavigationLeftItem {
    UIImage *image = [UIImage imageNamed:@"返回_1"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = left;
}
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)customNavigationItem {}
- (void)createRefreshView {}

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
