//
//  RertivePassViewController.m
//  QianMo
//
//  Created by 卢洋 on 16/10/21.
//  Copyright © 2016年 Myself. All rights reserved.
//

#import "RetrievePassViewController.h"

@interface RetrievePassViewController ()

@property (nonatomic,strong)UITextField *numText;
@property (nonatomic,strong)UITextField *passText;
@property (nonatomic,strong)UITextField *safeText;

@end

@implementation RetrievePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title =@"找回密码";
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
    
    UIView *safeLine =[[UIView alloc]init];
    safeLine.backgroundColor =ColorString(@"#9ac6f4");
    [self.view addSubview:safeLine];
    
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
    
    UIImageView *safeImg =[[UIImageView alloc]init];
    safeImg.layer.cornerRadius =15;
    safeImg.layer.masksToBounds =YES;
    safeImg.image =[UIImage imageNamed:@"safe"];
    [self.view addSubview:safeImg];
    
    _numText =[[UITextField alloc]init];
    _numText.placeholder =@"输入账号／手机号";
    [_numText setValue:ColorString(@"#9ac6f4") forKeyPath:@"_placeholderLabel.textColor"];
    [_numText setValue:[UIFont systemFontOfSize:14]  forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_numText];
    
    
    _passText =[[UITextField alloc]init];
    _passText.placeholder =@"输入密码";
    _passText.font =[UIFont systemFontOfSize:14];
    [_passText setValue:ColorString(@"#9ac6f4") forKeyPath:@"_placeholderLabel.textColor"];
    [_passText setValue:[UIFont systemFontOfSize:14]  forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_passText];

    _safeText =[[UITextField alloc]init];
    _safeText.placeholder =@"验证码";
    _safeText.font =[UIFont systemFontOfSize:14];
    [_safeText setValue:ColorString(@"#9ac6f4") forKeyPath:@"_placeholderLabel.textColor"];
    [_safeText setValue:[UIFont systemFontOfSize:14]  forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_safeText];
    
    UIButton *authBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [authBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
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
