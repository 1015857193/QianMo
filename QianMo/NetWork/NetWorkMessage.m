//
//  NetWorkMessage.m
//  BDPassiontec
//
//  Created by Massimo on 15/8/6.
//  Copyright (c) 2015年 Massimo. All rights reserved.
//

#import "NetWorkMessage.h"
#import "NetWorkManager.h"
//#define TOKENERRORINFO @"token已失效，请重新登录"
@implementation NetWorkMessage

+ (NSURLSessionDataTask *)requestWithparam:(NSDictionary *)param Int:(int)page Url:(NSString *)urlStr progress:(void (^)(NSProgress *))progress onSuccess:(void (^)(id))success onFailure:(void (^)(NSError *))error
{
    
    NetWorkManager *manager = [NetWorkManager shareManager];
    if (param.count == 0) {
        param = nil;
    }
    //添加报文头，md5加密
    [NetWorkMessage setCustomHttpHeader:manager parameters:param];

    
    return nil;
}

#pragma mark 网络请求

+ (NSURLSessionDataTask*)requestWithparam:(NSDictionary *)param
                                      Url:(NSString*)urlStr
                                 progress:(void (^)(NSProgress *)) progress
                                onSuccess:(void (^)(id ))success
                                onFailure:(void (^)(NSError *))failure{
  
  
  NetWorkManager *manager = [NetWorkManager shareManager];
  if (param.count == 0) {
    param = nil;
  }
  //添加报文头，md5加密
  [NetWorkMessage setCustomHttpHeader:manager parameters:param];
    
  return [manager POST:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
      
    if(progress){
      progress(uploadProgress);
    }
      
      
  } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
    
    //    过滤掉返回的数据中NSNull类型的数据  替换为@""
      responseObject = [KHelper changeType:responseObject];
     
      
      if (success) {
          
          success(responseObject);
      }
    
     NSLog(@" \n\n\n 成功：请求地址：%@  \n\n\n 传入: %@ \n\n\n 接收: %@ \n\n\n",task.originalRequest.URL,param,responseObject);
   
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
   
    if (failure) {
        
      failure(error);  
    }
      
    NSLog(@" \n\n\n失败：请求地址：%@  \n\n\n 传入: %@ \n\n\n ==%@ \n\n\n",task.originalRequest.URL,param,error);
      
      
    
  }];
    
    
  
}

+ (NSURLSessionDataTask*)requestWithUrl:(NSString *)urlStr
                               progress:(void (^)(NSProgress *)) progress
                              onSuccess:(void (^)(id))success
                              onFailure:(void (^)(NSError *error))failure{
  NetWorkManager *manager = [NetWorkManager shareManager];
  //添加报文头，md5加密
  [NetWorkMessage setCustomHttpHeader:manager parameters:nil];
  return [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    if(progress){
      progress(downloadProgress);
    }
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
   
      //    过滤掉返回的数据中NSNull类型的数据  替换为@""
    responseObject = [KHelper changeType:responseObject];
    
   
    
    //    code: 1成功 2失败
    
    
   
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
   
    if (failure) {
      failure(error);
    }
  }];
}

+(NSURLSessionDataTask*)requestWithUrl:(NSString *)urlStr
                                 Param:(NSDictionary *)param
                                images:(NSArray <NSData*> *)imageDatas
                              progress:(void (^)(NSProgress *)) progress
                             onSuccess:(void (^)(id))success
                             onFailure:(void (^)(NSError *))failure{
  NetWorkManager* manager = [NetWorkManager shareManager];
  //添加报文头，md5加密
  [NetWorkMessage setCustomHttpHeader:manager parameters:param];
  return [manager POST:urlStr parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    int i = 0;
    for (NSData *item in imageDatas) {
      [formData appendPartWithFormData:item name:[NSString stringWithFormat:@"picture%d",i]];
      i++;
    }
    
  } progress:^(NSProgress * _Nonnull uploadProgress) {
    if(progress){
      progress(uploadProgress);
    }
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
  
    //    过滤掉返回的数据中NSNull类型的数据  替换为@""
    responseObject = [KHelper changeType:responseObject];
    
   
    
    //    code: 1成功 2失败
   
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    
    
  
    if (failure) {
      failure(error);
    }
    
  }];
}

#pragma mark - 私有方法

