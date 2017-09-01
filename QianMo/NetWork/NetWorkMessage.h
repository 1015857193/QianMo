//
//  NetWorkMessage.h
//  BDPassiontec
//
//  Created by Massimo on 15/8/6.
//  Copyright (c) 2015年 Massimo. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@class RequestList;


@interface NetWorkMessage : AFHTTPSessionManager

+ (NSURLSessionDataTask *)requestWithparam:(NSDictionary*)param
                                       Int:(int)page
                                     Url:(NSString *)urlStr
                                progress:(void (^)(NSProgress *progress))progress
                               onSuccess:(void (^)(id result))success
                               onFailure:(void (^)(NSError *error))error;

/**
 *  网络请求
 *
 *  @param param   参数
 *  @param urlStr  接口
 *  @param success <#success description#>
 */
+ (NSURLSessionDataTask*)requestWithparam:(NSDictionary*)param
                                      Url:(NSString*)urlStr
                                 progress:(void (^)(NSProgress *progress))progress
                                onSuccess:(void(^)(id result))success
                                onFailure:(void(^)(NSError *error))error;
/**
 *  无参数网络请求
 *
 *  @param urlStr  接口
 *  @param success success description
 */
+ (NSURLSessionDataTask*)requestWithUrl:(NSString*)urlStr
                               progress:(void (^)(NSProgress *progress)) progress
                              onSuccess:(void (^)(id result))success
                              onFailure:(void (^)(NSError *error))failure;
/**
 *  带图片的网络请求
 *
 *  @param urlStr    接口
 *  @param param     参数
 *  @param imageData 图片信息
 *  @param success   成功
 */
+(NSURLSessionDataTask*)requestWithUrl:(NSString *)urlStr
                Param:(NSDictionary *)param
               images:(NSArray <NSData*> *)imageDatas
             progress:(void (^)(NSProgress *progress)) progress
            onSuccess:(void (^)(id result))success
            onFailure:(void (^)(NSError *error))failure;
/**
 *  测试接口，为登录司机端
 *
 *  @param phone      手机号
 *  @param verifyCode 验证码
 *  @param success
 *  @param failure    
 */
+(void)loginWithPhone:(NSString *)phone
            verifyCode:(NSString *)verifyCode
              progress:(void (^)(NSProgress *)) progress
               success:(void (^)(id response))success
               failure:(void (^)(NSError *err))failure;
+(void)loginWithPhone:(NSString *)phone
           verifyCode:(NSString *)verifyCode
              success:(void (^)(id response))success
              failure:(void (^)(NSError *err))failure;
@end


