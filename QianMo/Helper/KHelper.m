//
//  KHelper.m
//  QMManageApp
//
//  Created by Massimo on 16/1/22.
//  Copyright © 2016年 Massimo. All rights reserved.
//

#import "KHelper.h"

@implementation KHelper


#pragma mark - 私有方法
//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
  NSArray *keyArr = [myDic allKeys];
  NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
  for (int i = 0; i < keyArr.count; i ++)
  {
    id obj = [myDic objectForKey:keyArr[i]];
    
    obj = [self changeType:obj];
    
    [resDic setObject:obj forKey:keyArr[i]];
  }
  return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
  NSMutableArray *resArr = [[NSMutableArray alloc] init];
  for (int i = 0; i < myArr.count; i ++)
  {
    id obj = myArr[i];
    
    obj = [self changeType:obj];
    
    [resArr addObject:obj];
  }
  return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
  return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
  return @"";
}

+(NSString *)numToString:(id)obj{
  return ((NSNumber*)obj).stringValue;
}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
  
  if ([myObj isKindOfClass:[NSDictionary class]])
  {
    return [self nullDic:myObj];
  }
  else if([myObj isKindOfClass:[NSArray class]])
  {
    return [self nullArr:myObj];
  }
  else if([myObj isKindOfClass:[NSString class]])
  {
    return [self stringToString:myObj];
  }
  else if([myObj isKindOfClass:[NSNull class]])
  {
    return [self nullToString];
  }
  else if([myObj isKindOfClass:[NSNumber class]])
  {
    return [self numToString:myObj];
  }
  else
  {
    return myObj;
  }
}





+ (NSDictionary *)dateInfoForDateString:(NSString *)string{
  
  NSMutableDictionary *dateInfo = [NSMutableDictionary new];
  
  NSString *year = [string substringWithRange:NSMakeRange(0, 4)];
  [dateInfo setObject:year forKey:@"yearstr"];
  if ([string containsString:@"月"]) {
    NSString *month = [string substringWithRange:NSMakeRange(5, 2)];
    [dateInfo setObject:month forKey:@"monthstr"];
  }
  
  if ([string containsString:@"日"]) {
    NSString *day =[string substringWithRange:NSMakeRange(8, 2)];
    [dateInfo setObject:day forKey:@"daystr"];
  }
  
  return dateInfo;
}



+ (NSString*)configStringWithStatus:(KDriverStatusType)type{
  NSString *reuslt ;
  switch (type) {
    case StatusNotPass:
      reuslt = @"未通过";
      break;
    case StatusCertified:
      reuslt = @"已认证";
      break;
    case StatusUnCertified:
      reuslt = @"未认证";
      break;
    case StatusCheckPending:
      reuslt = @"待审核";
      break;
    default:
      break;
  }
  return reuslt;
}

+ (NSString *)busTypeWithType:(BusType)type{
  NSString *bus ;
  
  switch (type) {
    case BUS_Mid:
      bus = @"中级";
      break;
    case BUS_HighOne:
      bus = @"高一级";
      break;
    case BUS_HighTwo:
      bus = @"高二级";
      break;
    case BUS_HighThree:
      bus = @"高三级";
      break;
    default:
      break;
  }
  return bus;
}

+ (NSString *)busTackWayWithType:(BusTackWay)type{
  NSString *way ;
  
  switch (type) {
    case BusTack_Sit:
      way = @"坐席";
      break;
     
    case BusTack_Sleep:
      way = @"卧铺";
      break;
    default:
      break;
  }
  return way;
  
}


+(NSString *)transformCityWithID:(NSString *)cityId{
    if(!cityId) return @"";
    NSString *json2 = [[NSBundle mainBundle] pathForResource:@"city"
                                                      ofType:@"geojson"];
    NSData *data2 = [NSData dataWithContentsOfFile:json2];
    NSArray *cityArray = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
    for(NSDictionary *dict in cityArray){
        NSString *city_id = [NSString stringWithFormat:@"%ld",[[dict valueForKey:@"city_id"] integerValue]];
        if([city_id isEqualToString:cityId]){

            NSString *cityStr = [dict valueForKey:@"city_name"];
            return cityStr;
        }
    }
    return @"";
}
+(NSString *)transformProvinceWithID:(NSString *)provinceId{
    if(!provinceId) return @"未知";
    NSString *jsonPath=[[NSBundle mainBundle] pathForResource:@"province" ofType:@"geojson"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSArray *proArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    for(NSDictionary *dict in proArray){
        NSString *province_id = [NSString stringWithFormat:@"%ld",[[dict valueForKey:@"city_id"] integerValue]];
        if([province_id isEqualToString:provinceId]){
            return [dict valueForKey:@"city_name"];
        }
    }
    return @"未知";
}
+(NSString *)transformIDWithProvinceName:(NSString *)provinceName CityName:(NSString *)cityName areaName:(NSString *)areaName{
    NSString *province = @"";
    NSString *city = @"";
    NSString *area = @"";
    NSString *provinceJson = [[NSBundle mainBundle] pathForResource:@"province"
                                                ofType:@"geojson"];
    NSData *data = [NSData dataWithContentsOfFile:provinceJson];
    NSArray *provinceArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    for(NSDictionary *dict in provinceArray){
        if([[dict valueForKey:@"city_name"] isEqualToString:provinceName]){
           province = [NSString stringWithFormat:@"%ld",[[dict valueForKey:@"city_id"] integerValue]];
            break;
        }
    }
    
    NSString *cityJson = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"geojson"];
    NSData *data2 = [NSData dataWithContentsOfFile:cityJson];
    NSArray *cityArray = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
    for(NSDictionary *dict in cityArray){
        if([[dict valueForKey:@"city_name"] isEqualToString:cityName]){
            city = [NSString stringWithFormat:@"%ld",[[dict valueForKey:@"city_id"] integerValue]];
            
            break;
        }
    }
    NSString *countyJson = [[NSBundle mainBundle] pathForResource:@"county" ofType:@"geojson"];
    NSData *data3 = [NSData dataWithContentsOfFile:countyJson];
    NSArray *countArray = [NSJSONSerialization JSONObjectWithData:data3 options:NSJSONReadingMutableLeaves error:nil];
    areaName = areaName.length<=2?areaName:[areaName substringToIndex:areaName.length];
    for(NSDictionary *dict in countArray){
        
        if([[dict valueForKey:@"city_name"] isEqualToString:areaName]){
            area = [NSString stringWithFormat:@"%ld",[[dict valueForKey:@"city_id"] integerValue]];
            break;
        }
    }
    
    return [NSString stringWithFormat:@"%@,%@,%@",province,city,area];
}
@end
