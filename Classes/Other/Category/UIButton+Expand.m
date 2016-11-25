//
//  NSObject+BeeNotification.h
//  JiaPartsBase
//
//  Created by Roy on 16/4/11.
//  Copyright © 2016年 JiaParts. All rights reserved.
//

#import "UIButton+Expand.h"

@implementation UIButton(Expand)

- (void)setLayout:(JPUIButtonLayoutStyle )aLayoutStyle
		  spacing:(CGFloat)aSpacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;

    CGFloat totalHeight = (imageSize.height + titleSize.height + aSpacing);
	UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
	UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
	if (aLayoutStyle == JPImageLeftTitleRightStyle) {
		imageEdgeInsets = UIEdgeInsetsMake(0, -(aSpacing / 2.0f), 0, 0 );
		titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - (aSpacing / 2.0f));
	}
	else if (aLayoutStyle == JPTitleLeftImageRightStyle) {
		imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -(titleSize.width * 2 + aSpacing / 2.0f));
		titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width * 2 + aSpacing / 2.0f), 0, 0);
	}else if (aLayoutStyle == JPImageTopTitleBottomStyle){
		imageEdgeInsets = UIEdgeInsetsMake( -(totalHeight - imageSize.height),
										   0.0,
										   0.0,
										   - titleSize.width);
		titleEdgeInsets  = UIEdgeInsetsMake(0.0,
											-imageSize.width,
											- (totalHeight - titleSize.height),
											0.0);
	}else if (aLayoutStyle == JPTitleTopImageBottomStyle){
		imageEdgeInsets = UIEdgeInsetsMake(0.0,
										   0.0,
										   -(totalHeight - imageSize.height),
										   - titleSize.width);

		titleEdgeInsets = UIEdgeInsetsMake(-(totalHeight - titleSize.height),
										   0.0,
										   -imageSize.width,
										   0.0);
	}
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.imageEdgeInsets, imageEdgeInsets)
        || !UIEdgeInsetsEqualToEdgeInsets(self.titleEdgeInsets, titleEdgeInsets)) {
        self.imageEdgeInsets = imageEdgeInsets;
        self.titleEdgeInsets = titleEdgeInsets;
        [self layoutIfNeeded];
    }
	
}

@end
