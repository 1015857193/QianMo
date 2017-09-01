//
//  HomeViewController.m
//  QianMo
//
//  Created by 卢洋 on 16/9/26.
//  Copyright © 2016年 Myself. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "FirstViewController.h"
#import <YYKit.h>
#import "ZYCacheHelper.h"

@interface HomeViewController ()

@property (nonatomic,strong)NSString *string;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title =@"首页";
    
   
    HomeModel *model =[[HomeModel alloc]init];
    
    [model update];
    NSLog(@"变不变%@",model.string);
    
    NSMutableArray *array =[NSMutableArray array];
    
    NSURLSessionTask *task =[[NSURLSessionTask alloc]init];
    [array addObject:task];
    
    
    [[ZYCacheHelper sharedInstance] saveResponseCache:array forKey:@"cacheArray"];
    
    NSLog(@"___%ld",array.count);
    
    
    
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(100, 100, 40, 40);
    btn.backgroundColor =[Util colorWithHexString:@"#31a8e5"];
    btn.layer.cornerRadius =5;
    btn.layer.masksToBounds =YES;
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:[Util colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont systemFontOfSize:18];
    [btn addTarget:self action:@selector(inputDeviceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
   
}


- (void)inputDeviceAction{

  
    FirstViewController *first =[[FirstViewController alloc]init];
    
    [self.navigationController pushViewController:first animated:YES];





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
