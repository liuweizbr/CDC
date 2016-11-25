//
//  UIViewController+BarItem.m
//  KnightIsland
//
//  Created by shscce on 15/6/8.
//  Copyright (c) 2015年 shscce. All rights reserved.
//

#import "UIViewController+BarItem.h"

@implementation UIViewController (BarItem)


- (void)setNavgationTitle:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font {
    
    //导航条的背景颜色
    self.navigationController.navigationBar.barTintColor = Main_Color;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = font ? font : [UIFont boldSystemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = textColor ? textColor : [UIColor whiteColor];
    label.text = title;
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

- (UIBarButtonItem *)itemWithTitle:(NSString *)title action:(SEL)action{
    
    return [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
}

- (UIBarButtonItem *)itemWithImage:(UIImage *)image action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 24, 24) ;
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    [button sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

- (void)setLeftItemWithTitle:(NSString *)title action:(SEL)action{
    //导航条的背景颜色
    self.navigationController.navigationBar.barTintColor = Main_Color;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = [self itemWithTitle:title action:action];
}

- (void)setLeftItemWithImageName:(NSString *)imageName action:(SEL)action{
    //导航条的背景颜色
    self.navigationController.navigationBar.barTintColor = Main_Color;
    self.navigationItem.leftBarButtonItem = nil;
    UIImage *image = [UIImage imageNamed:imageName];
    self.navigationItem.leftBarButtonItem = [self itemWithImage:image action:action];
}

- (void)setRightItemWithTitle:(NSString *)title action:(SEL)action{
    //导航条的背景颜色
    self.navigationController.navigationBar.barTintColor = Main_Color;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [self itemWithTitle:title action:action];
    ///设置右边btn的颜色
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
}

- (void)setRightItemWithImageName:(NSString *)imageName action:(SEL)action{
    //导航条的背景颜色
    self.navigationController.navigationBar.barTintColor = Main_Color;
    self.navigationItem.rightBarButtonItem = nil;
    UIImage *image = [UIImage imageNamed:imageName];
    
    self.navigationItem.rightBarButtonItem = [self itemWithImage:image action:action];
}

- (void)setBackItemWithImageName:(NSString *)imageName action:(SEL)action{
    //导航条的背景颜色
    self.navigationController.navigationBar.barTintColor = Main_Color;
    self.navigationItem.backBarButtonItem = nil;
    UIImage *image = [UIImage imageNamed:imageName];
    self.navigationItem.leftBarButtonItem = [self itemWithImage:image action:action];
}

- (void)viewBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
