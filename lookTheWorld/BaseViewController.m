//
//  BaseViewController.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/16.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "BaseViewController.h"
#import "Define.h"
#import "SettingViewController.h"
#import "MONActivityIndicatorView.h"
@interface BaseViewController ()<MONActivityIndicatorViewDelegate>



@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customIndicatorView];
    [self customNavigationBar];
    [self customBackground];
    
    
    
}
- (void)customIndicatorView {
    
    self.indicatorView = [[MONActivityIndicatorView alloc] init];
    self.indicatorView.delegate = self;
    self.indicatorView.numberOfCircles = 5;
    self.indicatorView.radius = 15;
    self.indicatorView.internalSpacing = 5;
    self.indicatorView.center = self.view.center;
    [self.indicatorView startAnimating];
    [self.view addSubview:self.indicatorView];
    
}

#pragma mark -
#pragma mark DataSource


#pragma mark -
#pragma mark 创建界面
- (void)customBackground {
    UIImage *image = [UIImage imageNamed:@"资讯背景底"];
    UIImageView *imaegView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imaegView.image = image;
    [self.view addSubview:imaegView];
}
- (void)customNavigationBar {
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIImage *image = [UIImage imageNamed:@"导航背景.jpg"];
    

    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

    [self customNavigationItem];
    [self customNavigationLeftItem];
    
   }

- (void)customNavigationItem {

    UIImage *image = [UIImage imageNamed:@"设置_1@2x"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CGFloat height = self.navigationController.navigationBar.frame.size.height;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, height-5, height-5);
    [button addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)customNavigationLeftItem {
    UIImage *image = [UIImage imageNamed:@"返回_1"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = left;
}
//设置的点击事件
- (void)setting {
    SettingViewController *settinVC = [[SettingViewController alloc]init];
   
    settinVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settinVC animated:YES];
}
- (void)goBack{}
- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
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
