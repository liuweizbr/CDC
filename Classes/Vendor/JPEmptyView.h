//
//  JPEmptyView.h
//  DymIOSApp
//
//  Created by Dong Yiming on 15/9/28.
//  Copyright (c) 2015年 Dong Yiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPEmptyView : UIView

@property (nonatomic, strong, readonly) UIImageView     *ivLogo;
@property (nonatomic, strong, readonly) UILabel         *lblMessage;

-(void)show:(BOOL)show;

-(void)show:(BOOL)show withText:(NSString *)text;

@end
