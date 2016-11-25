//
//  NSObject+BeeNotification.h
//  JiaPartsBase
//
//  Created by Roy on 16/4/11.
//  Copyright © 2016年 JiaParts. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JPUIButtonLayoutStyle) {
	JPImageLeftTitleRightStyle = 0, //默认的方式 image左 title右
	JPTitleLeftImageRightStyle = 1, // image右,title左
	JPImageTopTitleBottomStyle = 2, //image上，title下
	JPTitleTopImageBottomStyle = 3, // image下,title上
};
@interface UIButton(Expand)

/**
 *	功能:设置UIButton的布局，图片和文字按照指定方向显示
 *
 *	@param aLayoutStyle:参见JPUIButtonLayoutStyle
 *	@param aSpacing:图片和文字之间的间隔
 */
- (void)setLayout:(JPUIButtonLayoutStyle )aLayoutStyle
		  spacing:(CGFloat)aSpacing;
@end
