//
//  PicViewController.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "PicViewController.h"
#import "NetDataEngie.h"
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "NewsDBManager.h"

@interface PicViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;

@property (weak, nonatomic) IBOutlet UIImageView *weightImageView;

@property (weak, nonatomic) IBOutlet UIImageView *lowImageView;

@property (nonatomic)NSString *icon;
@property (nonatomic)NSString *desc;
@property (nonatomic)UIImage *image;
@end

@implementation PicViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor blackColor];
    [super viewDidLoad];
    [self createDataSource];
    [self NewsModelExistInDB];
}
- (void)createDataSource {
    
    self.model = self.dataSource[self.index];
    NSString *url = [NSString stringWithFormat:kKuToDetail,self.model.id];
    [[NetDataEngie sharedInstence]requestDataSourceFrom:url success:^(id responsData) {
        for (NSDictionary *dic in responsData[@"list"]) {
            self.icon = dic[@"icon"];
            self.desc = dic[@"des"];
            self.title = dic[@"title"];
        }
        [self createXIBView];
        [self NewsModelExistInDB];
        
    } failed:^(NSError *error) {
        
    }];
    
}
- (void)customBackground{}
- (void)createXIBView {
    self.weightImageView.image =[UIImage imageNamed:@"白圆点@2x"];
    self.lowImageView.image = [UIImage imageNamed:@"内文评论输入框.png"];
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:self.icon] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.indicatorView stopAnimating];
        self.image = image;
        float scaleX = kScreenWidth *1.0 / image.size.width;
           float imageHeight = image.size.height * scaleX;
            self.pictureImageView.frame = CGRectMake(0, kScreenHeight/2 - imageHeight/2- kScreenHeight/10, kScreenWidth, imageHeight);
    }   ];
    self.nameLabel.text = self.title;
    self.descTextView.text = self.desc;
}
- (void)createUI {
    [self createDataSource];
    
}
- (void)shareEvent {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5609205be0f55aa0cd0010c9"
                                      shareText:@"刚看到的，不错哦，分享给大家"
                                     shareImage: self.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToTencent,UMShareToRenren,nil]
                                       delegate:self];

}
- (void)collectionEvent {
    if (!self.isCollection) {
        if (self.model) {
            [[NewsDBManager sharedInstance]addNewsInfo:self.model type:@"Picture"];
            UIButton *button = (UIButton *)[self.view viewWithTag:102];
            [button setImage:[UIImage imageNamed:@"收藏成功@2x"] forState:UIControlStateNormal];
         
            self.isCollection  =YES;
        }
        
    }
    else {
        [[NewsDBManager sharedInstance]deleteNewsInfo:self.model type:@"Picture"];
        UIButton *button = (UIButton *)[self.view viewWithTag:102];
        [button setImage:[UIImage imageNamed:@"收藏@2x"] forState:UIControlStateNormal];
        self.isCollection = NO;
    }
    
}
- (void)NewsModelExistInDB {
    
    BOOL isExist = [[NewsDBManager sharedInstance]isNewsInfoExists:self.model type:@"Picture"];
    if (isExist) {
        UIButton *button = (UIButton *)[self.view viewWithTag:102];
        [button setImage:[UIImage imageNamed:@"收藏成功@2x"] forState:UIControlStateNormal];
        
        self.isCollection  = YES;
    }
    else {
        [[NewsDBManager sharedInstance]deleteNewsInfo:self.model type:@"Picture"];
        UIButton *button = (UIButton *)[self.view viewWithTag:102];
        [button setImage:[UIImage imageNamed:@"收藏@2x"] forState:UIControlStateNormal];
        self.isCollection = NO;
    }
}
- (void)tapGesture:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.tapEvent){
            self.tapEvent = NO;
            // self.blackView.frame = CGRectZero;
            self.imageView.hidden = YES;
            self.nameLabel.hidden = YES;
            self.descTextView.hidden = YES;
            self.weightImageView.hidden = YES;
            self.lowImageView.hidden = YES;
            
            
        }
        else {
            self.tapEvent = YES;
            self.imageView.hidden = NO;
            self.nameLabel.hidden = NO;
            self.descTextView.hidden = NO;
            self.lowImageView.hidden = NO;
            self.weightImageView.hidden = NO;
        }
    }
    
    //NSLog(@"MMMM");
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
