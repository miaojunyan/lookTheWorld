//
//  RespectableViewController.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "RespectableViewController.h"
#import "Define.h"

#import "ResViewController.h"

@interface RespectableViewController ()
//@property (nonatomic,copy)NSString *dest;
//@property (nonatomic,copy)NSString *vol_year;
//@property (nonatomic,copy)

@end

@implementation RespectableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)customNavigationLeftItem {

}

- (NSString *)composeRequestUrl {

    return [NSString stringWithFormat:kRespectable,self.offset];
}

- (void)jumpToDetailViewController:(InformationModel *)model atIndexPath:(NSInteger)row{
    ResViewController *resVC = [[ResViewController alloc]init];
    
    resVC.hidesBottomBarWhenPushed = YES;
    resVC.index = row;
    resVC.model = model;
    resVC.dataSource = self.dataSource;
    
   
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
