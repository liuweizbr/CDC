//
//  BCScanningVC.h
//  BusinessCircle
//
//  Created by GorDon on 16/7/29.
//  Copyright © 2016年 JiaParts. All rights reserved.
//

//#import "BCVC.h"

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class BCScanningVC;

@protocol BCScanningVCDelegate <NSObject>
/**
 *  完成扫描
 *
 */
-(void)finishScanningVC:(BCScanningVC *)vc result:(NSString *)result docid:(NSString *)docid;

@end


@interface BCScanningVC : UIViewController

@property (nonatomic, assign) id<BCScanningVCDelegate> delegate;

@property (nonatomic, copy) NSString *navTitle; //导航栏的标题

@end
