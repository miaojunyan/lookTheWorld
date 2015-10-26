//
//  CollectionViewController.h
//  lookTheWorld
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "CellViewController.h"

@interface CollectionViewController : CellViewController

- (void)fetchDataSource;
- (void)jumpToDetailViewController:(InformationModel *)model atIndexPath:(NSInteger)row;

@end
