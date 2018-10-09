//
//  ZWJVideoViewController.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/9.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJVideoViewController.h"

static NSString * const ID = @"cell";

@interface ZWJVideoViewController ()

@end

@implementation ZWJVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"视频%ld",indexPath.row];
    
    return cell;
}

@end
