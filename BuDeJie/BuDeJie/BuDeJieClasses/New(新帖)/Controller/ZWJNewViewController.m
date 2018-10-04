//
//  ZWJNewViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJNewViewController.h"


@interface ZWJNewViewController ()

@end

@implementation ZWJNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    [self setupNavBar];
    
}

- (void)setupNavBar{
    //设置导航条内容 => 栈顶控制器的navigationItem决定,导航条本身不能决定,所以导航条必须添加控制器
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //左边
    UIBarButtonItem *leftiem = [UIBarButtonItem itmeWithImageName:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] Target:self action:@selector(gameClick)];
    self.navigationItem.leftBarButtonItem = leftiem;
    

}

- (void)gameClick {
    
    NSLog(@"订阅标签");
    
}

@end
