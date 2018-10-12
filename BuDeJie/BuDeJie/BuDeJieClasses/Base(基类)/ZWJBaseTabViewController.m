//
//  ZWJBaseTabViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/9.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJBaseTabViewController.h"


static NSString * const ID = @"cell";
@interface ZWJBaseTabViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UIScrollView *topScrollView;
@property (nonatomic, weak) UICollectionView *bottomCollectionView;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, strong) NSMutableArray *btnArry;
@property (nonatomic, weak) UIView *underLine;
@property (nonatomic, assign) BOOL isInitial;



@end

@implementation ZWJBaseTabViewController

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
    
    //添加底部内容View
    [self setupBottomCotaninerView];
    
    //添加顶部内容View
    [self setupTopTitleView];
    

    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.isInitial == NO) {
        //添加所有标题按钮
        [self setupAllTitleButton];
        self.isInitial = YES;
    }
    
}

#pragma mark -----------------------
#pragma mark 点击事件
- (void)titleClick:(UIButton *)button{
    
    [self selButton:button];
    
    NSInteger i = button.tag;
    
    //滚动对应的位置
    CGFloat offstX = i * ZWJScreenW;
    self.bottomCollectionView.contentOffset = CGPointMake(offstX, -64);
    
    
    
    
    
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
            
            [btn.titleLabel sizeToFit];//调整按钮位置大小,用来确定标题的大小尺寸
            
            underLine.zwj_width = btn.titleLabel.zwj_width;
            underLine.zwj_height = 2;
            underLine.zwj_centerX = btn.zwj_centerX;
            underLine.zwj_y = self.topScrollView.zwj_height - underLine.zwj_height;
            
            [self titleClick:btn];
        }
        
    }
    
    
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
    vc.view.frame = CGRectMake(0, 92, ZWJScreenW, [UIScreen mainScreen].bounds.size.height);
    vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, 92, 0);
    
    
    
    [cell.contentView addSubview:vc.view];
    
    
    
    
    
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
