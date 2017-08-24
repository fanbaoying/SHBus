//
//  UILabel+LabelHeightAndWidth.h
//  agreePay
//
//  Created by 范保莹 on 2017/6/8.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelHeightAndWidth)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

@end
