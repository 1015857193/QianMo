//
//  Util.m
//  QMManageApp
//
//  Created by 卢洋 on 16/9/13.
//  Copyright © 2016年 Massimo. All rights reserved.
//

#import "Util.h"
#define CR_COLOR(RED, GREEN, BLUE, ALPHA)	[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA]
@implementation Util

//处理十六进制色彩
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert{
    if (stringToConvert.length ==0) {
        
        return nil;
    }else{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return CR_COLOR(((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f), 1);
    }
    
    return nil;
}
+ (CGSize)sizeOfString:(NSString *)string maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight withFontSize:(CGFloat)fontSize{
   
    CGSize size = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                       options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                    attributes:attribute context:nil];//ios9 字体偏大，计算不太准确  CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
    size = rect.size;
    return size;
}


@end
