//
//  CDCDocumentDetailHeader.h
//  CDC
//
//  Created by weiwei on 16/10/9.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDCDocumentDetailHeaderDelegate <NSObject>

- (void)inputTexDocumentDetailView:(UITextField *)text ;
- (void)textFieldShouldReturnTitleView:(UITextField *)text ;

@end

@interface CDCDocumentDetailHeader : UIView
@property (nonatomic, assign) id<CDCDocumentDetailHeaderDelegate> delegate;

@end
