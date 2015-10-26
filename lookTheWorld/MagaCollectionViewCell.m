//
//  MagaCollectionViewCell.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/18.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "MagaCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MagaCollectionViewCell

- (void)awakeFromNib {
    
}
- (void)updateModel:(InformationModel *)model {
    
    [self.BookImaegView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.nameLabel.text = model.title;
    
}
@end
