//
//  KCMessageHelper.m
//  QMManageApp
//
//  Created by Massimo on 16/1/22.
//  Copyright © 2016年 Massimo. All rights reserved.
//

#import "KCMessageHelper.h"
#import <MessageUI/MessageUI.h>
@interface KCMessageHelper()<MFMessageComposeViewControllerDelegate>
@property (nonatomic, strong)UIViewController *currentVC;
@end
@implementation KCMessageHelper
+(instancetype)shareHelper{
  static KCMessageHelper *manage = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manage = [[KCMessageHelper alloc]init];
  });
  return manage;
}

- (void)sendSystemMessageFromVC:(UIViewController *)vc TagetTels:(NSArray*)tels Message:(NSString *)message{
  self.currentVC = vc;
  
  if ([MFMessageComposeViewController canSendText]) {
    /** 创建短信界面(控制器*/
    MFMessageComposeViewController *controller = [MFMessageComposeViewController new];
    controller.recipients = tels;//短信接受者为一个NSArray数组
    controller.body = message;//短信内容
    controller.messageComposeDelegate = self;//设置代理,代理可不是 controller.delegate = self 哦!!!
    /** 取消按钮的颜色(附带,可不写) */
    controller.navigationBar.tintColor = [UIColor whiteColor];
    [self.currentVC presentViewController:controller animated:YES completion:nil];
  }else{
   // [EUnit showToastWithTitle:@"模拟器不支持发送短信"];
  }
}

#pragma mark - MFMessageComposeViewControllerDelegate
/**
 * 协议方法,在信息界面处理完信息结果时调用(比如点击发送,取消发送,发送失败)
 *
 * @param controller 信息控制器
 * @param result 返回的信息发送成功与否状态
 */
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
  /** 发送完信息就回到原程序*/
  [self.currentVC dismissViewControllerAnimated:YES completion:nil];
  switch (result) {
    case MessageComposeResultSent:
      NSLog(@"发送成功");
      break;
    case MessageComposeResultFailed:
      NSLog(@"发送失败");
      break;
    case MessageComposeResultCancelled:
      NSLog(@"发送取消");
    default:
      break;
  }
}

@end
