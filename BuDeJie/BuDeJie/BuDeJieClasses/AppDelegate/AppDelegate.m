//
//  AppDelegate.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 zwj. All rights reserved.
//

#import "AppDelegate.h"

#import "ZWJTabBarController.h"
#import "ZWJADViewController.h"
/*
 广告界面,程序一启动就会进入广告界面
 
 1.搞一个view添加到窗口上,过段时间,在移除
 2.一开始设置窗口的根控制器为广告控制器
 
 */

@interface AppDelegate ()

@end

@implementation AppDelegate

//程序启动完成的时候调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.创建窗口根控制器
    //  窗口在显示的时候,把窗口控制器的View添加窗口上
    //ZWJTabBarController *tabBarVC = [[ZWJTabBarController alloc] init];
    ZWJADViewController *adVC = [[ZWJADViewController alloc] init];
    self.window.rootViewController = adVC;
    
    
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
