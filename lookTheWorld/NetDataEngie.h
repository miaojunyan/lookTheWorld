//
//  NetDataEngie.h
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void(^SuccessBlockType)(id responsData);
typedef void(^FailedBlockType)(NSError *error);
@interface NetDataEngie : NSObject

+ (instancetype)sharedInstence;

- (void)requestDataSourceFrom:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;

@end
