//
//  BaseModel.h
//  JinRongPingTai
//
//  Created by weiwei on 15/11/13.
//  Copyright © 2015年 HYKJ. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface BaseModel : JSONModel
/**
 *  错误码(integer类型)
 */
@property (nonatomic ,assign) NSInteger c ;
/**
 *  错误码(integer类型)
 */
@property (nonatomic ,copy) NSString *marker ;
/**
 *  错误信息(string类型)
 */
@property (nonatomic ,copy) NSString *er ;
/**
 *  错误信息(string类型)
 */
@property (nonatomic ,copy) NSString *e ;


//静态数据
@property (nonatomic ,copy) NSString *identify ;

@property (nonatomic ,copy) NSString *name ;


@property (nonatomic ,copy) NSString *m ;


//c
//e		错误信息(string类型)
@end
