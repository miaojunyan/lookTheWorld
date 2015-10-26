//
//  InforMationTableViewCell.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "InforMationTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface InforMationTableViewCell ()

{
    InformationModel *_model;
}

@end
@implementation InforMationTableViewCell

- (void)awakeFromNib {
    self.bookImageView.layer.cornerRadius = 4.0;
    self.bookImageView.layer.masksToBounds = YES;
}
- (void)updateWith:(InformationModel *)model {
    _model = model;
    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.nameLabel.text = model.title;
    self.currentImaegView.text = model.desc;
    self.timeImaegView.text = model.pub_time;
    
}
- (IBAction)buttonClick:(id)sender {
    if (self.block) {
        self.block(_model);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
