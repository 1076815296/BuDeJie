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
#import "ZWJFootRefreshView.h"
#import "ZWJHeaderRefreshView.h"
#import <SVProgressHUD/SVProgressHUD.h>

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
@property (nonatomic, weak) ZWJFootRefreshView *footView;
@property (nonatomic, strong) NSString *maxtime;
@property (nonatomic, weak) ZWJHeaderRefreshView *headerView;
@property (nonatomic, assign) UIEdgeInsets oriInset;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@end

@implementation ZWJAllTableViewController

- (AFHTTPSessionManager *)mgr{
    
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager zwj_manager];
    }
    return _mgr;
    
}

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
    //[self loadNewData];
    
    [self.tableView reloadData];
    
    //添加上拉刷新控件 => 1.footView 2.完全显示的时候才需要刷新数据
    [self setupFootRefreshView];
    
    //添加下拉刷新控件
    [self setupHeaderRefreshView];
    
    //滚动指示器的设置
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 150, 0);
    
    _oriInset = UIEdgeInsetsMake(0, 0, 150, 0);
   
}

//添加下来刷新控件 => 最好不要使用headerView ,下拉控件显示到最上面
- (void)setupHeaderRefreshView{
    
    ZWJHeaderRefreshView *headerView =[ZWJHeaderRefreshView headerView];
    _headerView = headerView;
    headerView.zwj_y = -headerView.zwj_height;
    
    [self.tableView addSubview:headerView];
    
}

// 添加一个上拉刷新控件
// 如果发现一个view从xib加载尺寸不对,截图尝试取消自动拉伸
// bug:一开始也显示了
- (void)setupFootRefreshView{
    
    ZWJFootRefreshView *footView = [ZWJFootRefreshView footView];
    self.footView = footView;
    self.tableView.tableFooterView = footView;
    
}

#pragma mark - 滚动的时候就调用
//松开手指就会调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //判断是否刷新数据
    if (_headerView.isNeedLoad) {
    
        _headerView.isRefreshing = YES;
        
        //悬停:设置顶部的额外的滚动区域
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(self.oriInset.top + self.headerView.zwj_height, 0, self.oriInset.bottom, 0);
        }];
       
        
        //刷新数据
        //[self loadNewData];
        
        _headerView.isNeedLoad = NO;
    }
    
}

//滚动的时候就调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //处理上拉控件
    [self dealFootReshViewScroll:scrollView];
    //处理下拉控件
    [self dealHeaderRefViewScroll:scrollView];
    
}

/** 处理下拉控件 */
- (void)dealHeaderRefViewScroll:(UIScrollView *)scrollView{
    
    //判断下拉控件什么时候完全显示
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    if (offsetY <= -scrollView.contentInset.bottom + _headerView.zwj_height) {
        
        _headerView.isNeedLoad = YES;
        
    }else{
        _headerView.isNeedLoad = NO;
    }
    
}


/** 处理上拉控件 */
- (void)dealFootReshViewScroll:(UIScrollView *)scrollView{
    //没有数据的时候
    //if (self.topicVM.count == 0) return;
    //判断当前有没有真在刷新
    if (self.footView.isRefreshing == YES) return;
    
    //判断有没有完全显示上拉刷新控件
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if(offsetY >= scrollView.contentSize.height + scrollView.contentInset.bottom - ZWJScreenH){
        self.footView.isRefreshing = YES;
        //刷新更多数据
        [self loadMoreData];
        
    }
}


/*
 
 上下拉刷新的冲突问题 取消之前的请求
 
 */

#pragma mark -加载更多数据
- (void)loadMoreData{
    
    //取消之前的请求
   
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"mantime"] =  _maxtime;
    parameters[@"type"] = @(ZWJTopicItemTypeVocie);
    [self.mgr GET:ZWJBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //加载完成
        self.footView.isRefreshing = NO;
        
        //保存下一页最大的ID
        self.maxtime = responseObject[@"info"][@"mantime"];
        
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
        self.footView.isRefreshing = NO;
        [SVProgressHUD showErrorWithStatus:@"加载错误"];
    }];
    
}


//请求数据
/*- (void)loadNewData{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    //拿到视频的数据
    parameters[@"type"] = @(ZWJTopicItemTypeVocie);

    [self.mgr GET:ZWJBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
 
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.contentInset = _oriInset;
        }];
 
        _headerView.isRefreshing = NO;
 
        //保存下一页最大的ID
        _maxtime = responseObject[@"info"][@"mantime"];
 
        //数字转模型
       NSArray* topics = [ZWJTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

       //计算topView尺寸 =>cell尺寸
        //模型转视图模型
        NSMutableArray *arr = [NSMutableArray array];
        for (ZWJTopicItem *item in topics) {
           //MVVM
            ZWJTopicViewModel *vm = [[ZWJTopicViewModel alloc] init];
            //计算cell的高度和子控件尺寸
            vm.item = item;
            [arr addObject:vm];
        }
        self.topicsVM =arr;

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
