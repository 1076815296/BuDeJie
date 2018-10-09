//
//  ZWJEssenceViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 zwj. All rights reserved.
//

#import "ZWJEssenceViewController.h"
#import "ZWJAllTableViewController.h"
#import "ZWJVideoViewController.h"
#import "ZWJVoiceViewController.h"
#import "ZWJPictureViewController.h"
#import "ZWJTextViewController.h"



static NSString * const ID = @"cell";
@interface ZWJEssenceViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UIScrollView *topScrollView;
@property (nonatomic, weak) UICollectionView *bottomCollectionView;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, strong) NSMutableArray *btnArry;
@property (nonatomic, weak) UIView *underLine;


@end

@implementation ZWJEssenceViewController

/*
 离屏渲染:当一个view不管有没有显示,只要添加到窗口上,就会被渲染
 
 精华搭建方案:UIScrollView + UICollectionView
 
 如果把a控制器的view添加到bB控制器的view上,那么控制器必须要成为B控制器的子控制器
 */

/*
 iOS7之后,导航控制器只会给它里面的一个ScrollView顶部就会添加额外的滚动区域
*/

- (NSMutableArray *)btnArry {
    
    if (_btnArry == nil) {
        _btnArry = [NSMutableArray array];
    }
    return _btnArry;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //self.navigationController.navigationBarHidden = YES;
    
    [self setupNavBar];
    
    //添加底部内容View
    [self setupBottomCotaninerView];
    
    //添加顶部内容View
    [self setupTopTitleView];
    
    
    //添加所有的子控制器
    [self setupAllChildViewController];
    
    //添加所有标题按钮
    [self setupAllTitleButton];
    
    
    
}

#pragma mark -----------------------
#pragma mark 点击事件
- (void)titleClick:(UIButton *)button{
    
    [self selButton:button];
    
    NSInteger i = button.tag;
    
    //滚动对应的位置
    CGFloat offstX = i * ZWJScreenW;
    self.bottomCollectionView.contentOffset = CGPointMake(offstX, 0);
    
    
   
    
    
}

- (void)gameClick {
    
    NSLog(@"点击了游戏");
    
}




#pragma mark -----------------------
#pragma mark 添加所有控件

//添加所有标题按钮
- (void)setupAllTitleButton{
    
    NSInteger count = self.childViewControllers.count;
    CGFloat btnX = 0;
    CGFloat btnW = ZWJScreenW / count;
    CGFloat btnH = self.topScrollView.zwj_height;
    
    for (int i = 0; i < count; i++) {
        btnX = i * btnW;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title  forState:UIControlStateNormal];
        btn.tag = i;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        [self.topScrollView addSubview:btn] ;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnArry addObject:btn];
        
        if (i == 0) {
            
            //添加下划线
            UIView *underLine = [[UIView alloc] init];
            underLine.backgroundColor = [UIColor redColor];
            [self.topScrollView addSubview:underLine];
            self.underLine = underLine;
            
            [btn.titleLabel sizeToFit];
            
            underLine.zwj_width = btn.titleLabel.zwj_width;
            underLine.zwj_height = 2;
            underLine.zwj_centerX = btn.zwj_centerX;
            underLine.zwj_y = self.topScrollView.zwj_height - underLine.zwj_height;
            
            
            [self titleClick:btn];
        }
        
    }
    
    
}

//添加所有的子控制器
- (void)setupAllChildViewController{
    
    //全部
    ZWJAllTableViewController *allVC = [[ZWJAllTableViewController alloc] init];
    allVC.title = @"全部";
    [self addChildViewController:allVC];
    
    //视频
    ZWJVideoViewController *videoVC = [[ZWJVideoViewController alloc] init];
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    //声音
    ZWJVoiceViewController *voiceVC = [[ZWJVoiceViewController alloc] init];
    voiceVC.title = @"声音";
    [self addChildViewController:voiceVC];
    
    //图片
    ZWJPictureViewController *pictyreVC = [[ZWJPictureViewController alloc] init];
    pictyreVC.title = @"图片";
    [self addChildViewController:pictyreVC];
    
    //段子
    ZWJTextViewController *textVC = [[ZWJTextViewController alloc] init];
    textVC.title = @"段子";
    [self addChildViewController:textVC];
    
}

//添加底部内容View
- (void)setupBottomCotaninerView{
    
    //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    //UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    self.bottomCollectionView = collectionView;
    [self.view addSubview:collectionView];
    
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;//关闭弹簧效果
    collectionView.pagingEnabled = YES;//开启分页功能a
    
   
    
}

//添加顶部内容View
- (void)setupTopTitleView{
    
    CGFloat Y = self.navigationController.navigationBarHidden == YES?20:64;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Y, ZWJScreenW, 35)];
    scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    self.topScrollView = scrollView;
    [self.view addSubview:scrollView];
    
    
}




//设置导航条内容
- (void)setupNavBar{
    //设置导航条内容 => 栈顶控制器的navigationItem决定,导航条本身不能决定,所以导航条必须添加控制器
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //左边
    /*
     UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
     [btn setImage:[UIImage imageNamed:@"nav_item_game_icon"] forState:UIControlStateNormal];
     [btn setImage:[UIImage imageNamed:@"nav_item_game_click_icon"] forState:UIControlStateHighlighted];
     [btn sizeToFit];
     [btn addTarget:self action:@selector(gameClick) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
     */
    UIBarButtonItem *leftiem = [UIBarButtonItem itmeWithImageName:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] Target:self action:@selector(gameClick)];
    self.navigationItem.leftBarButtonItem = leftiem;
    
    //右边
    UIBarButtonItem *item = [UIBarButtonItem itmeWithImageName:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] Target:self action:@selector(gameClick)];
    self.navigationItem.rightBarButtonItem = item;
}



#pragma mark -----------------------
#pragma mark 抽取
/**
 选中标题
 */
- (void)selButton:(UIButton *)button{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    //移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.zwj_centerX = button.zwj_centerX;
    }];
    
}



#pragma mark -----------------------
#pragma mark <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.childViewControllers.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //移除之前的子控制器的view
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    //切换子控制器view
    UITableViewController *vc = self.childViewControllers[indexPath.row];
   
    //不让tableView被挡住
    vc.tableView.contentInset = UIEdgeInsetsMake(64 + self.topScrollView.zwj_height, 0, 49, 0);
    //控制器尺寸一开始不对,调整尺寸
    vc.view.frame = [UIScreen mainScreen].bounds;
    
    [cell.contentView addSubview:vc.view];
    
//    cell.backgroundColor = ZWJColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
    
   

    
    return cell;
    
}


#pragma mark -----------------------
#pragma mark UICollectionViewDelegate
// 滚动完成的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x / ZWJScreenW;
    UIButton *btn = self.btnArry[page];
    [self selButton:btn];
    
   
}



@end
