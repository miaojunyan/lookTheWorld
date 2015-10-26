//
//  PictureCollectionViewCell.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/18.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "PictureCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation PictureCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)updateWith:(InformationModel *)model atIndexPath:(NSIndexPath *)indexPath {
    [self.PictureImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.nameLabel.text = model.title;
    
    if (indexPath.row%3==0 || indexPath.row %3 == 2) {
        self.backImaegView.image = [UIImage imageNamed:@"酷图底1"];
    }
    else {
        self.backImaegView.image = [UIImage imageNamed:@"酷图底2"];
    }
}

@end
