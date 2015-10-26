//
//  NetDataEngie.m
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "NetDataEngie.h"

@interface NetDataEngie ()

@property (nonatomic)AFHTTPRequestOperationManager *manager;

@end
@implementation NetDataEngie

+ (instancetype)sharedInstence {
    
    static NetDataEngie *s_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_manager = [[NetDataEngie alloc]init];
    });
    return s_manager;
}
- (id)init {
    if (self = [super init]) {
        self.manager = [[AFHTTPRequestOperationManager alloc]init];
        
        NSSet *set = self.manager.responseSerializer.acceptableContentTypes;
        NSMutableSet *mset = [NSMutableSet setWithSet:set];
        [mset addObject:@"text/html"];
        self.manager.responseSerializer.acceptableContentTypes = mset;
    }
    return self;
}

- (void)requestDataSourceFrom:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
   [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       if (successBlock) {
           successBlock(responseObject);
       }
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       if (failedBlock) {
           failedBlock(error);
       }
   }];
}

@end
