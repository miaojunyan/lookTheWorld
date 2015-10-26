//
//  DetailsViewController.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "DetailsViewController.h"
#import "Define.h"
#import "NewsDBManager.h"
#import "AboutMeViewController.h"

@interface DetailsViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic)UIImageView *imaegView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createOneView];
    [self NewsModelExistInDB];
    [self addTap];
    self.isCollection = NO;
    self.tapEvent = YES;
}
- (void)addTap {
   
    self.tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    
    self.tap.delegate = self;
    self.tap.minimumPressDuration = 0.5;
    [self.view addGestureRecognizer:self.tap];

}
- (void)tapGesture:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.tapEvent){
            self.tapEvent = NO;
            self.imageView.hidden = YES;
            
        }
        else {
            self.tapEvent = YES;
            self.imageView.hidden = NO;
        }
    }
   
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if (gestureRecognizer == self.tap) {
        return YES;
    }
    return NO;
}
- (void)createOneView {
    self.isCollection = NO;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 64 - 44, kScreenWidth, 44)];
    self.imageView.image = [UIImage imageNamed:@"导航背景.jpg"];
    self.imageView.userInteractionEnabled = YES;
    NSArray *imageArr = @[@"上一章_1",@"酷图转发_1",@"收藏",@"下一章_1"];
    NSArray *selectImageArr = @[@"上一章_2",@"酷图转发_2",@"收藏成功",@"下一章_2"];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectImageArr[i]] forState:UIControlStateSelected];
        button.frame = CGRectMake(0  + (kScreenWidth /4) * i , 0,kScreenWidth/4, 44);
        [button addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.imageView addSubview:button];
        
    }
  [self.view addSubview:self.imageView];
}

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)buttonClickEvent:(UIButton *)button {
        
    if (button.tag == 100) {
        if (self.index == 0){
            button.selected = NO;
        }
        else{
            self.index--;
            [self createUI];
        }
    }
    if (button.tag == 101) {
        [self shareEvent];
        
    }
    if (button.tag == 102) {
       
        [self collectionEvent];
    }
    if (button.tag == 103) {
        if (self.dataSource.count - self.index > 1) {
            self.index ++;
            [self createUI];

        }
        else {
            return;
            }
 
    }
}
- (void)shareEvent {
    
    AboutMeViewController *aboutVC = [[AboutMeViewController alloc]init];
    aboutVC.text = @"如果您对这款app有建议和意见，请联系我们，您的想法对我们很重要，我们衷心希望您的反馈，您可以给我们发邮件，我们的邮箱地址：3175908040@qq.com";
    aboutVC.title = @"用户反馈";
    aboutVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutVC animated:YES];
    
}
- (void)customNavigationItem {}
- (void)createUI {}

#pragma mark - 
#pragma mark UMeng
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    if (response.responseCode == UMSResponseCodeSuccess) {
      
    }
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
