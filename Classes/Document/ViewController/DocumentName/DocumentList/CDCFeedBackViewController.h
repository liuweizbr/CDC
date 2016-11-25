//
//  CDCFeedBackViewController.h
//  CDC
//
//  Created by weiwei on 16/10/9.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBlock)();

@interface CDCFeedBackViewController : UIViewController
@property (nonatomic, copy) NSString *docId ;
@property (nonatomic, copy) NSString *fileCatalog ;
@property (nonatomic, copy) NSString *content ;

@property (nonatomic, copy) BackBlock backBlock ;
@end
