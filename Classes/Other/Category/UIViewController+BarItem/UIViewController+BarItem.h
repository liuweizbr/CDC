//
//  UIViewController+BarItem.h
//  KnightIsland
//
//  Created by shscce on 15/6/8.
//  Copyright (c) 2015年 shscce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BarItem)


- (void)setNavgationTitle:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font;

- (UIBarButtonItem *)itemWithTitle:(NSString *)title action:(SEL)action;
- (UIBarButtonItem *)itemWithImage:(UIImage *)image action:(SEL)action;


//配置左侧按钮
- (void)setLeftItemWithTitle:(NSString *)title action:(SEL)action;
- (void)setLeftItemWithImageName:(NSString *)imageName action:(SEL)action;

//配置右侧按钮
- (void)setRightItemWithTitle:(NSString *)title action:(SEL)action;
- (void)setRightItemWithImageName:(NSString *)imageName action:(SEL)action;

//配置返回按钮
- (void)setBackItemWithImageName:(NSString *)imageName action:(SEL)action;

- (void)viewBack;

@end
