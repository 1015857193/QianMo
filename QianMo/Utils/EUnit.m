//
//  EUnit.m
//  HeMaShop
//
//  Created by BaH Cy on 12/4/15.
//  Copyright © 2015 KZ. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "EUnit.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "sys/utsname.h"
@implementation EUnit

+ (CGFloat)getLengthWithSizeType:(ESizeType)sizeType andLength:(CGFloat)length
{
    CGFloat resultLength = length * [[self multiplicative][@([self getCurrentSizeType])] doubleValue] / [[self multiplicative][@(sizeType)] doubleValue];
    resultLength = ceil(resultLength);
    return resultLength;
}

+ (ESizeType)getCurrentSizeType
{
    static ESizeType currentSizeType = ESizeTypeNone;
    
    if (currentSizeType == ESizeTypeNone) {
        if (ISIPHONE3_5) {
            currentSizeType = ESizeType3_5;
        }
        else if (ISIPHONE4_0) {
            currentSizeType = ESizeType4_0;
        }
        else if (ISIPHONE4_7) {
            currentSizeType = ESizeType4_7;
        }
        else if (ISIPHONE5_5) {
            currentSizeType = ESizeType5_5;
        }
        else if (ISIPHONE9_7) {
            currentSizeType = ESizeType9_7;
        }
    }
    
    return currentSizeType;
}

+ (NSDictionary *)multiplicative
{
    return @{@0:@0,
             @1:@320,
             @2:@320,
             @3:@375,
             @4:@414,
             @5:@768};
}

+ (BOOL)requestSuccess:(NSDictionary *)returnDict
{
    return [returnDict[@"State"] description].integerValue == 200;
}

+ (CGFloat)getLenght:(CGFloat)lenght
{
   return  [EUnit getLengthWithSizeType:ESizeType4_7 andLength:lenght];
}

+ (UIViewController *)storyBoard:(NSString *)mStoryBoard indetifier:(NSString *)mIndetifier;
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:mStoryBoard bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:mIndetifier];
}


#pragma mark- time

+(NSString *)dateString:(NSString *)string{
  string = [string stringByReplacingOccurrencesOfString:@"年" withString:@""];
  string = [string stringByReplacingOccurrencesOfString:@"月" withString:@""];
  string = [string stringByReplacingOccurrencesOfString:@"日" withString:@""];
  return string;
}

