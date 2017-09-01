//
//  Util.h
//  QMManageApp
//
//  Created by 卢洋 on 16/9/13.
//  Copyright © 2016年 Massimo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

//处理十六进制色彩
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (CGSize)sizeOfString:(NSString *)string maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight withFontSize:(CGFloat)fontSize;
@end
