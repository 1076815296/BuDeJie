//
//  ZWJINavigationController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/5.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJINavigationController.h"
#import "ZWJNavigationBar.h"
#import "ZWJBackView.h"

@interface ZWJINavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ZWJINavigationController

/*
 <UIScreenEdgePanGestureRecognizer: 0x7f914361ef80; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7f9143617380>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7f914361e7e0>)>>
 
 target = <_UINavigationInteractiveTransition 0x7f914361e7e0>
 action = handleNavigationTransition
 滑动返回功能
 
 */

/*
 全屏滑动返回功能
 */

/*
 假死状态:程序还在运行,界面死了
 
 根控制器不能有滑动返回
 */

/*
 滑动返回功能L:导航控制器iOS7后自带
 
 恢复滑动返回功能:
 
 分析:覆盖掉系统的返回按钮,滑动返回功能就失效
 
 需求:既要覆盖系统返回按钮,也要有滑动返回功能
 
 为什么没有,谁导致滑动返回功能没有的,当覆盖系统返回按钮,系统额外做了一些事情,导致滑动返回功能失效
 
 系统额外做了什么事情,导致滑动返回功能失效?
 滑动返回功能,肯定需要手势? 猜测是interactivePopGestureRecognizer,就是滑动返回功能
 
 验证滑动返回功能,跟vinteractivePopGestureRecognizer有关系
 让interactivePopGestureRecognizer手势失效,通过代理
 
 当覆盖掉系统返回按钮,系统额外做了一些事情,导致滑动返回功能失效
 系统做的事情就是在- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch中返回了NO
 */

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
#pragma mark -----------------------
#pragma mark UIGestureRecognizerDelegate
//向委托人询问手势识别器是否应该接收表示触摸的对象  在这里面确认滑动返回功能
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    return self.childViewControllers.count >1;
       
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置全屏滑动 不要系统手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    //创建Pan手势
    id target = self.interactivePopGestureRecognizer.delegate;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    //调用代理方法,防止进入假死状态
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    
    //设置系统滑动手势代理为自己,自己控制什么时候触发,避免进入假死状态
    //self.interactivePopGestureRecognizer.delegate = self;
    
    //清空系统手势代理,不让它把滑动返回失效,但是有bug,进入假死状态
    //self.interactivePopGestureRecognizer.delegate = nil;
    
    
    //NSLog(@"%@",self.interactivePopGestureRecognizer);
    
    //换成自己的导航条
    ZWJNavigationBar *bar = [[ZWJNavigationBar alloc] initWithFrame:self.navigationBar.frame];
    
    
    [self setValue:bar forKey:@"navigationBar"];
    //self.navigationBar = bar;
    
    //NSLog(@"%@",self.navigationBar);
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //只有非控制器的时候才需要返回按钮
    //这下面有几个视图,第一个是根控制器,所以是0的时候不调用这个方法
    if (self.childViewControllers.count > 0) {//非根控制器
        //设置返按钮
        ZWJBackView *view = [ZWJBackView viewButtonAddTarget:self action:@selector(back) title:@"返回" image:[UIImage imageNamed:@"navigationButtonReturn"] imageClick:[UIImage imageNamed:@"navigationButtonReturnClick"]];
        
        
        
        //设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    
    [self popViewControllerAnimated:YES];
    
}



@end
