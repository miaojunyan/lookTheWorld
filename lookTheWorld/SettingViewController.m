//
//  SettingViewController.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "SettingViewController.h"
#import "Define.h"
#import "NewsCachManager.h"
#import "AboutMeViewController.h"
#import "CollectionListViewController.h"
#import "CollectionViewController.h"
@interface SettingViewController ()

@property (nonatomic)BOOL isShowBall;
//@property (nonatomic)UIView *greenBall;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self createButtons];
    self.title = @"君悦天下";
    
}

- (void)createButtons {
    
    NSArray *dataSource = @[@"收藏列表",@"用户反馈",@"关于我们",@"清除缓存"];
    NSArray *imageNameArr = @[@"收藏夹",@"用户登录",@"关于我们",@"清除缓存"];
    for (int i = 0; i < dataSource.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5, i * 60 + i * 5 + 10, kScreenWidth-10, 60);
        button.tag = 100 + i;
        [button setBackgroundImage:[UIImage imageNamed:@"内文评论输入框"] forState:UIControlStateNormal];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 7, 45, 45)];
        imageView.image = [UIImage imageNamed:imageNameArr[i]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(135, 23 , kScreenWidth - 135,15 )];
        label.text = dataSource[i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:imageView];
        [button addSubview:label];
        
        [self.view addSubview:button];
    }
    
}
- (void)buttonClick:(UIButton *)button {

    switch (button.tag) {
        case 100:{
            CollectionListViewController *collecListVC = [[CollectionListViewController alloc]init];
            collecListVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:collecListVC animated:YES];
            

        }
            break;
        case 101:{
            AboutMeViewController *aboutVC = [[AboutMeViewController alloc]init];
            aboutVC.text = @"如果您对这款app有建议和意见，请联系我们，您的想法对我们很重要，我们衷心希望您的反馈，您可以给我们发邮件，我们的邮箱地址：3175908040@qq.com";
            aboutVC.title = @"用户反馈";
            aboutVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case 102:{
            AboutMeViewController *aboutVC = [[AboutMeViewController alloc]init];
            aboutVC.text = @"我们是iOS设计师,我们有个梦想,让世界就在我们的手中,让世界更美好!";
            aboutVC.title = @"关于我们";
            aboutVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case 103:
            [self createClear];
            break;
        
        default:
            break;
    }
}
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createOneView {

}
- (void)createClear {
    
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"你确定要删除缓存吗?" preferredStyle:UIAlertControllerStyleAlert];
    [alterController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [NewsCachManager clearDisk];
    }]];
    [alterController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alterController animated:YES completion:nil];
}
- (void)customNavigationItem{}
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
