//
//  NewsCachManager.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "NewsCachManager.h"
#import "NSString+Hashing.h"
@implementation NewsCachManager

//得到本地缓存的目录
+ (NSString *)cacheDirectory {
    //得到沙盒目录下的cache文件夹
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    cacheDir = [cacheDir stringByAppendingPathComponent:@"NewsCache"];
    //创建NewsCache文件夹，目的是把所有的缓存数据放到该文件夹下面
    //attribute:nil只文件夹跟父文件夹一样的读写属性
    //NSLog(@"%@",cacheDir);
    NSError *error;
    BOOL bret = [[NSFileManager defaultManager]createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:&error];
    if (!bret) {
        
        return nil;
    }
    return cacheDir;
}

+ (NSString *)cacheFileFullPath:(NSString *)url {
    //得到保存的文件的全路径,使用url的MD5加密得到的字符串作为文件名
    //这样url和文件名就对应起来了
    //[url MD5Hash] 是把url进行MD5加密得到的字符串
    //MD5 加密算法是不可逆的
    NSString *fileName = [url MD5Hash];
    NSString *cacheDir = [self cacheDirectory];
    return [cacheDir stringByAppendingPathComponent:fileName];
}

//保存url 对应的数据
//输入的数据，要么是字典，要么数组
+ (void)saveData:(id)object atUrl:(NSString *)url {
   // //首先得到保存的文件路径
    NSString *fileFullPath = [self cacheFileFullPath:url];
    //写入数据,使用NSKeyedArchiver进行数据转换
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [data writeToFile:fileFullPath atomically:YES];
    
}
//读取url对应的数据
+ (id)readDataAtUrl:(NSString *)url {
    NSString *fileFullPath = [self cacheFileFullPath:url];
    NSData *data = [NSData dataWithContentsOfFile:fileFullPath];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

//判断缓存数据是否有效
+ (BOOL)isCacheInvalid:(NSString *)url {
    NSString *fileFullPath = [self cacheFileFullPath:url];
    BOOL isFileExist = [[NSFileManager defaultManager]fileExistsAtPath:fileFullPath isDirectory:nil];
    NSDictionary *attributeDic = [[NSFileManager defaultManager]attributesOfItemAtPath:fileFullPath error:nil];
    NSDate *lastModify = attributeDic.fileModificationDate;
    NSTimeInterval timerInterVal = [[NSDate date]timeIntervalSinceDate:lastModify];
    BOOL isExpire = (timerInterVal > 60*60);
    if (isFileExist && !isExpire) {
        return YES;
    }
    return NO;
}
//计算缓存的大小
+ (NSInteger)cacheSize {
    
    NSInteger totalSize = 0;
    NSString *cacheDir = [self cacheDirectory];
    NSDirectoryEnumerator *enmuerator = [[NSFileManager defaultManager]enumeratorAtPath:cacheDir];
    for (NSString *fileName in enmuerator) {
        NSString *fileFullPath = [cacheDir stringByAppendingPathComponent:fileName];
        NSDictionary *attributeDic = [[NSFileManager defaultManager]attributesOfItemAtPath:fileFullPath error:nil];
        totalSize += attributeDic.fileSize;
    }
    return totalSize;
}
//清除缓存
+ (void)clearDisk {
    NSString *cacheDir = [self cacheDirectory];
    [[NSFileManager defaultManager]removeItemAtPath:cacheDir error:nil];
}
@end
