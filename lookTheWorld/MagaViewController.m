//
//  MagaViewController.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "MagaViewController.h"
#include "Define.h"
#import "InforDetailViewController.h"
@interface MagaViewController ()

@end

@implementation MagaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.title;
}
- (NSString *)composeRequestUrl {
    
    return [NSString stringWithFormat:kMagazineTo,[self.model.id integerValue]];
    
}

- (void)jumpToDetailViewController:(InformationModel *)model atIndexPath:(NSInteger)row{

    InforDetailViewController *inforDetailVC = [[InforDetailViewController alloc]init];
    inforDetailVC.dataSource = self.dataSource;
    inforDetailVC.index = row;
    inforDetailVC.model = model;
    inforDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:inforDetailVC animated:YES];
}
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
