//
//  ZWJTabBarController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJTabBarController.h"
#import "ZWJEssenceViewController.h"
#import "ZWJFoollowViewController.h"
#import "ZWJNewViewController.h"
#import "ZWJMeViewController.h"
#import "ZWJReleasseViewController.h"
#import "UIImage+Rendering.h"
#import "UITabBarItem+Font.h"
#import "ZWJINavigationController.h"

/*
 封装:谁的事情谁管理,让业务逻辑非常清晰
 */

/*
    1.给UITabBar里面的按钮设置内容 => UITabBar里面的按钮由对应的子控制器决定
 */

/*
 问题:
 iOS7之后,UITabBar上的按钮只要被选中,就会默认被渲染(tintColor)
 1.按钮被选中,图片被渲染 1.直接修改图片 2.通过代码
    1.Render As 选择  Original Imange
    2. UIImage *selImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
       selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
       nav.tabBarItem.selectedImage = selImage;
 2.按钮被选中,文字颜色和字体
 3.中间的发布按钮显示不出来: 原因是图片被渲染了
 
 中间的图片为什么会被渲染? 中间图片太大了,系统就会自动渲染
 */

/*
 系统UITableBarButton,只有
 */

@interface ZWJTabBarController ()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation ZWJTabBarController

- (UIButton *)plusButton {
    
    if (_plusButton == nil) {
        //创建一个中间按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _plusButton = btn;
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];//自适应尺寸

        [self.tabBar addSubview:btn];
    }
    return _plusButton;
    
}


//程序一启动就会把加载类到内存
//调用一次
+ (void)load{
    
    //获取UITabBarItem外观
    UITabBarItem *item = [UITabBarItem appearance];
   
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    /*
     appearance
     1.谁可以使用appearance? 必须遵守UIAppearance协议,实现协议方法
     2.使用appearance,可以设置任何属性吗? 不可以
     2.1哪些属性可以通过appearance来设置? 只有带有UI_APPEARANCE_SELECTOR宏的属性或者方法才能通过appearance调用
     3.如果通过appearance设置属性,必须在显示之前设置
     
     
     */
    
    
    
}

//第一次使用当前类或者子类的时候也会调用
//可能会调用多次
//+ (void)initialize{
//    //调用这个方法时候要做一件下面这样的事情
//    if (self == [ZWJTabBarController class]) {
//        <#statements#>
//    }
//}

/*
 系统的UITabBarButton什么时候添加的,并不是在viewDidLoad添加的

 UITabBarButtone可能是在viewDidAppear里面添加的
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.plusButton.center = CGPointMake(self.tabBar.bounds.size.width * 0.5, self.tabBar.bounds.size.height * 0.5);
    
    
    self.tabBar.tintColor = [UIColor blackColor]; //设置渲染的颜色 文字颜色也改变了
    
    //添加所有的子控制器
    [self addAllChildViewController];
    
    //设置UITabBar上所有按钮内容
    [self setupAlltabBarButton];
    

    
}

//验证:UITabBarButtone是在viewDidAppear里面添加的
//技巧:如何判断一个方法做了什么事情,直接干掉
/*- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //NSLog(@"%@",self.tabBar.subviews);
}*/
/*
 tabBarItem是模型,不是按钮 想要拿到按钮
 */


#pragma mark -----------------------
#pragma mark 设置UITabBar上所有按钮内容
- (void)setupAlltabBarButton {
    //0 => TabBarVC的第0个子控制器
    UINavigationController * nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    //如果是通过导航控制器的子控制器去设置,必须同时设置标题和图片
    //ZWJEssenceViewController *vc = nav.topViewController;
    //vc.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    //按钮被选中时的状态
    nav.tabBarItem.selectedImage = [UIImage imageNamedWitgOriginal:@"tabBar_essence_click_icon"];
    
    //设置系统UITabBarButton的字体
    //富文本属性:文字字体,颜色,图文混排(html5)
    //富文本属性键值对在NSAttributedString.h中查看
    //字体::只能通过政策的状态去修改
    /*
     NSMutableDictionary *attr = [NSMutableDictionary dictionary];
     attr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
     [nav.tabBarItem setTitleTextAttributes:attr forState:UIControlStateNormal];
     */
    //[nav.tabBarItem setupTabBarButtonFont:[UIFont systemFontOfSize:12]];在load中统一管理
    
    
    //1
    UINavigationController * nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageNamedWitgOriginal:@"tabBar_new_click_icon"];
    
    //2
    UIViewController * vc = self.childViewControllers[2];
    vc.tabBarItem.enabled = NO;
//    vc.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    vc.tabBarItem.selectedImage = [UIImage imageNamedWitgOriginal:@"tabBar_publish_click_icon"];
//    //设置中间图片的位置
//    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    
    //3
    UINavigationController * nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamedWitgOriginal:@"tabBar_friendTrends_click_icon"];
    
    //4
    UINavigationController * nav4 = self.childViewControllers[4];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageNamedWitgOriginal:@"tabBar_me_click_icon"];
    
}


#pragma mark -----------------------
#pragma mark 添加所有的子控制器
- (void)addAllChildViewController{
    
    //添加导航控制器
    //精华
    ZWJEssenceViewController *vc = [[ZWJEssenceViewController alloc] init];
    //vc.view.backgroundColor = [UIColor redColor]; 不要在这边设置 不然每次颜色设置完控制器都会被加载z,在控制器中设置
    ZWJINavigationController *nav = [[ZWJINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    //新帖
    ZWJNewViewController *vc1 = [[ZWJNewViewController alloc] init];
    ZWJINavigationController *nav1 = [[ZWJINavigationController alloc] initWithRootViewController:vc1];
    [self addChildViewController:nav1];
    
    //发布
    ZWJReleasseViewController *vc2 = [[UIViewController alloc] init];
    [self addChildViewController:vc2];
    
    //关注
    ZWJFoollowViewController *vc3 = [[ZWJFoollowViewController alloc] init];
    ZWJINavigationController *nav3 = [[ZWJINavigationController alloc] initWithRootViewController:vc3];
    [self addChildViewController:nav3];
    
    //我
    ZWJMeViewController *vc4 = [[ZWJMeViewController alloc] init];
    ZWJINavigationController *nav4 = [[ZWJINavigationController alloc] initWithRootViewController:vc4];
    [self addChildViewController:nav4];
    
}



@end
