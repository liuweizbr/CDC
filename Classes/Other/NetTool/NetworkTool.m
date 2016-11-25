
//  NetworkTool.m
//  FengHuoVXiao
//
//  Created by fanggao on 16/7/8.
//  Copyright © 2016年 fanggao. All rights reserved.
//

#import "NetworkTool.h"
#import <AFNetworking.h>
#import "Reachability.h"
@implementation NetworkTool

//现在发送请求之前，添加了一个是否联网的判断
+ (void)getHttp:(NSString *)URL block:(DateBackBlock)block failBlock:(FailBlock)failBlock
{
    if ([self isConnectionAvailable])
    {
        NSString *URLString = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,URL];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
         manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation,NSDictionary *responseObject) {
            if (block)
            {
                block(responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failBlock)
            {
                failBlock(@"请求超时");
            }
        }];
    }
    else
    {
        if(failBlock)
        {
            failBlock(@"未连接网络");
        }
    }
}

//现在发送请求之前，添加了一个是否联网的判断
+ (void)getHttp:(NSString *)string dictionary:(NSDictionary *)dictionary block:(DateBackBlock)block failBlock:(FailBlock)failBlock
{
    if ([self isConnectionAvailable])
    {
        NSString *URLString = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,string];
        //NSLog(@"%@",URLString);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager GET:URLString parameters:dictionary success:^(AFHTTPRequestOperation *operation,NSDictionary *responseObject)
        {
            if (block)
            {
                block(responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failBlock)
            {
                failBlock(@"请求超时");
            }
        }];
    }
    else
    {
        if(failBlock)
        {
            failBlock(@"未连接网络");
        }
    }
}

+ (void)postHttp:(NSString *)URL dictionary:(NSDictionary *)dictionary block:(DateBackBlock)block failBlock:(FailBlock)failBlock
{
    if ([self isConnectionAvailable])
    {
        NSString *URLString = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,URL];
        NSLog(@"dictionary:%@",dictionary);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        [manager POST:URLString parameters:dictionary success:^(AFHTTPRequestOperation *operation,NSDictionary *responseObject)
        {
            NSLog(@"%@",responseObject);
            if (block)
            {
                block(responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSString * errorString =[NSString stringWithFormat:@"%@",error];
            NSLog(@"===%@",error);
            if ([errorString rangeOfString:@"Code=-1001"].location != NSNotFound)
            {
                if (failBlock)
                {
                    failBlock(@"请求超时，请重试");
                }
            }
            else if ([errorString rangeOfString:@"Code=-1004"].location != NSNotFound)
            {
                if (failBlock)
                {
                    failBlock(@"未能连接到服务器");
                }
            }
            else
            {
                if (failBlock)
                {
                    failBlock(@"请求超时");
                }
            }
        }];
    }
    else
    {
        if (failBlock)
        {
            failBlock(@"未连接网络");
        }
    }
}

+ (void)POST:(NSString *)URL parameters:(NSDictionary *)parameters success:(Success)success failBlock:(FailBlock)failBlock
{
    if ([self isConnectionAvailable])
    {
        NSString *URLString = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,URL];
        NSLog(@"dictionary:%@",parameters);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"multipart/form-data"];

//        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
        [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation,id  _Nonnull responseObject)
         {
//             NSLog(@"%@",operation.responseString);
                 if (success)
                 {
                     success(responseObject);
                 }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSString * errorString =[NSString stringWithFormat:@"%@",error];
//             NSLog(@"===%@",error);
             if ([errorString rangeOfString:@"Code=-1001"].location != NSNotFound)
             {
                 if (failBlock)
                 {
                     failBlock(@"请求超时，请重试");
                 }
             }
             else if ([errorString rangeOfString:@"Code=-1004"].location != NSNotFound)
             {
                 if (failBlock)
                 {
                     failBlock(@"未能连接到服务器");
                 }
             }
             else
             {
                 if (failBlock)
                 {
                     failBlock(@"请求超时");
                 }
             }
         }];
    }
    else
    {
        if (failBlock)
        {
            failBlock(@"未连接网络");
        }
    }
}

+ (void)GET:(NSString *)URL parameters:(NSDictionary *)parameters success:(Success)success failBlock:(FailBlock)failBlock ;
{
    
    if ([self isConnectionAvailable])
    {
        NSString *URLString = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,URL];
        NSLog(@"dictionary:%@",parameters);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        
        //        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
        
        
        [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation,id  _Nonnull responseObject)
         {
//                          NSLog(@"%@",operation.responseString);
             
             DebugLog(@"%@",operation.responseString) ;
             if (success)
             {
                 success(responseObject);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             
             NSString * errorString =[NSString stringWithFormat:@"%@",error];
//             NSLog(@"===%@",error);
             if ([errorString rangeOfString:@"Code=-1001"].location != NSNotFound)
             {
                 if (failBlock)
                 {
                     failBlock(@"请求超时，请重试");
                 }
             }
             else if ([errorString rangeOfString:@"Code=-1004"].location != NSNotFound)
             {
                 if (failBlock)
                 {
                     failBlock(@"未能连接到服务器");
                 }
             }
             else
             {
                 if (failBlock)
                 {
                     failBlock(@"请求超时");
                 }
             }
         }];
    }
    else
    {
        if (failBlock)
        {
            failBlock(@"未连接网络");
        }
    }
}

/** 上传头像 */
+ (void)updateHead:(NSString *)URL WithImg:(NSData *)headerData  withdic:(NSDictionary *)para WithfileName:(NSString *)name block:(DateBackBlock)block failBlock:(FailBlock)failBlock
{
    if ([self isConnectionAvailable])
    {
        NSString *URLString = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,URL];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [manager POST:URLString parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
             [formData appendPartWithFileData:headerData name:name fileName:[NSString stringWithFormat:@"%@.png",name] mimeType:@"png"];
        } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if (block)
            {
                block(responseObject);
            }
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            if (failBlock)
            {
                failBlock(@"请求超时");
            }
        }];
    }
    else
    {
        if(failBlock)
        {
            failBlock(@"未连接网络");
        }
    }
}

-(void)test
{
    AFHTTPRequestOperationManager * manage = [AFHTTPRequestOperationManager manager];
    ////    申明返回的结果是json类型
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manage.requestSerializer=[AFJSONRequestSerializer serializer];
}

#pragma mark - 判断网络连接情况
// 加号方法里只能够调用加号方法
+(BOOL)isConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    if (!isExistenceNetwork) {
        return NO;
    }
    return isExistenceNetwork;
}

@end
