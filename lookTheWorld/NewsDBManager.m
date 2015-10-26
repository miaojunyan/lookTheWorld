//
//  NewsDBManager.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "NewsDBManager.h"
#import "FMDatabase.h"

@interface NewsDBManager ()
{
    FMDatabase *_db;
}
@end
@implementation NewsDBManager


+ (instancetype)sharedInstance {
    static NewsDBManager *s_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_manager = [[NewsDBManager alloc]init];
    });
    return s_manager;
}
- (NSString *)dbPath {
    return [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/News.db"];
}
- (id)init {
    
    if (self = [super init]) {
        
        _db = [[FMDatabase alloc]initWithPath:[self dbPath]];
        if ([_db open]) {
            [self creataTable];
        }
    }
    return self;
}

- (void)creataTable {
    NSString *sql = @"create table if not exists NewInfo(serialId integer primary key autoincrement,NewsIcon text,Newstitle text,NewsId text, NewsDesc text, NewsTime text,NewsYear text,type text)";
    if (![_db executeUpdate:sql]) {
       
    }
}
//添加
- (void)addNewsInfo:(InformationModel *)model type:(NSString*)type{
    NSString *sql = @"insert into NewInfo(NewsIcon,Newstitle,NewsId,NewsDesc,NewsTime,NewsYear,type) values(?,?,?,?,?,?,?)";
    
    if (![_db executeUpdate:sql,model.icon,model.title,model.id,model.desc,model.pub_time,model.vol_year,type]) {
        
    }
    
}
//删除
- (void)deleteNewsInfo:(InformationModel *)model type:(NSString*)type{
    NSString *sql = @"delete from NewInfo where NewsId = ?AND type = ?";
    if (![_db executeUpdate:sql,model.id,type]) {
        
    }
}
//读取
- (NSMutableArray *)readNewsInfoList:(NSString*)type{
    NSMutableArray *newsArr = [NSMutableArray array];
    NSString *sql = @"select * from NewInfo where type = ?";
    FMResultSet *resultSet = [_db executeQuery:sql,type];
    while (resultSet.next) {
        InformationModel *model = [[InformationModel alloc]init];
        model.icon = [resultSet stringForColumn:@"NewsIcon"];
        model.title = [resultSet stringForColumn:@"Newstitle"];
        model.id = [resultSet stringForColumn:@"NewsId"];
        model.desc = [resultSet stringForColumn:@"NewsDesc"];
        model.pub_time = [resultSet stringForColumn:@"NewsTime"];
        model.vol_year = [resultSet stringForColumn:@"NewsYear"];
        [newsArr addObject:model];
    }
    [resultSet close];
    return newsArr;
}
//判断是否存在
- (BOOL)isNewsInfoExists:(InformationModel *)model type:(NSString*)type{
    BOOL isExist = NO;
    NSString *sql = @"select * from NewInfo where NewsId = ? and type = ?";
    FMResultSet *resultSet = [_db executeQuery:sql,model.id,type];
    if (resultSet.next) {
        isExist = YES;
    }
    [resultSet close];
    return isExist;
}



@end
