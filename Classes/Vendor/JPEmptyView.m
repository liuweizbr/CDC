//
//  JPEmptyView.m
//  DymIOSApp
//
//  Created by Dong Yiming on 15/9/28.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import "JPEmptyView.h"
//#import <Masonry/Masonry.h>
//#import "JPDesignSpec.h"

@implementation JPEmptyView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self doInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doInit];
    }
    return self;
}

-(void)doInit {
    self.backgroundColor = [UIColor colorWithWhite:238/255.0 alpha:1];
    
    _ivLogo = [UIImageView new];
    _ivLogo.image = [UIImage imageNamed:@"login_logo"];
    [self addSubview:_ivLogo];
//    [_ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mas_centerX).offset(0);
//        make.centerY.equalTo(self.mas_centerY).offset(-50);
//        make.width.and.height.equalTo(@40);
//    }];
    
    [_ivLogo autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:-40] ;
    [_ivLogo autoAlignAxis:ALAxisVertical toSameAxisOfView:self] ;
    [_ivLogo autoSetDimension:ALDimensionHeight toSize:40] ;
    [_ivLogo autoSetDimension:ALDimensionWidth toSize:40] ;

    
    
    _lblMessage = [UILabel new];
//    _lblMessage.font = [JPDesignSpec fontNormal];
    _lblMessage.textColor = [UIColor colorWithWhite:0 alpha:0.4];
    _lblMessage.textAlignment = NSTextAlignmentCenter;
    _lblMessage.numberOfLines = 0;
    [self addSubview:_lblMessage];
//    [_lblMessage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.and.trailing.equalTo(self).insets(UIEdgeInsetsMake(0, 40, 0, 40));
//        make.top.equalTo(_ivLogo.mas_bottom).offset(10);
//    }];
    
    [_lblMessage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_ivLogo withOffset:10] ;
    [_lblMessage autoAlignAxis:ALAxisVertical toSameAxisOfView:_ivLogo] ;
    
    
    
    _lblMessage.text = @"暂无数据";
}

-(void)show:(BOOL)show {
    [self show:show withText:_lblMessage.text];
}

-(void)show:(BOOL)show withText:(NSString *)text {
    
    self.hidden = !show;
    _lblMessage.text = text;
    
    if (show) {
        [self.superview bringSubviewToFront:self];
    } else {
        [self.superview sendSubviewToBack:self];
    }
}

@end
