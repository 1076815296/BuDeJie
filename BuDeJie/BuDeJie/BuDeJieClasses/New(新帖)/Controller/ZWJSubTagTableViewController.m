//
//  ZWJSubTagTableViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/6.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJSubTagTableViewController.h"
#import "ZWJSubTagItem.h"
#import <MJExtension/MJExtension.h>
#import "ZWJTagCell.h"
#import <SVProgressHUD.h>

//const 修饰右边的变量变为只读
static NSString * const ID = @"cell1";

/*
 加载Xib Cell
 1.NSBundle:一定要记得绑定标识符
 
 2.注册
 */

@interface ZWJSubTagTableViewController ()

@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, weak) NSURLSessionDataTask *dataTask;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@end

@implementation ZWJSubTagTableViewController
/*
 设置分割线全屏
 1.UIView
 2.利用系统的属性去设置,iOS7做了事情,导致分割线往右边挪动 self.tableView.separatorInset
 3.重写setFrame: 万能
    3.1 取消系统分割线
    3.2设置tableView的背景色为分割线的颜色
    3.3 setFrame,在设置frame之前,把高度减小1
    3/4 一定要记得补回分割线的高度
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //非根控制器可以直接使用title
    self.title = @"推荐标签";
    
    //请求数据 =>查看接口(1.基本的URL 2.请求方式 3.请求参数) =>AFN => 写成plist =>设计模型 =>z 字典转模型
    [self loadData];
    
    //注册xib的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ZWJTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    //取消系统的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置tabView的背景颜色
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    //取消系统分割线的内边距 让分割线全屏
    //self.tableView.separatorInset = UIEdgeInsetsZero;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //隐藏指示器
    [SVProgressHUD dismiss];
    
    //请取消请求
    //[self.dataTask cancel];
    //从会话管理者中的tasks取消请求, tasks中存着当前正在执行的请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}


//请求数据
- (void)loadData{
    
    // 提示用户当前在干嘛
    [SVProgressHUD showWithStatus:@"正在加载数据....."];
    
    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager zwj_manager];
    self.mgr = mgr;
    
    
    //2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    
    //1.网速慢 2.没有网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(50 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //3.发送请求
        self.dataTask = [mgr GET:ZWJBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [SVProgressHUD dismiss];
            //解析数据
            
            //字典数组转模型数组
            self.tags = [ZWJSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
            
            //刷新表格
            [self.tableView reloadData];
            
            //NSLog(@"%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //NSLog(@"%@",error);
            [SVProgressHUD dismiss];
        }];
    });
    
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        //return self.tags.count;
    return 2;
}


//每当有新的cell显示的时候,就会调用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //首先去缓存池取,再去看有没有注册
    ZWJTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    //版本适配 获取当前系统版本
    //NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    //NSLog(@"==%@",systemVersion);
    
//    if (cell == nil) {
//        cell = [ZWJTagCell cell];
//    }
    
    //cell.textLabel.text = [_tags[indexPath.row] theme_name];
    
    //cell.textLabel.text = @"预设";
    cell.item = _tags[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60 + 1;
    
}

@end
