//
//  UserInfoManager.m
//  QianMo
//
//  Created by 卢洋 on 16/10/11.
//  Copyright © 2016年 Myself. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager

- (instancetype)init{
  
    self=[super init];
    if (self) {
        
        
    }

    return self;

}

+ (UserInfoManager *)shareUserInfoManager{

    static dispatch_once_t onceToken;
    static UserInfoManager *instance;
    dispatch_once(&onceToken, ^{
        
        instance =[[self alloc]init];
    });

    return instance;

}

@end
