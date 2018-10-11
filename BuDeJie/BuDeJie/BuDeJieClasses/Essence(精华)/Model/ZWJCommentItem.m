//
//  ZWJCommentItem.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/11.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "ZWJCommentItem.h"
#import "ZWJUserItem.h"

@implementation ZWJCommentItem

- (NSString *)totalContent {
    
    return [NSString stringWithFormat:@"%@:%@",self.user.username,self.content];
    
}

@end
