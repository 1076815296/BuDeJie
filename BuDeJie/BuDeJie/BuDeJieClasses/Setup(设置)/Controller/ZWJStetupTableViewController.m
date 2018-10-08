//
//  ZWJStetupTableViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/5.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJStetupTableViewController.h"
#import "ZWJBackView.h"
#import <SDImageCache.h>
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
static NSString * const ID = @"cell";

@interface ZWJStetupTableViewController ()

@end

@implementation ZWJStetupTableViewController

/*- (void)viewDidLoad {
    [super viewDidLoad];
    
    //封装进ZWJBackView中
    //设置导航条返回按钮 获取当前控制器的navgationItem的left
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    //CGRect frame = backButton.frame;
    //frame.origin.x -= 10;
    //backButton.frame = frame;
    backButton.zwj_x -= 10;*/
    
    
    //ZWJBackView *view = [[ZWJBackView alloc] initWithFrame:backButton.bounds];
    
    /*ZWJBackView *view = [ZWJBackView viewButtonAddTarget:self action:@selector(back) title:@"返回" image:[UIImage imageNamed:@"navigationButtonReturn"] imageClick:[UIImage imageNamed:@"navigationButtonReturnClick"]];
    
    //[view addSubview:backButton];
    
    
    //为啥viewv不是self.navigationController.navigationBar的子控件
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
    
    
    
}*/

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    
    
}

//当一个cell即将要显示的时候
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//}

//当一个cell将要结束展示的时候
//在堆tableView进行优化的时候
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    //在这里做取消请求的优化
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //计算当前缓存的尺寸 =>缓存到沙盒 => 计算沙盒文件夹的尺寸
    
    //SDWebImage自动缓存: 1.内存缓存 2.磁盘缓存
    
    //SDWebImage的缓存
    //看他有没有提供方法获取缓存
   // NSInteger fileSies = [[SDImageCache sharedImageCache] getSize];
    
    
    
    //获取Cache文件夹尺寸
    
    cell.textLabel.text = [self sizeStr];
    
    return cell;
    
}

- (NSString *)sizeStr{
    
    NSString *str = @"清除缓存";
    NSInteger size = [self getSize];
    if (size > 1000 * 1000) {
        CGFloat sizeF = size / 1000.0 / 1000.0;
        str = [NSString stringWithFormat:@"%@(%.1fMB)",str,sizeF];
        
    }else if (size > 1000) {
        CGFloat sizeF = size / 1000.0 ;
        str = [NSString stringWithFormat:@"%@(%.1fKB)",str,sizeF];
    }else if (size > 0){

        str = [NSString stringWithFormat:@"%@(%ldB)",str,size];
    }
    
    [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    
    
    return str;
}
//清除缓存
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //清除缓存
    //[[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[NSFileManager defaultManager] removeItemAtPath:CachePath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:CachePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //刷新表格
    [self.tableView reloadData];
    
}


/*
 获取文件夹尺寸 => 遍历文件夹所有的尺寸,把文件尺寸累加
 1.创建一个文件管理者
 2.获取文件夹的路径
 3.获取文件夹里面所有的子路径
 4.遍历所有的子路径
 5.拼接文件全路径
 6.attributesOfItemAtPath: 指定文件全路径,就能获取文件属性
 7.获取c文件尺寸
 8.累加
 
 */

- (int)getSize {
    
    //获取cache文件夹路径
    NSString *cachePath = CachePath;
    //获取default文件夹路径
    NSString *defaultPath = [cachePath stringByAppendingPathComponent:@"default"];
   
    //创建文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    //获取文件夹下所有的子路径,获取多级目录下文件路径
    NSArray *subpaths = [mgr subpathsAtPath:defaultPath];
    
    int totalSize = 0;
    for (NSString *subPath in subpaths) {
        NSString *filePath = [defaultPath stringByAppendingPathComponent:subPath];
        //判断是否是隐藏属性
        if ([filePath containsString:@".DS"]) {
            continue;
        }
        
        //判断是否是当前文件夹 是否存在
        BOOL isDirectory = NO;
        BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        if (isDirectory || !isExists ) continue;
        
        
        
        //获取文件属性
        NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
        totalSize += [attr fileSize];
        
    }
    
    
    return totalSize;
}




#pragma mark -----------------------
#pragma mark 返回
/*- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}*/



@end
