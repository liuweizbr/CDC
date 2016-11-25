//
//  NSString+isBlankString.m
//  CDC
//
//  Created by weiwei on 16/10/10.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "NSString+isBlankString.h"

@implementation NSString (isBlankString)

+ (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

@end
