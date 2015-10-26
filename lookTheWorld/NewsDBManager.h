//
//  NewsDBManager.h
//  lookTheWorld
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InformationModel.h"
@interface NewsDBManager : NSObject

+ (instancetype)sharedInstance;
//
//添加
- (void)addNewsInfo:(InformationModel *)model type:(NSString*)type;
//删除
- (void)deleteNewsInfo:(InformationModel *)model type:(NSString*)type;
//读取
- (NSMutableArray *)readNewsInfoList:(NSString*)type;
//判断是否存在
- (BOOL)isNewsInfoExists:(InformationModel *)model type:(NSString*)type;

@end
