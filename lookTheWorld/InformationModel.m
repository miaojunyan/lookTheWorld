//
//  InformationModel.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "InformationModel.h"


@implementation InformationModel

+ (NSMutableArray *)parseRespondData:(NSDictionary *)respondata {
    
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSDictionary *dic in respondata) {
        InformationModel *model = [[InformationModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArr addObject:model];

    }
    return modelArr;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"cover"]) {
        self.icon = value;
    }
    if ([key isEqualToString:@"gid"]) {
        self.id = value;
    }
}
- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
