//
//  BaseModel.m
//  JinRongPingTai
//
//  Created by weiwei on 15/11/13.
//  Copyright © 2015年 HYKJ. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES ;
}

+ (JSONKeyMapper *)keyMapper
{
    JSONKeyMapper *keyMapper = [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"c":@"marker",@"e":@"er",@"id":@"identify"}] ;
    return keyMapper ;
}

@end
