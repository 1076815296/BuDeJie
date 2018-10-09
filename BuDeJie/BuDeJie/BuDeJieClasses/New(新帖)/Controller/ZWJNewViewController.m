//
//  ZWJNewViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJNewViewController.h"
#import "ZWJSubTagTableViewController.h"
#import "ZWJAllTableViewController.h"
#import "ZWJVideoViewController.h"
#import "ZWJVoiceViewController.h"
#import "ZWJPictureViewController.h"
#import "ZWJTextViewController.h"

@interface ZWJNewViewController ()

@end

@implementation ZWJNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    [self setupNavBar];
    
    //添加所有的子控制器
    [self setupAllChildViewController];
    
}

//添加所有的子控制器
- (void)setupAllChildViewController{
    
    //全部
    ZWJAllTableViewController *allVC = [[ZWJAllTableViewController alloc] init];
    allVC.title = @"全部";
    [self addChildViewController:allVC];
    
    //视频
    ZWJVideoViewController *videoVC = [[ZWJVideoViewController alloc] init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    //声音
    ZWJVoiceViewController *voiceVC = [[ZWJVoiceViewController alloc] init];
    voiceVC.title = @"声音";
    [self addChildViewController:voiceVC];
    
    //图片
    ZWJPictureViewController *pictyreVC = [[ZWJPictureViewController alloc] init];
    pictyreVC.title = @"图片";
    [self addChildViewController:pictyreVC];
    
    //段子
    ZWJTextViewController *textVC = [[ZWJTextViewController alloc] init];
    textVC.title = @"段子";
    [self addChildViewController:textVC];
    
}


- (void)setupNavBar{
    //设置导航条内容 => 栈顶控制器的navigationItem决定,导航条本身不能决定,所以导航条必须添加控制器
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //左边
    UIBarButtonItem *leftiem = [UIBarButtonItem itmeWithImageName:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] Target:self action:@selector(subClick)];
    self.navigationItem.leftBarButtonItem = leftiem;
    

}

- (void)subClick {
    
   
    ZWJSubTagTableViewController *vc = [[ZWJSubTagTableViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
