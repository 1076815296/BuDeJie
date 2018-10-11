//
//  ZWJTopTopicView.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/10.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJTopTopicView.h"
#import <UIImageView+WebCache.h>
#import "ZWJTopicItem.h"
#import "NSDate+Date.h"


@interface ZWJTopTopicView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;
@property (weak, nonatomic) IBOutlet UILabel *textView;



@end

@implementation ZWJTopTopicView
- (IBAction)clickMore:(id)sender {
    
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
//    [sheet showInView:self];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"关注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了关注");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"警告" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了警告");
    }];
    
    [alertVC addAction:action];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    
    //主窗口控制器
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [rootVC presentViewController:alertVC animated:YES completion:nil];
}

+ (instancetype)ViewForXib {
    
    
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}




- (void)setItem:(ZWJTopicItem *)item{
    
    _item = item;
    
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.profile_image]];
//    self.nameView.text = item.screen_name;
//
//    self.textView.text = item.text;
//
//    //处理时间
//
//    self.timeView.text = [self timeStr];
//
    
    
    
    
    self.iconView.image = [UIImage imageNamed:@"defaultUserIcon"];
    self.nameView.text = @"机器人";
    self.timeView.text = [self timeStr];
    self.textView.text = @"我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!我没有数据!";
    
}

-(NSString *)timeStr{
    
  
    
    //2015-10-23 14:44:44
    //NSString *str = self.item.create_time;
    NSString *str = @"2018-10-10 11:03:20";
    //发帖日期字符串转发帖日期对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //获取发帖日期对象
    NSDate *createDate = [fmt dateFromString:str];
    
    //获取发帖日期,与当前日期的差值
    NSDateComponents *dateCmp = [createDate datelWithNow];
    
    
    //写伪代码
    if([createDate isThisYear]){//今年
        if([createDate isThiToday]){//今天
            if(dateCmp.hour >= 1){
                
                str = [NSString stringWithFormat:@"%ld小时前",dateCmp.hour];
                
            }else if( dateCmp.minute > 1){
                
                str = [NSString stringWithFormat:@"%ld分钟前",dateCmp.minute];
                
            }else{//刚刚
                str = @"刚刚";
            }

        }else if([createDate isThisYesterday]){//昨天
            
            fmt.dateFormat = @"昨天 HH:mm";
            str = [fmt stringFromDate:createDate];

        }else{//最昨天之前
            
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            str = [fmt stringFromDate:createDate];
            
        }

    }
    
    
    return str;
}


/*
 今年
    今天
    >1 小时
    2小时前
 
    >= 1分钟
    1分钟前
 
    < 一分钟
    刚刚
 
    昨天
    昨天14:44
 
    昨天之前
    10-23 14:44:44

    非今年
    2015-10-23 14:44:44
 
 */





@end
