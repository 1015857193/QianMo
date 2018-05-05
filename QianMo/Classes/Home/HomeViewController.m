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
#import "YYKit.h"
#import "LYAlertView.h"

NSString *const notiString =@"notiString";


@interface HomeViewController ()<UIWebViewDelegate>{
    
    UIWebView *webView;
}

@property (nonatomic,copy)NSString *string;

@property (nonatomic,assign)BOOL isNetWork;



@end

@implementation HomeViewController


- (void)dealloc{

    [self removeObserver:self forKeyPath:@"isNetWork"];


}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"__%@__%@",[self description],self.string);
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
   self.title =@"首页";
    
   self.string =@"haha";
    
    [self isWifi];
 
    [self addObserver:self forKeyPath:@"isNetWork" options:NSKeyValueObservingOptionNew  context:nil];
   
    HomeModel *model =[[HomeModel alloc]init];
    
    [model update];
    NSLog(@"变不变%@",model.string);
    
    NSMutableArray *array =[NSMutableArray array];
    
    NSURLSessionTask *task =[[NSURLSessionTask alloc]init];
    [array addObject:task];
    
    
  
    
    
    
    
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

- (void)isWifi{



    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //开启监听，记得开启，不然不走block
    [manger startMonitoring];
    //2.监听改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:
                
                _isNetWork =NO;
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                
                _isNetWork =NO;
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                _isNetWork =YES;
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                _isNetWork =YES;
                
                break;
                
            default:
                
                break;
        }
    }];
    
    [manger stopMonitoring];

    
    
    
}


- (void)inputDeviceAction{

  
//    FirstViewController *first =[FirstViewController sharedInstance];
//
//    first.string =self.string;
//
//    [self.navigationController pushViewController:first animated:YES];

//    LYAlertView *alertView =[[LYAlertView alloc]initWithTitle:@"提示" message:@"来消息了" confirmBlock:^(id sender) {
//
//
//        NSLog(@"确定");
//
//
//    } cancelBlock:^(id sender) {
//
//        NSLog(@"取消");
//
//    }];
//
//    [alertView show];
//
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64,Screen_Width,Screen_Height-64)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    webView.opaque = NO;
    webView.scalesPageToFit =YES;
    webView.scrollView.bounces = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.4.216/cch5/index2.html"]]];
    

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
