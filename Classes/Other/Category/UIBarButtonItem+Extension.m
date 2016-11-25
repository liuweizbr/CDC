//
//  UIBarButtonItem+Extension.m
//  weibo
//
//  Created by weiwei on 16/2/16.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 24, 24) ;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (UIBarButtonItem *)barButtonItemWithName:(NSString *)name font:(UIFont *)font color:(UIColor *)color target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal] ;
    [btn sizeToFit];
    [btn setTitleColor:color forState:UIControlStateNormal] ;
    btn.titleLabel.font = font ;
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
