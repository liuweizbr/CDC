//
//  NSDictionary+String.h
//  FengHuoVXiao
//
//  Created by weiwei on 16/9/2.
//  Copyright © 2016年 fanggao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (String)

/**
 *  json格式字符串转字典：
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;

/**
 *  字典转json格式字符串：
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic ;


@end
