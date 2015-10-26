//
//  CellViewController.h
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "BaseViewController.h"
#import "InformationModel.h"
@interface CellViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic)NSInteger offset;
@property (nonatomic)NSMutableArray *dataSource;
@property (nonatomic)UITableView *tableView;

- (NSString *)composeRequestUrl;


- (void)jumpToDetailViewController:(InformationModel *)model atIndexPath:(NSInteger)row;
- (void)fetchDataSource;
- (void)createRefreshView;
@end
