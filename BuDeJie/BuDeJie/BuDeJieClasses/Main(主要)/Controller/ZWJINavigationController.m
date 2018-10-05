//
//  ZWJINavigationController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/5.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJINavigationController.h"
#import "ZWJNavigationBar.h"

@interface ZWJINavigationController ()

@end

@implementation ZWJINavigationController

/*
 UITabBarItem:设置UITabBar上按钮内容
 UINavigationItem:设置导航条哪边显示内容
 UIBarButtonItem:决定导航条上按钮具体内容
 */

+ (void)load{
    
    /*
     appearance:获取整个应用程序下所有东西
     appearanceWhenContainedInInstancesOfClasses:指定一个数组中类下的导航控制器
     */
    
    UINavigationBar *tionBar = [UINavigationBar appearance];
    
    
    //设置导航条标题字体 ==> 导航条
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    tionBar.titleTextAttributes = attr;
    
    //设置导航条的背景图片
    [tionBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //换成自己的导航条
    ZWJNavigationBar *bar = [[ZWJNavigationBar alloc] initWithFrame:self.navigationBar.frame];
    
    
    [self setValue:bar forKey:@"navigationBar"];
    //self.navigationBar = bar;
    
    //NSLog(@"%@",self.navigationBar);
    // Do any additional setup after loading the view.
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
