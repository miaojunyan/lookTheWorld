//
//  InforMationTableViewCell.h
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationModel.h"

typedef void(^ButtonActionBlockType) (InformationModel *model);
@interface InforMationTableViewCell : UITableViewCell


@property (nonatomic,copy)  ButtonActionBlockType block;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentImaegView;
@property (weak, nonatomic) IBOutlet UILabel *timeImaegView;

- (void)updateWith:(InformationModel *)model;


@end
