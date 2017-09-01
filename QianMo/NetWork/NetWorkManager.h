//
//  NetWorkManager.h
//  BDPassiontec
//
//  Created by Massimo on 15/8/6.
//  Copyright (c) 2015年 Massimo. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetWorkManager : AFHTTPSessionManager

+ (instancetype)shareManager;
@end
