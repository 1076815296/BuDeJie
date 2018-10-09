//
//  ZWJEssenceViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 zwj. All rights reserved.
//

#import "ZWJEssenceViewController.h"
#import "ZWJAllTableViewController.h"
#import "ZWJVideoViewController.h"
#import "ZWJVoiceViewController.h"
#import "ZWJPictureViewController.h"
#import "ZWJTextViewController.h"




@interface ZWJEssenceViewController ()




@end

@implementation ZWJEssenceViewController

/*
 离屏渲染:当一个view不管有没有显示,只要添加到窗口上,就会被渲染
 
 精华搭建方案:UIScrollView + UICollectionView
 
 如果把a控制器的view添加到bB控制器的view上,那么控制器必须要成为B控制器的子控制器
 */

/*
 iOS7之后,导航控制器只会给它里面的一个ScrollView顶部就会添加额外的滚动区域
*/


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
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



#pragma mark -----------------------
#pragma mark 导航条
//设置导航条内容
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
