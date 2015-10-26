//
//  MagaCollectionViewCell.h
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/18.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationModel.h"
@interface MagaCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *BookImaegView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)updateModel:(InformationModel *)model;

@end
