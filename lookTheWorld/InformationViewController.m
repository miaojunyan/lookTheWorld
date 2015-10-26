//
//  InformationViewController.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "InformationViewController.h"
#import "Define.h"
#import "NetDataEngie.h"


#import "InforDetailViewController.h"
@interface InformationViewController ()



@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)customNavigationLeftItem {

}
- (void)jumpToDetailViewController:(InformationModel *)model atIndexPath:(NSInteger)row{

    InforDetailViewController *inforDetailVC = [[InforDetailViewController alloc]init];
    inforDetailVC.dataSource = self.dataSource;
    inforDetailVC.index = row;
    inforDetailVC.model = model;
    inforDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:inforDetailVC animated:YES];
    //wwwwwwwwwwwwwwwwww;
}
- (NSString *)composeRequestUrl {
    return [NSString stringWithFormat:kInformation,self.offset];
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
