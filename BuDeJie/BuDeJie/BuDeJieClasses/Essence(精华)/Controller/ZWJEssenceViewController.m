//
//  ZWJEssenceViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 zwj. All rights reserved.
//

#import "ZWJEssenceViewController.h"


@interface ZWJEssenceViewController ()

@end

@implementation ZWJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setupNavBar];
    
}

- (void)setupNavBar{
    //设置导航条内容 => 栈顶控制器的navigationItem决定,导航条本身不能决定,所以导航条必须添加控制器
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //左边
    /*
     UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
     [btn setImage:[UIImage imageNamed:@"nav_item_game_icon"] forState:UIControlStateNormal];
     [btn setImage:[UIImage imageNamed:@"nav_item_game_click_icon"] forState:UIControlStateHighlighted];
     [btn sizeToFit];
     [btn addTarget:self action:@selector(gameClick) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
     */
    UIBarButtonItem *leftiem = [UIBarButtonItem itmeWithImageName:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] Target:self action:@selector(gameClick)];
    self.navigationItem.leftBarButtonItem = leftiem;
    
    //右边
    UIBarButtonItem *item = [UIBarButtonItem itmeWithImageName:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] Target:self action:@selector(gameClick)];
    self.navigationItem.rightBarButtonItem = item;
}


- (void)gameClick {
    
    NSLog(@"点击了游戏");
    
}


@end
