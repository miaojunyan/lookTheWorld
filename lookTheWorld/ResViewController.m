//
//  ResViewController.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/18.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "ResViewController.h"
#import "Define.h"
#import "InformationModel.h"
#import "NewsDBManager.h"
@interface ResViewController ()

@end

@implementation ResViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:230/255.0 alpha:1.0];
    [self.indicatorView stopAnimating];
    [self createXIBView];
    [self NewsModelExistInDB];
    
    
}
- (void)createXIBView {
    self.model = self.dataSource[self.index];
    self.title = [NSString stringWithFormat:@"第%@期",self.model.vol_year];
    self.timeLabel.text = self.model.pub_time;
    self.nameLabel.text = self.model.title;
    self.currentLabel.text = self.model.desc;
    self.currentLabel.frame = CGRectMake(20, self.timeLabel.frame.size.height + self.timeLabel.frame.origin.y, kScreenWidth - 40, [self height:self.model.desc]);
    [self.view addSubview:self.imageView];
}
- (CGFloat)height:(NSString *)desc {
    CGRect rect = [desc boundingRectWithSize:CGSizeMake(kScreenWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height;
}

- (void)customBackground{}

- (void)goBack{
    [self.navigationController  popViewControllerAnimated:YES];
}
- (void)createUI {
    [self createXIBView];
     [self NewsModelExistInDB];
}
- (void)collectionEvent {
    if (!self.isCollection) {
        if (self.model) {
            [[NewsDBManager sharedInstance]addNewsInfo:self.model type:@"Res"];
            UIButton *button = (UIButton *)[self.view viewWithTag:102];
            [button setImage:[UIImage imageNamed:@"收藏成功@2x"] forState:UIControlStateNormal];
         
            self.isCollection  =YES;
        }
        
    }
    else {
        [[NewsDBManager sharedInstance]deleteNewsInfo:self.model type:@"Res"];
        UIButton *button = (UIButton *)[self.view viewWithTag:102];
        [button setImage:[UIImage imageNamed:@"收藏@2x"] forState:UIControlStateNormal];
        self.isCollection = NO;
    }
    
}
- (void)NewsModelExistInDB {
    
    BOOL isExist = [[NewsDBManager sharedInstance]isNewsInfoExists:self.model type:@"Res"];
    if (isExist) {
        UIButton *button = (UIButton *)[self.view viewWithTag:102];
        [button setImage:[UIImage imageNamed:@"收藏成功@2x"] forState:UIControlStateNormal];
        
        self.isCollection  = YES;
    }
    else {
        [[NewsDBManager sharedInstance]deleteNewsInfo:self.model type:@"Res"];
        UIButton *button = (UIButton *)[self.view viewWithTag:102];
        [button setImage:[UIImage imageNamed:@"收藏@2x"] forState:UIControlStateNormal];
        self.isCollection = NO;
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
