//
//  UIViewController+BasicBehavior.m
//  CDC
//
//  Created by weiwei on 2016/10/25.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "UIViewController+BasicBehavior.h"
#import <objc/runtime.h>

static const void *UIViewControllerEmptyViewKey = &UIViewControllerEmptyViewKey;

@implementation UIViewController (BasicBehavior)

-(JPEmptyView *)emptyView {
    return objc_getAssociatedObject(self, UIViewControllerEmptyViewKey);
}

-(void)setEmptyView:(JPEmptyView *)emptyView {
    objc_setAssociatedObject(self, UIViewControllerEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)__doInit {
    //    self.apiQueue = [NSMutableArray array];
    //    self.observerQueue = [NSMutableArray array];
    //
    JPEmptyView *emptyView = [JPEmptyView new];
//    emptyView.backgroundColor = [JPDesignSpec colorSilver];
    self.emptyView = emptyView;
    
    //    JPLoadingView *loadingView = [JPLoadingView new];
    //    loadingView.backgroundColor = [JPDesignSpec colorSilver];
    //    self.loadingView = loadingView;
    //
    //    self.view.backgroundColor = [JPDesignSpec colorSilver];
    //
    //    DDLogDebug(@"Creating [%@] object...", NSStringFromClass([self class]));
}
@end
