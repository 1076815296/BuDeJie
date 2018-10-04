//
//  ZWJMeViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/4.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJMeViewController.h"



@interface ZWJMeViewController ()

@end

@implementation ZWJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self setupNavBar];
   
}

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

- (void)nightClick:(UIButton *)btn {
    
    btn.selected = !btn.selected;
}

- (void)settingClick {
    NSLog(@"设置");
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
