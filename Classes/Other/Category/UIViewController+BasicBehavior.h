//
//  UIViewController+BasicBehavior.h
//  CDC
//
//  Created by weiwei on 2016/10/25.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPEmptyView.h"
@interface UIViewController (BasicBehavior)
@property (nonatomic, strong) JPEmptyView  *emptyView;

-(void)__doInit;
@end
