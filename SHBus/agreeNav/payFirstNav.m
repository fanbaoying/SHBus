//
//  payFirstNav.m
//  agreePay
//
//  Created by 范保莹 on 2017/4/21.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "payFirstNav.h"

@implementation payFirstNav

- (instancetype)initWithLeftBtn:(NSString *)leftBtn andWithTitleLab:(NSString *)titleLab andWithRightBtn:(NSString *)rightBtn andWithBgImg:(UIImageView *)bgImg{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    if (self) {
        
        self.bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        self.bgImg.backgroundColor = navColor;
        //        self.bgImg.backgroundColor = [UIColor clearColor];
        [self addSubview:_bgImg];
        
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-SCREEN_WIDTH/6, 20, SCREEN_WIDTH/3, 44)];
        self.titleLab.backgroundColor = [UIColor clearColor];
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleLab.font = [UIFont systemFontOfSize:17.0];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.text = titleLab;
        [self addSubview:_titleLab];

        self.leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        self.leftBtn.backgroundColor = [UIColor clearColor];
        [self.leftBtn setBackgroundImage:[UIImage imageNamed:leftBtn] forState:UIControlStateNormal];
        [self addSubview:_leftBtn];

        self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-44, 20, 44, 44)];
        self.rightBtn.backgroundColor = [UIColor clearColor];
        [self.rightBtn setTitle:rightBtn forState:0];
        [self addSubview:_rightBtn];
  
    }
    return self;
}

@end
