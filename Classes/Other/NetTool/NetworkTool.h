//
//  NetworkTool.h
//  FengHuoVXiao
//
//  Created by fanggao on 16/7/8.
//  Copyright © 2016年 fanggao. All rights reserved.
//

#import <Foundation/Foundation.h>


//网络请求操作的文件
typedef void (^MYBlock)(NSDictionary *dictionary,NSError * error,BOOL state);
//请求到了服务器的数据，
typedef void (^DateBackBlock)(NSDictionary *dictionary);
//请求失败的时候调用这个block
typedef void (^FailBlock)(NSString *error);

typedef void(^Success)(id responseObject) ;    // 成功的Block
@interface NetworkTool : NSObject

+ (void)getHttp:(NSString *)URL block:(DateBackBlock)block failBlock:(FailBlock)failBlock;

+ (void)postHttp:(NSString *)URL dictionary:(NSDictionary *)dictionary block:(DateBackBlock)block failBlock:(FailBlock)failBlock;

+ (void)POST:(NSString *)URL parameters:(NSDictionary *)parameters success:(Success)success failBlock:(FailBlock)failBlock ;
+ (void)GET:(NSString *)URL parameters:(NSDictionary *)parameters success:(Success)success failBlock:(FailBlock)failBlock ;


/** 上传头像 */
+ (void)updateHead:(NSString *)URL WithImg:(NSData *)headerData  withdic:(NSDictionary *)para WithfileName:(NSString *)name block:(DateBackBlock)block failBlock:(FailBlock)failBlock;

@end
