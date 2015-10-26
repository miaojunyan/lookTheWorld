//
//  PictureViewController.h
//  lookTheWorld
//
//  Created by qianfeng001 on 15/9/17.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "BaseViewController.h"

@interface PictureViewController : BaseViewController
@property (nonatomic)NSMutableArray *dataSource;
@property (nonatomic)UICollectionView *collectionView;

- (void)createRefreshView;
- (void)fetchDataSource;

@end