/**
 *  设置自定义的报文头
 *
 *  @param mgr    AF请求管理器
 *  @param params 参数字典
 */
+(void)setCustomHttpHeader:(NetWorkManager*) mgr parameters:(NSDictionary *)params
{
  @autoreleasepool {
    
//    获取token
    NSString *token = [UserInfoManager shareUserInfoManager].userInfo.token;
    //取得uuid
    NSString *uuid = [EUnit obtainDeviceOpenUUID];
    //取得app版本号
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //取得时间戮  
    NSString *timeStamp = [NSString stringWithFormat:@"%lld", [EUnit currentTimeMillis]];
    NSString *paramStr = @"";
    NSString *tempFmt = nil;
    NSString *comma = @"";
    int i = 0;
    NSString *key;  
    NSString *value;
    //从字典中取出所有的key
    NSArray *myKeys = [params allKeys];
    NSMutableArray *Keys = [NSMutableArray array];
    for(__strong NSString *key in myKeys){
      key = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      [Keys addObject:key];
    }
    //按字母表排序(可无)
    NSArray *sortedKeys = [Keys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *encodeValue = @"";
    //根据key顺序从字典中取得键值对,拼接出半成参数字符串
    for(i = 0; i < sortedKeys.count; ++i)
    {
      key = (NSString *)[sortedKeys objectAtIndex:i];
      value = [params objectForKey:key];
      encodeValue = [NSString stringWithFormat:@"%@", value];//[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      encodeValue = [encodeValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      comma = ((i == 0) ? @"" : @"&");
      tempFmt = [NSString stringWithFormat:@"%@%@=%@", comma, key, encodeValue];
      paramStr = [paramStr stringByAppendingString:tempFmt];
      paramStr = [paramStr stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    }
    
    //platform + appKey + uuid + appVersion + paramStr + timeStamp
    NSString *all = [NSString stringWithFormat:PLAT_FORM_NAME];//PLAT_FORM_NAME === @“iOS”
    all = [all stringByAppendingString:QM_APP_KEY];
    all = [all stringByAppendingString:uuid];
    all = [all stringByAppendingString:appVersion];
    all = [all stringByAppendingString:paramStr];
    all = [all stringByAppendingString:timeStamp];
    
    //得到md5字符串全部小写  
    NSLog(@"\n\n=========md5签名===========\n\n%@\n\n====================\n\n",all);
    NSString *md5 = [EUnit md5HexDigest:all];
    md5 = [md5 lowercaseString];//全部小写全部小写
    //设置签名 
    [mgr.requestSerializer setValue:md5 forHTTPHeaderField:NWP_KEY_SIGNATURE];
    //设置uuid
    [mgr.requestSerializer setValue:uuid forHTTPHeaderField:NWP_KEY_UUID];
    //设置平台
    [mgr.requestSerializer setValue:PLAT_FORM_NAME forHTTPHeaderField:NWP_KEY_PLATFORM];
    //设置版本号
    [mgr.requestSerializer setValue:appVersion forHTTPHeaderField:NWP_KEY_VERSION];
    //设置时间戮 
    [mgr.requestSerializer setValue:timeStamp forHTTPHeaderField:
     NWP_KEY_TIME_STAMP];
    
    if (token) {
      [mgr.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    
    NSLog(@"\n\n=========HTTPRequestHeaders===========\n\n%@\n\n====================\n\n",mgr.requestSerializer.HTTPRequestHeaders);
  }
}

+(void) loginWithPhone:(NSString *)phone
            verifyCode:(NSString *)verifyCode
              progress:(void (^)(NSProgress *)) progress
               success:(void (^)(id response))success
               failure:(void (^)(NSError *err))failure{
  NSDictionary *params = @{@"phone":phone,@"verify_code":verifyCode};
  [NetWorkMessage requestWithparam:params Url:@"/login/driverLogin" progress:progress onSuccess:success onFailure:failure];
}
+(void)loginWithPhone:(NSString *)phone
           verifyCode:(NSString *)verifyCode
              success:(void (^)(id response))success
              failure:(void (^)(NSError *err))failure{
  NSDictionary *params = @{@"phone":phone,@"verify_code":verifyCode};
  [NetWorkMessage requestWithparam:params Url:@"/login/driverLogin" progress:nil onSuccess:success onFailure:failure];
}





@end







