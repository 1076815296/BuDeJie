//
//  ZWJFoollowViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJFoollowViewController.h"


@interface ZWJFoollowViewController ()

@end

@implementation ZWJFoollowViewController

//设置导航条标题字体



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupNavBar];
}

- (void)setupNavBar{
    //设置导航条内容 => 栈顶控制器的navigationItem决定,导航条本身不能决定,所以导航条必须添加控制器
    self.navigationItem.title = @"我的关注";
    
    //左边
    UIBarButtonItem *leftiem = [UIBarButtonItem itmeWithImageName:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] Target:self action:@selector(recmondClick)];
    self.navigationItem.leftBarButtonItem = leftiem;
    
    
}

- (void)recmondClick{
    
    ZWJLog(@"我的关注");
}

@end
