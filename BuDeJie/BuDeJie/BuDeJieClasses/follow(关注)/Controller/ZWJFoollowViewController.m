//
//  ZWJFoollowViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/7.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJFoollowViewController.h"
#import "ZWJLoginViewController.h"

@interface ZWJFoollowViewController ()

@end

@implementation ZWJFoollowViewController

//点击了登录按钮
- (IBAction)clickLogin:(id)sender {
    
    //加载storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ZWJLoginViewController" bundle:nil];
    
    //加载箭头指向的控制器
    ZWJLoginViewController *loginVC = [storyboard instantiateInitialViewController];
    
    [self presentViewController:loginVC animated:YES completion:nil];
    
}


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
