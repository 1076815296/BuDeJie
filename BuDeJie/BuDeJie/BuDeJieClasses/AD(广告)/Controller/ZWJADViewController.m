//
//  ZWJADViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/6.
//  Copyright © 2018年 ZWJ. All rights reserved.
//
/*
 组件化开发
 
 cocoapods:管理第三方框架,集成第三方框架
 
 cocoapods使用步骤: 命令行
 1.创建Podfile文件 (描述当前工程需要哪些框架) pod init
 2.打开Podfile进行描述 open
 3.pod search AFN
 4.pod install
 
 使用cocoapods好处?1.更新框架  2.自动引入所依赖其他框架 3.组件(小功能框架)化开发 4.优化代码内存容量
 
 ijkplayer:直播框架
 */
/*
 https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538821419098&di=83394fa375af7c7ca8da13807a4f98bf&imgtype=0&src=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Farchive%2Ffaf273e8df9d38e6d8e23fae7e3f9b47c78cd874.jpg
 */

/*
 http://mobads.baidu.com/cpro/ui/mads.php
 */
#define ZWJCode2

#define XMGCode2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

#import "ZWJADViewController.h"
#import <AFNetworking.h>
#import "ZWJADItem.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "ZWJTabBarController.h"

#define ZWJScreenH [UIScreen mainScreen].bounds.size.height
#define ZWJScreenW [UIScreen mainScreen].bounds.size.width

#define iPhone6P (ZWJScreenH == 736)
#define iPhone6 (ZWJScreenH == 667)
#define iPhone5P (ZWJScreenH == 568)
#define iPhone4 (ZWJScreenH == 480)


/*
 占位视图思想:当一个界面层次结构确定的时候,但是其中某一个结构尺寸不确定
 */

@interface ZWJADViewController ()
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) NSTimer *timr;

@end

@implementation ZWJADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置启动图片
    [self setupLaunchImageView];
    
    //展示广告数据 => 根据网络去服务器取数据 => 接口文档 =>AFN => cocoapods
    [self loadADimage];
    
    //创建定时器
    _timr = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
  
}

//每各一秒就调用
- (void)timeChange{
    
    static int count = 3;
    
    count--;
    
    
    
    //设置按钮的文字
    //文字如果出现一闪一闪的效果,改变按钮的样式 改为Custom
    [_jumpButton setTitle:[NSString stringWithFormat:@"跳过(%d)",count] forState:UIControlStateNormal];
    
    if (count == -1) {
        [self jump:nil];
    }
    
   
     
}

//监听跳过按钮
- (IBAction)jump:(id)sender {
    
    //进入到主界面
    //拿到主窗口
    ZWJTabBarController *barVC = [[ZWJTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = barVC;
    //销毁定时器
    [_timr invalidate];
    _timr = nil;
    
}



//请求数据 => 接口文档 => AFN发送请求 => 解析数据 => 1.写出plist  在线解析 => 设计模型 => 字典转模型 => 直接把模型展示到界面
#pragma mark -----------------------
#pragma mark 加载广告数据
//没有服务器 只能在网上找一张图片来学习
- (void)loadADData{
    
    /*
     技巧:如果想知道一个类有哪些东西,跳类
        想知道这个类做了什么事情,跳方法
     */
    
    //1.创建请求会话管理者
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager zwj_manager];
    
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = XMGCode2;
    
    //3.发送请求
    [mgr GET:ZWJBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取到广告的字典
        NSDictionary *adDict = [responseObject[@"ad"] firstObject];
        
        //字典转模型
        ZWJADItem *item = [ZWJADItem mj_objectWithKeyValues:adDict];
        
        
        
        //解析数据 => 写成plist
        [responseObject writeToFile:@"/Users/linquan/Desktop/bsbs/ad.plist" atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        //ZWJLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZWJLog(@"%@",error);
    }];
    
    
    
}

- (void)loadADimage{
    //创建一个UIImageView
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    imageView.frame = CGRectMake(0, 0, ZWJScreenW,ZWJScreenW );
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://photo.16pic.com/00/05/68/16pic_568031_b.jpg"]];
    [_adView addSubview:imageView];
    
    //添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [imageView addGestureRecognizer:tap];
    
    NSLog(@"%@",imageView);
    
}
#pragma mark -----------------------
#pragma mark 点击广告图片调用
- (void)tap{
    
    //进入广告界面
    //safari
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
        
    };
  
    NSLog(@"嗨");
    
}


- (void)setupLaunchImageView{
    
    //根据屏幕去加载不同的图片
    //6p: 736  6:667 5:568
    UIImage *image = nil;
    if (iPhone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iPhone6){
        image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    }else if (iPhone5P){
        image = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];
    }else if (iPhone4){
        image = [UIImage imageNamed:@"LaunchImage-700@2x"];
    }
    _launchImageView.image = image;
    
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
