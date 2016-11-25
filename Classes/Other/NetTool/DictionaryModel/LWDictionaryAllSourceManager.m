//
//  VXPublishAllSourceManager.m
//  FengHuoVXiao
//
//  Created by weiwei on 16/7/29.
//  Copyright © 2016年 fanggao. All rights reserved.
//

#import "LWDictionaryAllSourceManager.h"

@interface LWDictionaryAllSourceManager ()

@property (nonatomic ,assign) NSInteger page ;
@property (nonatomic ,copy) NSString *size ;
@end

@implementation LWDictionaryAllSourceManager

- (instancetype)init
{
    if (self = [super init]) {
        self.page = 1 ;
        self.size = @"10" ;
    }
    return self ;
}

- (void)loadDataSourceList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl
{
    __weak typeof (*&self)weakSelf = self ;
    
    [NetworkTool POST:lastUrl parameters:parameters success:^(id responseObject) {
        
        
        //        NSLog(@"%@",responseObject) ;
        
        LWDictionaryAllSourceModel *model = [[LWDictionaryAllSourceModel  alloc] initWithData:responseObject error:nil] ;
        if ([model.m isEqualToString:@"success"]) {
            if (block) {
                weakSelf.model = model ;
                block(YES,nil) ;
            }
        } else if ([model.m isEqualToString:@"未登陆，请重新登录"]) {
            if (block) {
                block(NO,@"未登陆，请重新登录") ;
            }
        } else {
            if (block) {
                block(NO,model.m) ;
            }
        }
        
        //        NSLog(@"%@",model) ;
        
    } failBlock:^(NSString *error) {
        
        
        if (failBlock) {
            failBlock(error) ;
        }
        
        
    }] ;
}

- (void)loadDataSourceGETList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl
{
    __weak typeof (*&self)weakSelf = self ;
    
    [NetworkTool GET:lastUrl parameters:parameters success:^(id responseObject) {
        
        LWDictionaryAllSourceModel *model = [[LWDictionaryAllSourceModel  alloc] initWithData:responseObject error:nil] ;
        
        if ([model.m isEqualToString:@"success"]) {
            if (block)
            {
                weakSelf.model = model ;
                block(YES,nil) ;
            }
        } else if ([model.m isEqualToString:@"未登陆，请重新登录"]) {
            if (block) {
                block(NO,@"未登陆，请重新登录") ;
            }
        } else {
            if (block) {
                block(NO,model.m) ;
            }
        }
        
        //        NSLog(@"%@",model) ;
        
    } failBlock:^(NSString *error) {
        
        
        if (failBlock) {
            failBlock(error) ;
        }
        
        
    }] ;
}

- (void)RefreshNormalHeaderGETList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl {
    self.page = 1 ;
    self.model = nil ;

    __weak typeof (*&self)weakSelf = self ;
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters] ;
    [para setValue:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"] ;
    [para setValue:self.size forKey:@"size"] ;
    
    [NetworkTool GET:lastUrl parameters:para success:^(id responseObject) {
        
        LWDictionaryAllSourceModel *model = [[LWDictionaryAllSourceModel  alloc] initWithData:responseObject error:nil] ;
        if ([model.m isEqualToString:@"success"]) {
            if (block) {
                weakSelf.model = model ;
                block(YES,nil) ;
            }
        } else if ([model.m isEqualToString:@"未登陆，请重新登录"]) {
            if (block) {
                block(NO,@"未登陆，请重新登录") ;
            }
        } else {
            if (block) {
                block(NO,model.m) ;
            }
        }

        
        //        NSLog(@"%@",model) ;
        
    } failBlock:^(NSString *error) {
        
        
        if (failBlock) {
            failBlock(error) ;
        }
        
        
    }] ;
}

- (void)RefreshBackNormalFooterGETList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl {
    __weak typeof (*&self)weakSelf = self ;
    self.page += 1 ;
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters] ;
    [para setValue:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"] ;
    [para setValue:self.size forKey:@"size"] ;
    
    [NetworkTool GET:lastUrl parameters:para success:^(id responseObject) {
        
        LWDictionaryAllSourceModel *model = [[LWDictionaryAllSourceModel  alloc] initWithData:responseObject error:nil] ;
        
        if ([model.m isEqualToString:@"success"]) {
            
//            for (LWMoel_d *list in model.d.list) {
//                [weakSelf.model.d.list addObject:list] ;
//            }
//            
//            if (model.d.list.count < 9) {
//                block(YES,@"endFlag") ;
//            } else if (block)
//            {
//                block(YES,nil) ;
//            }
        } else {
            if (block) {
                block(NO,model.m) ;
            }
        }
        
        //        NSLog(@"%@",model) ;
        
    } failBlock:^(NSString *error) {
        
        
        if (failBlock) {
            failBlock(error) ;
        }
        
    }] ;
}


@end
