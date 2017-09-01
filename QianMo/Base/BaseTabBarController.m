//
//  MainTabBarController.m
//  QianMo
//
//  Created by 卢洋 on 16/9/26.
//  Copyright © 2016年 Myself. All rights reserved.
//

#import "BaseTabBarController.h"
#import "HomeViewController.h"
#import "DriverViewController.h"
#import "DeviceViewController.h"
#import "PersonViewController.h"
#import "BaseNavigationController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

+ (void)initialize{
  
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildrenViewCtrlWithClassName:[HomeViewController description] imageName:@"home" title:@"首页"];
    [self addChildrenViewCtrlWithClassName:[DriverViewController description] imageName:@"Found" title:@"司机"];
    [self addChildrenViewCtrlWithClassName:[DeviceViewController description] imageName:@"audit" title:@"设备"];
    [self addChildrenViewCtrlWithClassName:[PersonViewController description] imageName:@"newstab" title:@"个人"];
    
    
}


// 添加子控制器
- (void)addChildrenViewCtrlWithClassName:(NSString *)classname
                               imageName:(NSString *)imagename
                                   title:(NSString *)title{

    UIViewController *viewCtrl =[[NSClassFromString(classname) alloc]init];
    
    BaseNavigationController *navigationViewCtrl =[[BaseNavigationController alloc]initWithRootViewController:viewCtrl];
    navigationViewCtrl.tabBarItem.title =title;
    navigationViewCtrl.tabBarItem.image =[UIImage imageNamed:imagename];
    navigationViewCtrl.tabBarItem.selectedImage =[[UIImage imageNamed:[imagename stringByAppendingString:@"_press"]]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:navigationViewCtrl];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
