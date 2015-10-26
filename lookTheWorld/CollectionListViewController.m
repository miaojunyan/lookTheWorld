//
//  CollectionListViewController.m
//  lookTheWorld
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 苗军艳. All rights reserved.
//

#import "CollectionListViewController.h"
#import "Define.h"
#import "CollectionViewController.h"
#import "ResCollectionViewController.h"
#import "PicCollectionViewController.h"
@interface CollectionListViewController ()

@end

@implementation CollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏列表";
}
- (void)createButtons {
    NSArray *titleName = @[@"您收藏的资讯",@"您收藏的微言",@"您收藏的酷图"];
    for (int i = 0; i < titleName.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5, i * 60 + i * 5 + 10, kScreenWidth-10, 60);
        button.tag = 200 + i;
        [button setBackgroundImage:[UIImage imageNamed:@"内文评论输入框"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titleName[i] forState:UIControlStateNormal];
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , kScreenWidth,15)];
//        label.text = titleName[i];
//        label.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
       //[button addSubview:label];
        
        [self.view addSubview:button];
    }

}
- (void)buttonClick:(UIButton *)button {
    if (button.tag == 200) {
       CollectionViewController *collecVC = [[CollectionViewController alloc]init];
       collecVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:collecVC animated:YES];
    }
    if (button.tag == 201) {
        ResCollectionViewController *resCoVC = [[ResCollectionViewController alloc]init];
        resCoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:resCoVC animated:YES];
    }
    if (button.tag == 202) {
        PicCollectionViewController *picCoVC = [[PicCollectionViewController alloc]init];
        picCoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:picCoVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
