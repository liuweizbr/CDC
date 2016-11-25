//
//  CDCDocumentPageView.h
//  CDC
//
//  Created by weiwei on 16/10/9.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDCDocumentPageView ;

@protocol CDCDocumentPageViewDelegate <NSObject>

-(void)mainTitleView:(CDCDocumentPageView *)view clickIndex:(NSInteger)index;

@end

@interface CDCDocumentPageView : UIView


@property (nonatomic, assign) id<CDCDocumentPageViewDelegate> delegate;

@property (nonatomic, assign) NSInteger selecteIndex;
@end
