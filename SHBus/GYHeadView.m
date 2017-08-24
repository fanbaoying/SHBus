//
//  GYHeadView.m
//  GYDemo
//
//  Created by Galen on 2017/7/14.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYHeadView.h"

@implementation GYHeadView


-(instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame])
    {
    
        self.backgroundColor=[UIColor lightGrayColor];
        
        [self addSubview:self.title];
        
        [self addSubview:self.expandBtn];
        
        
    }
    
    return self;
    
}


-(UILabel *)title
{

 if (!_title)
 {
     _title=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, CGRectGetWidth(self.frame)-60, 40)];
     
     
     
 }
    
    return _title;
}


-(UIButton *)expandBtn
{

    if (!_expandBtn)
    {
        _expandBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-40,0 , 40, 40)];
        
        [_expandBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_expandBtn setTitle:@"展开" forState:UIControlStateNormal];
        [_expandBtn setTitle:@"收起" forState:UIControlStateSelected];
        
        [_expandBtn addTarget:self action:@selector(touchupExpandButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _expandBtn;
}


-(void)touchupExpandButton
{

    
if (self.changeSectionExpandedBlock)
{
    
    self.expandBtn.selected=!self.expandBtn.selected;
    
    self.changeSectionExpandedBlock();
    
}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
