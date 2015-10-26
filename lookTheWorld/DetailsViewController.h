//
//  DetailsViewController.h
//  lookTheWorld
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "BaseViewController.h"
#import "InformationModel.h"
#import "UMSocial.h"
@interface DetailsViewController : BaseViewController<UMSocialUIDelegate>
@property (nonatomic)UIImageView *imageView;
@property (nonatomic)NSArray *dataSource;
@property (nonatomic)NSInteger index;
@property (nonatomic)InformationModel *model;
@property (nonatomic)BOOL isCollection;
@property (nonatomic)BOOL tapEvent;
//@property (nonatomic)UITapGestureRecognizer *tap;
@property (nonatomic)UILongPressGestureRecognizer *tap;

- (void)tapGesture:(UILongPressGestureRecognizer *)gesture;
- (void)createUI;
- (void)collectionEvent;
- (void)NewsModelExistInDB;
- (void)tapGesture;
- (void)shareEvent;
@end
