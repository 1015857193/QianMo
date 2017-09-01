//
//  KCMessageHelper.h
//  QMManageApp
//
//  Created by Massimo on 16/1/22.
//  Copyright © 2016年 Massimo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCMessageHelper : NSObject
+(instancetype)shareHelper;
/**
 *  发送手机短信
 *
 *  @param vc      当前控制器
 *  @param tels    短信接受者 为一个NSArray数组
 *  @param message 消息内容
 */
- (void)sendSystemMessageFromVC:(UIViewController *)vc TagetTels:(NSArray*)tels Message:(NSString *)message;
@end
