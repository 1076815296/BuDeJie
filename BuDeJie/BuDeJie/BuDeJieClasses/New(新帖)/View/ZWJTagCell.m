//
//  ZWJTagCell.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/7.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJTagCell.h"
#import <UIImageView+WebCache.h>
#import "ZWJSubTagItem.h"


@interface ZWJTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;


@end

@implementation ZWJTagCell

/*
 1.图片变成圆角
    1.1裁剪
    1.2圆角半径
    1.3在xib中的Runtime中添加
 
 2.订阅的数字装换为万
 */

/*
当cell要显示的时候,系统会自动调用setFrame, 给cell设置位置尺寸
*/
- (void)setFrame:(CGRect)frame {
    
    frame.size.height -=1;
    [super setFrame:frame]; 
}


- (void)setItem:(ZWJSubTagItem *)item {
    
    _item = item;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] /*completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        //裁剪图片
        //1.开启图形上下文
        // opaque:不透明度 YES:不透明 NO透明
        // scale:比例因子,像素与点比例 0:自动识别  [UIScreen mainScreen].scale
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2.描述圆形的裁剪区域
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        
        //3.设置裁剪区域
        [clipPath addClip];
        
        //4.绘图
        [image drawAtPoint:CGPointZero];
        
        //5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        //6.关闭上下文
        UIGraphicsPopContext();
        
        self.iconView.image = image;
        
        
    }*/] ;
    
    _nameView.text = item.theme_name;
    
    //处理订阅的数字
   
    CGFloat num = [item.sub_number floatValue];
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",item.sub_number];
    if (num > 10000){
        num = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",num];
        //技巧 当是整数的时候去掉小数点 利用字符替换将.0替换成空字符
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    _nameView.text = item.sub_number;
    
}

+ (instancetype)cell {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ZWJTagCell" owner:nil options:nil] firstObject];
    
}

//当控件从xib加载完成就会调用
//调用一次
- (void)awakeFromNib {
    [super awakeFromNib];
    //圆角半径
//    _iconView.layer.cornerRadius = _iconView.zwj_width * 0.5;
//    
//    //超出主层就会裁剪掉
//    _iconView.layer.masksToBounds = YES;
}


@end
