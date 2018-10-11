//
//  ZWJAllTableViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/9.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJAllTableViewController.h"
#import "ZWJTopicCell.h"
#import "ZWJTopicItem.h"
#import <MJExtension/MJExtension.h>
#import "ZWJTopicViewModel.h"

static NSString * const ID = @"cell";

/*
 不等高cell
 1.自定义cell
 2.划分层次结构(1.TopView 2.中间View (视频,图片,声音) 3.最热评论 4.底部View
 3.不能使用xib描述cell,很多东西不确定
 4.通过代码添加所有的子结构
 5.在initWithStyle里添加
 6.一开始就把所有的子结构全部添加上去
 */

/*
 MVVM:
 VM:视图模型,处理界面的业务逻辑,计算尺寸,点击事件
 以前每个cell对应模型,cell对应一个视图模型
 每个视图模型都会保存自己的模型
 
 好处:自己搭建的MVVM,自己用很爽
 坏处:可读性差,维护成本高
 */

/*
 MJExtension:如果模型中嵌套模型,会自动帮你转,
 如果模型中有数组,数组中又有字典,就不会把字典转模型
 告诉MJ,数组中字典转哪个模型
 */

@interface ZWJAllTableViewController ()

@property (nonatomic ,strong) NSMutableArray *topicVM;
@property (nonatomic, strong) ZWJTopicItem *item;

@end

@implementation ZWJAllTableViewController

- (NSMutableArray *)topicVM {
    
    if (_topicVM == nil) {
        _topicVM = [NSMutableArray array];
        [_topicVM addObject:self.item];
    }
    return _topicVM;
    
}


- (ZWJTopicItem *)item {
    if (_item == nil) {
        _item = [[ZWJTopicItem alloc] init];
        _item.profile_image = @"https://b-ssl.duitang.com/uploads/item/201408/28/20140828015833_3xCLc.thumb.1100_0.jpeg";
        _item.screen_name = @"机器人";
        _item.create_time = @"2018.10.10 11:03";
        _item.text = @"我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!";
        
        
    }
    return _item;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
   
    //只要通过registerClass,Cell就是通过initWithStyle创建的
    [self.tableView registerClass:[ZWJTopicCell class] forCellReuseIdentifier:ID];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    //请求数据
    //[self loadView];
    
    [self.tableView reloadData];
    
   
}

//请求数据
/*- (void)loadView{

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager zwj_manager];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    //拿到视频的数据
    parameters[@"type"] = @(ZWJTopicItemTypeVocie);

    [mgr GET:ZWJBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        //数字转模型
       NSArray* topics = [ZWJTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

       //计算topView尺寸 =>cell尺寸
        //模型转视图模型
        for (ZWJTopicItem *item in topics) {
           //MVVM
            ZWJTopicViewModel *vm = [[ZWJTopicViewModel alloc] init];
            //计算cell的高度和子控件尺寸
            vm.item = item;
            [self.topicVM addObject:vm];
            
            
        }

        //刷新表格
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];

}*/


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //return self.topicVM.count;
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZWJTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    //cell.vm = self.topicVM[indexPath.row];
    
    cell.item = self.item;
    
   
    
    return cell;
}

//调用评论非常高

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //计算topView尺寸 =>cell尺寸
    return 445;
    
    //return [self.topics[indexPath.row] cellH];

}

@end
