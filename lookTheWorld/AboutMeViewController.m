//
//  AboutMeViewController.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "AboutMeViewController.h"
#import "Define.h"
@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, kScreenWidth - 100, 200)];
    label.text = self.text;
    
    label.numberOfLines = 5;
    [self.view addSubview:label];
}

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
