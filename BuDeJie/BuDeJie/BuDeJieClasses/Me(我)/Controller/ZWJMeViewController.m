//
//  ZWJMeViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//
// 设置tableView底部视图
/*
 UICollectionView使用步骤
 1.初始化流水布局
 2.UICollectionViewCell必须注册
 3.UICollectionViewCell一般自定义cell.
 */

/*
 
 为什么UICollectionViewCell必须注册m,因为他用了forIndexPath这个方法
 如果UITableViewCell也用了forIndexPath这个方法,他也必须通过注册,z因为这个方法内部有个机制必须通过注册才行
 */

#import "ZWJMeViewController.h"
#import "ZWJStetupTableViewController.h"
#import "ZWJSquareItem.h"
#import <MJExtension/MJExtension.h>
#import <SafariServices/SafariServices.h>

#define itemWH (ZWJScreenW - (cols - 1) *margin ) / cols


static NSString * const ID = @"cell";
/** 总列数 */
static NSInteger const cols = 4;
/** 间距 */
static CGFloat const margin = 1;

@interface ZWJMeViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *squareList;
@property (nonatomic, strong) UICollectionView *collectionView;





@end

@implementation ZWJMeViewController

/*
 有多少行
 1.设置CollectionView的高度
 2.让CollectionView不能滚
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    
    //设置tableView底部视图
    [self setupFottView];
   
    //请求服务器数据
    //[self loadData];

    //设置分组样式tableView的组间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%@",NSStringFromCGRect(cell.frame));
//
//}

//-(void)viewDidAppear:(BOOL)animated {
//
//    [super viewDidAppear:animated];
//    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
//
//}

//发送请求接受我的数据数据
- (void)loadData{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager zwj_manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [mgr GET:ZWJBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/linquan/Desktop/bsbs/re.plist" atomically:YES];
        
        //字典数组转模型数组
        self.squareList = [ZWJSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        //补齐缺口
        [self reslovData];
        
        
        //计算总行数 = (总数 -1 ) / 总列数 + 1  求总行数万能公式
        NSInteger rows =( self.squareList.count - 1) / cols +1;
        
        //计算内容高度
        CGFloat collectionH = rows *itemWH + (rows - 1) * margin;
        self.collectionView.zwj_height = collectionH;
        
        //更新tableViewd滚动范围
        //self.tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.collectionView.frame));//有bug
        self.tableView.tableFooterView = self.collectionView;
        
        //刷新表格
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZWJLog(@"%@",error);
    }];
    
    
}

//补齐缺口
- (void)reslovData {
    
    //3 1
    //3 % 4  4-3 = 1
    
    NSInteger count = self.squareList.count;
    NSInteger extre = count % cols;
    if (extre) {
        extre = count - extre;
        
        for (int i = 0; i < extre; i++) {
           ZWJSquareItem *item = [[ZWJSquareItem alloc] init];
            [self.squareList addObject:item];
        }
        
    }
    
}


//地耦合 高聚合(代码块去包装) => 函数式编程
//函数式编程 链式编程 响应式编程
- (void)setupFottView{
    
    
    UICollectionViewFlowLayout *flowLayoyt = [self setupUICollectionViewFlowLayout];
    
    UICollectionView *collectionView = [self setupUICollectionView:flowLayoyt];
    
    self.tableView.tableFooterView = collectionView;
    
}


#pragma mark -----------------------
#pragma mark 创建UICollectionView
- (UICollectionView *)setupUICollectionView :(UICollectionViewFlowLayout *)flowLayoyt{
    
    //创建UICollectionView
    //UICollectionView默认为黑色
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) collectionViewLayout:flowLayoyt];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        //注册CollectionView
        [collectionView registerNib:[UINib nibWithNibName:@"ZWJSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
        
        collectionView;
    });
   
    self.collectionView = collectionView;
    
    return collectionView;
    
}

//
#pragma mark -----------------------
#pragma mark 创建布局
- (UICollectionViewFlowLayout *)setupUICollectionViewFlowLayout {
    //这里要用利用流水布局UICollectionViewFlowLayout 不要用UICollectionViewLayout
    //在创建布局
    UICollectionViewFlowLayout *flowLayoyt = ({
        UICollectionViewFlowLayout *flowLayoyt = [[UICollectionViewFlowLayout alloc] init];
        //设置cell尺寸
       
        flowLayoyt.itemSize = CGSizeMake(itemWH,itemWH);
        flowLayoyt.minimumLineSpacing = margin;
        flowLayoyt.minimumInteritemSpacing = margin;
        
        //值读取最后一个分号的值
        flowLayoyt;
        
    });
    return flowLayoyt;
}


#pragma mark -----------------------
#pragma mark SFSafariViewControllerDelegate
//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
//
//    NSLog(@"点击了dan");
//    self.navigationController.navigationBarHidden = NO;
//    [self.navigationController popViewControllerAnimated:YES];
//
//}


#pragma mark -----------------------
#pragma mark UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //打开网页
    /*
     1.openURL:safari:有很多好用的工呢,前进,后退s,刷新,地址栏,进度条
     弊端:必须离开当前APP
     2.UIWebView:只能展示网页,没有功能
     好处:在当前App打开网页
     3.在当前App打开网页,但是也要有safarid功能
     ISO9:SFSafariViewController:打开网页,而且是在当前App打开,而且有safari所有功能
     必须要导入<SafariServices/SafariServices.h>
     
     4.IOS8 WKWebView:1.自带缓存
     */
    //ZWJSquareItem *item = self.squareList[indexPath.row];
    //NSURL *url = [NSURL URLWithString:item.url];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url ];
    //利用代理 用push方法实现跳转
    //safariVC.delegate = self;
    //[self.navigationController pushViewController:safariVC animated:YES];
    //self.navigationController.navigationBarHidden = YES;
    
    
    [self presentViewController:safariVC animated:YES completion:nil];
    
    
    
    
}





#pragma mark -----------------------
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //计算总行数 = (总数 -1 ) / 总列数 + 1  求总行数万能公式
    NSInteger rows =( 50 - 1) / cols +1;
    
    //计算内容高度
    CGFloat collectionH = rows *itemWH + (rows - 1) * margin;
    self.collectionView.zwj_height = collectionH;
    
    //更新tableViewd滚动范围
    self.tableView.tableFooterView = self.collectionView;

    
    return 50;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor redColor];
    
    
    
    return cell;
    
}

//设置导航条内容
- (void)setupNavBar{
    //设置导航条内容 => 栈顶控制器的navigationItem决定,导航条本身不能决定,所以导航条必须添加控制器
    self.navigationItem.title = @"我的";
    
    //不要在导航控制器的根控制器下去设置self.title
    //self.title = @"我的";
    
    //右边
    //夜间模式
    //按钮选中状态必须通过代码去设置
    UIBarButtonItem *nightMode = [UIBarButtonItem itmeWithImageName:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] Target:self action:@selector(nightClick:)];
    
    UIBarButtonItem *setting = [UIBarButtonItem itmeWithImageName:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] Target:self action:@selector(settingClick)];
    
    self.navigationItem.rightBarButtonItems = @[setting,nightMode];
    
    
}

//夜间模式
- (void)nightClick:(UIButton *)btn {
    
    btn.selected = !btn.selected;
}

//设置按钮
- (void)settingClick {
    
    //跳转到设置界面
    ZWJStetupTableViewController *steupVC = [[ZWJStetupTableViewController alloc] init];
    /*
     隐藏底部条
     这个属性的条件一定要在push之前设置
     */
    
    [self.navigationController pushViewController:steupVC animated:YES];
    
    
}



@end
