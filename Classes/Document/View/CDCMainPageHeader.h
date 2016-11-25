//
//  CDCMainPageView.h
//  CDC
//
//  Created by 刘维 on 2016/10/7.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDCMainPageHeader ;

@protocol CDCMainPageHeaderDelegate <NSObject>

- (void)mainTitleView:(UIButton *)sender clickIndex:(NSInteger)index;

- (void)inputTextMainTitleView:(UITextField *)text ;

- (void)textFieldShouldReturnTitleView:(UITextField *)text ;

@end

@interface CDCMainPageHeader : UIView

@property (nonatomic, assign) id<CDCMainPageHeaderDelegate> delegate;

@property (nonatomic, assign) NSInteger selecteIndex;
@end
