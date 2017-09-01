//
//  KHelper.h
//  QMManageApp
//
//  Created by Massimo on 16/1/22.
//  Copyright © 2016年 Massimo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHelper : NSObject
#pragma mark - 过滤json中的Null类型
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj;


+(NSDictionary*)dateInfoForDateString:(NSString*)string;
+(NSString*)configStringWithStatus:(KDriverStatusType)type;
+(NSString *)transformCityWithID:(NSString *)cityId;
+(NSString *)transformProvinceWithID:(NSString *)provinceId;
+(NSString *)transformIDWithProvinceName:(NSString *)provinceName CityName:(NSString *)cityName areaName:(NSString *)areaName;


+ (NSString *)busTypeWithType:(BusType) type;

+ (NSString *)busTackWayWithType:(BusTackWay) type;

+ (NSArray *)citysFromDevices:(NSArray*)devices;

@end
