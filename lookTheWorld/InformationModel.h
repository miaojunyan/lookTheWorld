//
//  InformationModel.h
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationModel : NSObject

@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *desc;

@property(nonatomic,copy)NSString *pub_time;
@property(nonatomic,copy)NSString *year;
@property(nonatomic,copy)NSString *vol_year;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *timestamp;
@property(nonatomic,copy)NSString *author;

+ (NSMutableArray *)parseRespondData:(NSDictionary *)respondata;

@end
