//
//  BaseManager.h
//  JinRongPingTai
//
//  Created by weiwei on 16/1/7.
//  Copyright © 2016年 HYKJ. All rights reserved.
//

#import "BaseModel.h"

typedef void (^freshDataBlock)(BOOL isSuccess , NSString *error) ;
typedef void (^FreshDataBlock)(BOOL isSuccess , NSError *error , NSString *flag) ;
//请求失败的时候调用这个block
typedef void (^FailBlock)(NSString *error);
@interface BaseManager : BaseModel

- (void)loadDataSourceList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl ;


- (void)loadDataSourceGETList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl ;

/** Get上拉刷新 下拉加载 **/
- (void)RefreshNormalHeaderGETList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl ;

- (void)RefreshBackNormalFooterGETList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl ;

/** Post上拉刷新 下拉加载 **/

- (void)RefreshNormalHeaderPOSTList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl ;

- (void)RefreshBackNormalFooterPOSTList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl ;


@end
