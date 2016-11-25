//
//  UIBarButtonItem+Extension.h
//  weibo
//
//  Created by weiwei on 16/2/16.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  图片设置导航栏按钮
 *
 *  @param image         设置图片
 *  @param highImage     高亮图片
 *  @param target        点击对象
 *  @param action        事件
 *  @param controlEvents 按钮点击的类型
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  文字设置导航栏按钮
 *
 *  @param name          文字名词
 *  @param font          文字大小
 *  @param color         文字颜色
 *  @param target        点击对象
 *  @param action        事件
 *  @param controlEvents 按钮点击的类型
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithName:(NSString *)name font:(UIFont *)font color:(UIColor *)color target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  文字设置导航栏按钮并且设置徽标
 *
 *  @param name          文字名词
 *  @param badgeNumber   徽标数
 *  @param target        点击对象
 *  @param action        事件
 *  @param controlEvents 按钮点击的类型
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)barButtonItemWithName:(NSString *)name badgeNumber:(NSString *)badge target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
