//
//  InforDetailViewController.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "InforDetailViewController.h"
#import "InformationModel.h"
#import "Define.h"
#import "NewsDBManager.h"
#import "MONActivityIndicatorView.h"
@interface InforDetailViewController ()<MONActivityIndicatorViewDelegate,UIWebViewDelegate>

@property (nonatomic)UIWebView *webView;
//@property (nonatomic)MONActivityIndicatorView *indicatorView;
@end

@implementation InforDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createWebView];
    [self NewsModelExistInDB];
}
- (void)customIndicatorView {
    
    self.indicatorView = [[MONActivityIndicatorView alloc] init];
    self.indicatorView.delegate = self;
    self.indicatorView.numberOfCircles = 5;
    self.indicatorView.radius = 15;
    self.indicatorView.internalSpacing = 5;
    self.indicatorView.center = self.view.center;
    [self.indicatorView startAnimating];
    [self.webView addSubview:self.indicatorView];
    
}
- (void)createWebView {
   self.model = [self.dataSource objectAtIndex:self.index];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.scalesPageToFit = YES;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kDetailUrl,[self.model.id intValue]]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    //[self.indicatorView stopAnimating];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.imageView];
}
- (void)createUI {
    [self createWebView];
    [self NewsModelExistInDB];
}
- (void)collectionEvent {
    if (!self.isCollection) {
        if (self.model) {
            [[NewsDBManager sharedInstance]addNewsInfo:self.model type:@"infor"];
            UIButton *button = (UIButton *)[self.view viewWithTag:102];
            [button setImage:[UIImage imageNamed:@"收藏成功@2x"] forState:UIControlStateNormal];
            self.isCollection  =YES;
        }
        
    }
    else {
        [[NewsDBManager sharedInstance]deleteNewsInfo:self.model type:@"infor"];
        UIButton *button = (UIButton *)[self.view viewWithTag:102];
        [button setImage:[UIImage imageNamed:@"收藏@2x"] forState:UIControlStateNormal];
        self.isCollection = NO;
    }
    
}
- (void)NewsModelExistInDB {
    
    BOOL isExist = [[NewsDBManager sharedInstance]isNewsInfoExists:self.model type:@"infor"];
    if (isExist) {
        UIButton *button = (UIButton *)[self.view viewWithTag:102];
        [button setImage:[UIImage imageNamed:@"收藏成功@2x"] forState:UIControlStateNormal];
        
        self.isCollection  = YES;
    }
    else {
        UIButton *button = (UIButton *)[self.view viewWithTag:102];
        [button setImage:[UIImage imageNamed:@"收藏@2x"] forState:UIControlStateNormal];
        self.isCollection = NO;
    }
    
}
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
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self customIndicatorView];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.indicatorView stopAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicatorView stopAnimating];
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
