//
//  NetWorkManager.m
//  BDPassiontec
//
//  Created by Massimo on 15/8/6.
//  Copyright (c) 2015年 Massimo. All rights reserved.
//

#import "NetWorkManager.h"
#import "AFNetworking.h"
@implementation NetWorkManager
+ (instancetype)shareManager{
  static NetWorkManager *_manager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
  
    _manager =[[NetWorkManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
   // _manager.requestSerializer =[AFJSONRequestSerializer serializer];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.requestSerializer.timeoutInterval = 30;
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"text/html",@"text/plain", nil];
      
  });

  return _manager;
}


@end
