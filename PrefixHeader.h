//
//  PrefixHeader.h
//  CDC
//
//  Created by weiwei on 16/9/30.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#ifdef __OBJC__

#ifndef PrefixHeader_h
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <PureLayout.h>
#import <MBProgressHUD.h>
#import <SVProgressHUD.h>
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>

#define PrefixHeader_h
// 类扩展
#import "UIBarButtonItem+Extension.h"
#import "UIViewController+BarItem.h"
#import "NSString+isBlankString.h"
#import "MBProgressHUD+Add.h"
#import "UIView+Extension.h"
#import "LWTableViewCell.h"
#import "NSDictionary+String.h"
#import "UIViewController+BasicBehavior.h"
#endif /* PrefixHeader_h */
// 数据解析
#import "NetworkTool.h"
#import "LWArrayAllSourceManager.h"
#import "LWArrayAllSourceModel.h"
#import "LWDictionaryAllSourceManager.h"
#import "LWDictionaryAllSourceModel.h"

#import "CDCLoginViewController.h"

/** 给SVProgressHUD 添加显示格式 */
#define SVProgressHUD_ADD [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];\
[SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];\
[SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];

//测试地址
//#define kBaseUrlStr_Test @"https://coding.net/"
//#define kBaseUrlStr_Phone @"http://192.168.1.251:8080"
//#define kBaseUrlStr_Phone @"http://192.168.1.251:8090"

//手机版地址
#define kBaseUrlStr_Phone @"http://doc.hbcdcbsl.com"  

//http://doc.hbcdcbsl.com
//http://121.42.178.20:7081
//192.168.1.251:8090
//Coding App 的专属链接
#define kCodingAppScheme @"coding-net:"

//appStore地址
#define kAppUrl @""
#define kAppReviewURL @""

//版本号
#define kVersion_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kVersionBuild_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

//常用变量
#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])


#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

#define kKeyWindow [UIApplication sharedApplication].keyWindow

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kPaddingLeftWidth 15.0
#define kLoginPaddingLeftWidth 18.0
#define kMySegmentControl_Height 44.0
#define kMySegmentControlIcon_Height 70.0

#define  kBackButtonFontSize 16
#define  kNavTitleFontSize 18

#define buttomFont(size) [UIFont systemFontOfSize:size]

#define SZUserDefault [NSUserDefaults standardUserDefaults]
#define Main_Color [UIColor colorWithRed:(67)/255.0 green:(139)/255.0 blue:(221)/255.0 alpha:1.0]

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define Gary_Color [UIColor colorWithRed:237/255.0 green:238/255.0 blue:239/255.0 alpha:1.0]

//#define navColor 
//weak strong self for retain cycle
#define WEAK_SELF __weak typeof(self)weakSelf = self ;
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf ;

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 \
alpha:1.0]
///=============================================
/// @name Weak Object
///=============================================
#pragma mark - Weak Object

/**
 * @code
 * ESWeak(imageView, weakImageView);
 * [self testBlock:^(UIImage *image) {
 *         ESStrong(weakImageView, strongImageView);
 *         strongImageView.image = image;
 * }];
 *
 * // `ESWeak_(imageView)` will create a var named `weak_imageView`
 * ESWeak_(imageView);
 * [self testBlock:^(UIImage *image) {
 *         ESStrong_(imageView);
 * 	_imageView.image = image;
 * }];
 *
 * // weak `self` and strong `self`
 * ESWeakSelf;
 * [self testBlock:^(UIImage *image) {
 *         ESStrongSelf;
 *         _self.image = image;
 * }];
 * @endcode
 */

#define ESWeak(var, weakVar) __weak __typeof(&*var) weakVar = var
#define ESStrong_DoNotCheckNil(weakVar, _var) __typeof(&*weakVar) _var = weakVar
#define ESStrong(weakVar, _var) ESStrong_DoNotCheckNil(weakVar, _var); if (!_var) return;

#define ESWeak_(var) ESWeak(var, weak_##var);
#define ESStrong_(var) ESStrong(weak_##var, _##var);

/** defines a weak `self` named `__weakSelf` */
#define ESWeakSelf      ESWeak(self, __weakSelf);
/** defines a strong `self` named `_self` from `__weakSelf` */
#define ESStrongSelf    ESStrong(__weakSelf, _self);


#endif


