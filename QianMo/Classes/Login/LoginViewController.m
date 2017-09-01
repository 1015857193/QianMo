//
//  LoginViewController.m
//  QianMo
//
//  Created by 卢洋 on 16/10/11.
//  Copyright © 2016年 Myself. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfoManager.h"
#import "UserInfo.h"
#import "BaseTabBarController.h"
#import "AppDelegate.h"
#import "RetrievePassViewController.h"

@interface LoginViewController ()

@property (nonatomic,strong)UITextField *numText;
@property (nonatomic,strong)UITextField *passText;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad{

    self.title =@"登录";
    [self loadUI];
    
    
   
    
}

- (void)loadUI{
    
    UIView *topLine =[[UIView alloc]init];
    topLine.backgroundColor =ColorString(@"#9ac6f4");
    [self.view addSubview:topLine];
    
    UIView *centerLine =[[UIView alloc]init];
    centerLine.backgroundColor =ColorString(@"#9ac6f4");
    [self.view addSubview:centerLine];
    
    UIView *bottomLine =[[UIView alloc]init];
    bottomLine.backgroundColor =ColorString(@"#9ac6f4");
    [self.view addSubview:bottomLine];
    
             
    //帐号
    UIImageView *numImg =[[UIImageView alloc]init];
    numImg.layer.cornerRadius =15;
    numImg.layer.masksToBounds =YES;
    numImg.image =[UIImage imageNamed:@"account"];
    [self.view addSubview:numImg];
    
    //密码
    UIImageView *passImg =[[UIImageView alloc]init];
    passImg.layer.cornerRadius =15;
    passImg.layer.masksToBounds =YES;
    passImg.image =[UIImage imageNamed:@"pass"];
    [self.view addSubview:passImg];

    _numText =[[UITextField alloc]init];
    _numText.placeholder =@"输入账号／手机号";
    [_numText setValue:ColorString(@"#9ac6f4") forKeyPath:@"_placeholderLabel.textColor"];
    [_numText setValue:[UIFont systemFontOfSize:14]  forKeyPath:@"_placeholderLabel.font"];
    _numText.font =CustomFont(15);
    [self.view addSubview:_numText];
    
    
    _passText =[[UITextField alloc]init];
    _passText.placeholder =@"输入密码";
    _passText.font =[UIFont systemFontOfSize:14];
   [_passText setValue:ColorString(@"#9ac6f4") forKeyPath:@"_placeholderLabel.textColor"];
    [_passText setValue:[UIFont systemFontOfSize:14]  forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_passText];
    
    UIButton *forgetBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:ColorString(@"#9ac6f4") forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
   
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(93);
        make.height.equalTo(@0.5);
        make.left.equalTo(self.view.mas_left).with.offset(43);
        make.right.equalTo(self.view.mas_right).with.offset(-43);
    }];
    
    [numImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(topLine);
        make.height.width.equalTo(@30);
        make.top.equalTo(topLine.mas_bottom).with.offset(8);
        
    }];
    
    [_numText mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.equalTo(numImg.mas_right).with.offset(12);
        make.right.equalTo(topLine);
        make.height.equalTo(@46);
        make.centerY.equalTo(numImg);
    }];
    
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(numImg);
        make.top.equalTo(numImg.mas_bottom).with.offset(8);
        make.width.height.equalTo(topLine);
    }];
    
    [passImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(centerLine.mas_bottom).with.offset(8);
        make.width.height.centerX.equalTo(numImg);
    }];
    
    [_passText mas_makeConstraints:^(MASConstraintMaker *make) {
        
       
        make.width.height.centerX.equalTo(_numText);
        make.centerY.equalTo(passImg);
        
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(passImg.mas_bottom).with.offset(8);
        make.left.centerX.width.height.equalTo(centerLine);
        
    }];
    
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        
        
    }];
    
    
    
    UIButton *loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.layer.cornerRadius =6;
    loginBtn.layer.masksToBounds =YES;
    [loginBtn setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    loginBtn.backgroundColor =ColorString(@"#5d9fe9");
    [loginBtn addTarget:self action:@selector(logUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(bottomLine.mas_bottom).with.offset(64);
        make.height.equalTo(@40);
        make.left.right.equalTo(bottomLine);
        
    }];
    
    
    UIImageView *signImg =[[UIImageView alloc]init];
    signImg.image =[UIImage imageNamed:@"sign"];
    [self.view addSubview:signImg];
  
    UIImageView *companyImg =[[UIImageView alloc]init];
    companyImg.image =[UIImage imageNamed:@"company"];
    companyImg.layer.cornerRadius =10;
    companyImg.layer.masksToBounds =YES;
    [self.view addSubview:companyImg];
    
    [companyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-21);
        make.left.equalTo(self.view.mas_left).with.offset(135);
        make.right.equalTo(self.view.mas_right).with.offset(-135);
        make.height.equalTo(@20);
        
    }];
    
    [signImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).with.offset(128);
        make.bottom.equalTo(companyImg.mas_top).with.offset(-8);
        make.right.equalTo(self.view.mas_right).with.offset(-128);
        make.height.equalTo(@40);
    }];
    
    
    
}

- (void)forgetAction{

    RetrievePassViewController *viewCtrl =[[RetrievePassViewController alloc]init];
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
    


}

- (void)logUserInfo{
    
  
    
    
    NSString *url = @"/busCompany/login";
    //password md5加密
    NSString *password =[EUnit md5HexDigest:_passText.text];
   
    NSDictionary *param =@{@"phone":_numText.text,
                           @"password":password};
    
   [NetWorkMessage requestWithparam:param Url:url progress:^(NSProgress *progress) {
       
       
   } onSuccess:^(id result) {
       
       if (result) {
         
           if ([[result objectForKey:@"code"] integerValue]==1) {
               
               NSLog(@"成功");
               BaseTabBarController *tabBarCtrl =[[BaseTabBarController alloc]init];
               AppDelegate *appDelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
               appDelegate.window.rootViewController =tabBarCtrl;
               
           }
           
           
           
           
           
  
       }
       
       //登录成功 保存信息
//       [self saveCurrentUserInfo:];
//       
//       BaseTabBarController *tabBarCtrl =[[BaseTabBarController alloc]init];
//       AppDelegate *appDelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
//       appDelegate.window.rootViewController =tabBarCtrl;
       
       
       
    } onFailure:^(NSError *error) {
       
          
   }];
     


}

- (void)saveCurrentUserInfo:(NSMutableDictionary *)dic{

    UserInfo *userInfo =[UserInfo mj_objectWithKeyValues:dic];
    ////持久化 保存数据
    
    
    
    [UserInfoManager shareUserInfoManager].userInfo =userInfo;
    

}

@end
