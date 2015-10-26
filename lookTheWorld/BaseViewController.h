//
//  BaseViewController.h
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/16.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MONActivityIndicatorView.h"
@interface BaseViewController : UIViewController
@property (nonatomic)MONActivityIndicatorView *indicatorView;

- (void)customBackground;
- (void)customNavigationLeftItem;
- (void)customNavigationItem;
- (void)goBack;

@end
