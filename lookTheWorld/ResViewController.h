//
//  ResViewController.h
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/18.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "BaseViewController.h"
#import "InformationModel.h"
#import "DetailsViewController.h"
@interface ResViewController : DetailsViewController
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
//@property (nonatomic)InformationModel *model;

@end
