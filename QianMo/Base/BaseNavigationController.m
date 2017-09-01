//
//  BaseNavigationController.m
//  QianMo
//
//  Created by 卢洋 on 16/10/11.
//  Copyright © 2016年 Myself. All rights reserved.
//

#import "BaseNavigationController.h"
#define kFont(size)  [UIFont systemFontOfSize:size]
@implementation BaseNavigationController

+ (void)initialize{

    [[UINavigationBar appearance] setTranslucent:NO]; // 设置为不透明
     // 设置导航栏背景颜色
    [UINavigationBar appearance].barTintColor =[UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f];
    // 设置导航栏标题文字颜色
    // 创建字典保存文字大小和颜色
    NSMutableDictionary * color = [NSMutableDictionary dictionary];
    color[NSFontAttributeName] = kFont(20.0f);
//    color[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];;
    color[NSForegroundColorAttributeName] =ColorString(@"#ffffff");
    [[UINavigationBar appearance] setTitleTextAttributes:color];
   
    // 拿到整个导航控制器的外观
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    item.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    // 设置字典的字体大小
    NSMutableDictionary * atts = [NSMutableDictionary dictionary];
    
    atts[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    atts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    // 将字典给item
    [item setTitleTextAttributes:atts forState:UIControlStateNormal];
    
    
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.viewControllers.count >0) {
        
        /**
         *  如果在堆栈控制器数量大于1 加返回按钮
         */
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btn setImage:[UIImage imageNamed:@"back_neihan"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
        btn.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = leftItem;

    }else{
    
          
     
    }
    
    
    [super pushViewController:viewController animated:animated];


}

@end
