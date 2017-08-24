//
//  FirstTableViewCell.m
//  SHBus
//
//  Created by 范保莹 on 2017/7/11.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.myView = [[UIView alloc]init];
       
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.textAlignment = NSTextAlignmentLeft;
        self.titleLab.font = [UIFont systemFontOfSize:16.0];
    
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.textAlignment = NSTextAlignmentLeft;
        self.contentLab.font = [UIFont systemFontOfSize:16.0];
        
        self.detailLab = [[UILabel alloc]init];
        self.detailLab.textAlignment = NSTextAlignmentLeft;
        self.detailLab.numberOfLines = 0;
        self.detailLab.font = [UIFont systemFontOfSize:16.0];
        
        [self.myView addSubview:_detailLab];
        [self.myView addSubview:_contentLab];
        [self.myView addSubview:_titleLab];
        
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    
    self.titleLab.frame = CGRectMake(10, 10, 30, 30);
    
    self.contentLab.frame = CGRectMake(40, 10, SCREEN_WIDTH/2, 30);
    
    self.detailLab.frame = CGRectMake(40, 40, SCREEN_WIDTH-50, 40);
    
}

@end