+ (NSString *)timeYMDHMSSSSS:(NSDate *)date
{
  NSDateFormatter *matter = [[NSDateFormatter alloc] init];
  [matter setDateStyle:NSDateFormatterFullStyle];
  [matter setDateFormat:@"yyyyMMddHHmmss"];       //2014-03-18 下午 7:27:41
  [matter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
  return [matter stringFromDate:date];
}
+ (NSString *)timeYMD:(NSDate *)date;
{
  NSDateFormatter *matter = [[NSDateFormatter alloc] init];
  [matter setDateStyle:NSDateFormatterFullStyle];
  [matter setDateFormat:@"yyyy-MM-dd"];
  [matter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
  return [matter stringFromDate:date];
}
+ (NSString *)timeYMDString:(NSDate *)date{
  NSDateFormatter *matter = [[NSDateFormatter alloc] init];
  [matter setDateStyle:NSDateFormatterFullStyle];
  [matter setDateFormat:@"yyyyMMdd"];
  [matter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
  return [matter stringFromDate:date];
}
+ (NSString *)configM:(NSDate *)date{
  NSDateFormatter *matter = [[NSDateFormatter alloc] init];
  [matter setDateStyle:NSDateFormatterFullStyle];
  [matter setDateFormat:@"MM"];
  [matter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
  return [matter stringFromDate:date];
}
+ (NSString *)timeYMDZH:(NSDate *)date{
  NSDateFormatter *matter = [[NSDateFormatter alloc] init];
  [matter setDateStyle:NSDateFormatterFullStyle];
  [matter setDateFormat:@"yyyy年MM月dd日"];
  [matter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
  return [matter stringFromDate:date];
}

+ (NSString *)timeYM:(NSDate *)date{
  NSDateFormatter *matter = [[NSDateFormatter alloc] init];
  [matter setDateStyle:NSDateFormatterFullStyle];
  [matter setDateFormat:@"yyyy年MM月"];
  [matter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
  return [matter stringFromDate:date];
}
+ (NSString *)timeYMDWithXieGang:(NSDate *)date
{
  NSDateFormatter *matter = [[NSDateFormatter alloc] init];
  [matter setDateStyle:NSDateFormatterFullStyle];
  [matter setDateFormat:@"yyyy/MM/dd"];
  [matter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
  return [matter stringFromDate:date];
}

+(NSString *)GetStringFromUserDefaulWithKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *string = [user valueForKey:key];
    return string;
}
+(NSMutableDictionary *)GetMutableDictFromUserDefaulWithKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[user valueForKey:key]];
    return dict;
}
+(void)SaveValue:(id)value ToKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:value forKey:key];
    [user synchronize];
}
/**
 *  取得md5的值
 *
 *  @param input 源字符串
 *
 *  @return 源字符串的md5值
 */
+(NSString *)md5HexDigest:(NSString*)input
{
    @autoreleasepool
    {
        const char* str = [input UTF8String];
        unsigned char result[CC_MD5_DIGEST_LENGTH];
        CC_MD5(str, (CC_LONG)strlen(str), result);
        NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
        //将md5字符串转为小写16进制字符串,不足两位的用零填充
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        {
            [ret appendFormat:@"%02x", result[i]];
        }
        
        return ret;
    }
}
/**
 *  取得当前系统的时刻
 *
 *  @return 当前系统的时刻
 */
+(long long)currentTimeMillis
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    double i = time;      //NSTimeInterval返回的是double类型
    long long result = (long long)(i);
    return result;
}
/**
 *  取得mac地址
 *
 *  @return mac地址字符串
 */
+(NSString *)obtainMacAddress
{
    @autoreleasepool {
        int                    mib[6];
        size_t                 len;
        char                   *buf;
        unsigned char          *ptr;
        struct if_msghdr       *ifm;
        struct sockaddr_dl     *sdl;
        
        mib[0] = CTL_NET;
        mib[1] = AF_ROUTE;
        mib[2] = 0;
        mib[3] = AF_LINK;
        mib[4] = NET_RT_IFLIST;
        
        if ((mib[5] = if_nametoindex("en0")) == 0) {
            NSLog(@"if_nametoindex error\n");
            return NULL;
        }
        
        if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
            NSLog(@"sysctl, take 1\n");
            return NULL;
        }
        
        if ((buf = malloc(len)) == NULL) {
            NSLog(@"Could not allocate memory. error!\n");
            return NULL;
        }
        
        if (sysctl(mib, 6, buf, &len, NULL, 0) > 0) {
            free(buf);
            NSLog(@"sysctl, take 2");
            return NULL;
        }
        
        ifm = (struct if_msghdr *)buf;
        sdl = (struct sockaddr_dl *)(ifm + 1);
        ptr = (unsigned char *)LLADDR(sdl);
        NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x",
                               *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
        free(buf);
        
        return [outstring uppercaseString];
    }
}
/**
 *  取得设备UUID
 *
 *  @return UUID字符串
 */
+(NSString *)obtainDeviceOpenUUID {
    @autoreleasepool {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSString *uuid = nil;
#define UUID_NAME (@"QM_UUID")
        uuid = [userDefaultes objectForKey:UUID_NAME];
        if (!uuid )
        {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0)
            {
                uuid = [EUnit obtainMacAddress]; // 6.0以前用MAC地址作为UID
            }
            else
            {
                // identifierForVendor 6.0后可用
                uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            }
            [userDefaultes setObject:uuid forKey:UUID_NAME];
            //这里建议同步存储到磁盘中，但是不是必须的
            [userDefaultes synchronize];
            userDefaultes = nil;
            return uuid;
        }
        else
        {
            return uuid;
        }
    }
}
@end
