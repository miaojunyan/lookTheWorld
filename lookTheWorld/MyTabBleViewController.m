//
//  MyTabBleViewController.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/16.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "MyTabBleViewController.h"
#import "Define.h"


@interface MyTabBleViewController ()<UINavigationControllerDelegate>
@property (nonatomic)UIView *backgroundView;
@property (nonatomic)BOOL backgroundViewIsShow;
@end

#define buttonH 49
#define buttonW kScreenWidth/4
#define kTag    100
@implementation MyTabBleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundViewIsShow = YES;
    [self showUI];
}

- (void)showUI {

   self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    self.backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:self.backgroundView];
    NSMutableArray *viewComtrollers = [NSMutableArray array];
    NSArray *className = @[@"InformationViewController",@"MagazineViewController",@"RespectableViewController",@"PictureViewController"];
    NSArray *selectImageName = @[@"资讯_2",@"杂志_2",@"微言_2",@"酷图_2"];
    NSArray *imageName = @[@"资讯_1",@"杂志_1",@"微言_1",@"酷图_1"];
    NSArray *title = @[@"资讯",@"杂志",@"微言",@"酷图"];
    for (int i = 0; i < className.count; i++) {
        UIViewController *VC = [[NSClassFromString(className[i])alloc]init];
       
       VC.title = title[i];
        
         UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
        [viewComtrollers addObject:nav];
        nav.delegate = self;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:imageName[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:selectImageName[i]] forState:UIControlStateSelected];
        button.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
       
        button.tag = kTag +i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
        }
        [self.backgroundView addSubview:button];
    }
    self.viewControllers = viewComtrollers;
    
}
- (void)resetButtonStatus {
    for (int index = 0; index < self.viewControllers.count; index++) {
        UIButton *button =  (UIButton*)[self.view viewWithTag:kTag+index];
        button.selected = NO;
    }
    
}
- (void)buttonClick:(UIButton *)button {
    
    [self resetButtonStatus];
    NSInteger index = button.tag - kTag;
    button.selected = YES;
    self.selectedIndex = index;
    
}
- (void)navigationController:(UINavigationController *)navController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.tabBar.hidden = YES;
    
    if (viewController.hidesBottomBarWhenPushed)
    {
        [self hideTabBar];
    }
    else
    {
        [self showTabBar];
    }
    
}



- (void)hideTabBar {
    if (!_backgroundViewIsShow) {
        return;
    }
    
    
    [UIView animateWithDuration:0.1
                     animations:^{
                         
                         CGRect tabFrame = self.backgroundView.frame;
                         
                         tabFrame.origin.x = 0 - self.backgroundView.frame.size.width;
                         self.backgroundView.frame = tabFrame;
                     }];
   
    self.backgroundViewIsShow = NO;
    
}

- (void)showTabBar {
    if (self.backgroundViewIsShow)
    {
        return;
    }
    [UIView animateWithDuration:0.33 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect tabFrame = self.backgroundView.frame;
        tabFrame.origin.x = CGRectGetWidth(tabFrame) + CGRectGetMinX(tabFrame);
        self.backgroundView.frame = tabFrame;
        
    } completion:nil];
    self.backgroundViewIsShow = YES;
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
