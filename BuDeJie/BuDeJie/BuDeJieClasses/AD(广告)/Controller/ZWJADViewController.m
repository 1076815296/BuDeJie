//
//  ZWJADViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/6.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJADViewController.h"
#import <AFNetworking.h>

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
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;

@end

@implementation ZWJADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置启动图片
    [self setupLaunchImageView];
    
    //展示广告数据 => 根据网络去服务器取数据 => 接口文档 =>AFN => cocoapods
  
}

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
