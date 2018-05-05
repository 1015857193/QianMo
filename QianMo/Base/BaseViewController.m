//
//  BaseViewController.m
//  QianMo
//
//  Created by 卢洋 on 16/9/26.
//  Copyright © 2016年 Myself. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor =ColorString(@"#3ca3db");
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent]; 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
