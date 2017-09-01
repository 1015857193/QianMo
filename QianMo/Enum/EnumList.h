//
//  EnumList.h
//  QianMo
//
//  Created by 卢洋 on 16/10/19.
//  Copyright © 2016年 Myself. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, KDriverStatusType) {
    StatusUnCertified = 0,
    StatusCheckPending = 1,
    StatusCertified = 2,
    StatusNotPass = 3
};

//车辆类型
typedef NS_ENUM(NSInteger ,BusType){
    BUS_HighOne = 0,
    BUS_HighTwo,
    BUS_HighThree,
    BUS_Mid
};

//乘座方式
typedef NS_ENUM(NSInteger ,BusTackWay){
    BusTack_Sit = 0,
    BusTack_Sleep
};



@interface EnumList : NSObject

@end
