//
//  GYHeadView.h
//  GYDemo
//
//  Created by Galen on 2017/7/14.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHeadView : UIView

@property (nonatomic , strong ) UILabel *title;

@property (nonatomic , strong ) UIButton *expandBtn;

@property (nonatomic ,strong) void(^changeSectionExpandedBlock)(void);



@end
