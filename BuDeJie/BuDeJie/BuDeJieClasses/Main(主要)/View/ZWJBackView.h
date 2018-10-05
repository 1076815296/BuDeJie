//
//  ZWJBackView.h
//  BuDeJie
//
//  Created by 林泉 on 2018/10/5.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWJBackView : UIView

/** 参数属性
 *
 * 第一个参数:控制器
 * 第二个参数:点击调用的方法
 * 第三个参数:显示的文字
 * 第四个参数:显示的标识
 * 第五个参数:显示的高亮标识
 */
+ (instancetype)viewButtonAddTarget:(nullable id)target action:(SEL)action title:(NSString *)title image:(UIImage *)image imageClick:(UIImage *)imageClick;

@end

NS_ASSUME_NONNULL_END
