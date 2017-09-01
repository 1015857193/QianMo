//
//  EUnit.h
//  HeMaShop
//
//  Created by BaH Cy on 12/4/15.
//  Copyright © 2015 KZ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum ESizeType
{
    ESizeTypeNone = 0,
    ESizeType3_5,
    ESizeType4_0,
    ESizeType4_7,
    ESizeType5_5,
    ESizeType9_7,
} ESizeType;


@interface EUnit : NSObject



+ (BOOL)requestSuccess:(NSDictionary *)returnDict;

+ (CGFloat)getLenght:(CGFloat)lenght;

+ (CGFloat)getLengthWithSizeType:(ESizeType)sizeType andLength:(CGFloat)length;

+ (UIViewController *)storyBoard:(NSString *)storyBoard indetifier:(NSString *)mIndetifier;


#pragma mark -- time

+ (NSString *)configM:(NSDate *)date;
+ (NSString *)timeYMDZH:(NSDate *)date;
+ (NSString *)timeYM:(NSDate *)date;
+ (NSString *)timeYMD:(NSDate *)date;
+ (NSString *)timeYMDString:(NSDate *)date;
+ (NSString *)timeYMDWithXieGang:(NSDate *)date;
+ (NSString *)timeYMDHMSSSSS:(NSDate *)date;
+ (NSString *)dateString:(NSString*)string;
#pragma mark -- 获取当前时间戳
+(long long)currentTimeMillis;

#pragma mark -- NSuserDefaul本地缓存
+(void)SaveValue:(id)value ToKey:(NSString *)key;
+(NSString *)GetStringFromUserDefaulWithKey:(NSString *)key;
+(NSMutableDictionary *)GetMutableDictFromUserDefaulWithKey:(NSString *)key;
#pragma mark -- 取得md5的值
+(NSString *)md5HexDigest:(NSString*)input;

#pragma mark -- 取得mac地址
+(NSString *)obtainMacAddress;

#pragma mark -- 取得设备UUID
+(NSString *)obtainDeviceOpenUUID;



@end
