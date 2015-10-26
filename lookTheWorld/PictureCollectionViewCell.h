//
//  PictureCollectionViewCell.h
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/18.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationModel.h"
@interface PictureCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *PictureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImaegView;

- (void)updateWith:(InformationModel *)model atIndexPath:(NSIndexPath *)indexPath;

@end
