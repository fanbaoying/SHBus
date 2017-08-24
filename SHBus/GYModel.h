//
//  GYModel.h
//  GYDemo
//
//  Created by Galen on 2017/7/14.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYModel : NSObject

@property (nonatomic , copy ) NSString *title;

@property (nonatomic , copy ) NSString *details;

@property (strong, nonatomic)NSArray *titleArr;


@property (nonatomic , assign ) BOOL isExpand;//是否展开



@end
