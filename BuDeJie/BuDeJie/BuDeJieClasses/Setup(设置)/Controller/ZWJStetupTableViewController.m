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
#import "ZWJFileManagr.h"
#import <SVProgressHUD.h>
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
static NSString * const ID = @"cell";

@interface ZWJStetupTableViewController ()
@property (nonatomic,strong) NSString *str;

@end

@implementation ZWJStetupTableViewController

/*
 1.NSFileManager分类
 2.抽取一个业务类,专门处理某项业务逻辑
 
 为什么要搞框架思想 (MVC,MVCS,MVVM,MVP,VIPER)
    1.使代码业务逻辑比较清晰
    2.一个类中的代码不要太多
 3.框架思想 MVCS:
 S:service服务,业务,工具类,专门处理某项业务逻辑
 使用场景:1.处理文件 2.网络的业务类,专门去加载网络 3.离线缓存业务逻辑 4.App配置业务类
 
 */

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸..."];
    
    
    [ZWJFileManagr directorSizeString:CachePath completion:^(NSString * str) {
        
        [SVProgressHUD dismiss];
        
        self.str = str;
        
        [self.tableView reloadData];
        
    }];
    
    
    
    
}


#pragma mark -----------------------
#pragma mark 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    
    cell.textLabel.text = _str;
    
    return cell;
    
}



#pragma mark -----------------------
#pragma mark 按钮点击
//清除缓存
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //清除缓存
    [ZWJFileManagr removeDirectoryPath:CachePath];
   
    
    //刷新表格
    [self.tableView reloadData];
    
}











@end
