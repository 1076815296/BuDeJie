//
//  AFHTTPSessionManager+Manager.m
//  BuDeJie
//
//  Created by 林泉 on 2018/10/6.
//  Copyright © 2018年 ZWJ. All rights reserved.
//

#import "AFHTTPSessionManager+Manager.h"


@implementation AFHTTPSessionManager (Manager)

+ (instancetype)zwj_manager {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript", nil];
    mgr.responseSerializer = response;
    return mgr;
}

@end
