//
//  VXStudentAllSourceManager.m
//  FengHuoVXiao
//
//  Created by weiwei on 16/8/1.
//  Copyright © 2016年 fanggao. All rights reserved.
//

#import "LWArrayAllSourceManager.h"

@interface LWArrayAllSourceManager ()

@property (nonatomic ,assign) NSInteger pageNumber ;
@property (nonatomic ,copy) NSString *pageSize ;




@end

@implementation LWArrayAllSourceManager

- (instancetype)init
{
    if (self = [super init]) {
        self.pageNumber = 1 ;
        self.pageSize = @"20" ;
    }
    return self ;
}

// 普通Post
- (void)loadDataSourceList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl
{
    __weak typeof (*&self)weakSelf = self ;
    
    [NetworkTool POST:lastUrl parameters:parameters success:^(id responseObject) {
        
        
//                NSLog(@"%@",responseObject.) ;
        
        LWArrayAllSourceModel *model = [[LWArrayAllSourceModel  alloc] initWithData:responseObject error:nil] ;
        weakSelf.model = model ;
        
        
        if ([model.m isEqualToString:@"success"]) {
            if (block)
            {
                block(YES,nil) ;
            }
        }
        else
        {
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

// Post上拉刷新
- (void)RefreshNormalHeaderPOSTList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl {
    __weak typeof (*&self)weakSelf = self ;
    self.pageNumber = 1 ;
    self.model = nil ;
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters] ;
    [para setValue:[NSString stringWithFormat:@"%ld",(long)self.pageNumber] forKey:@"pageNumber"] ;
    [para setValue:self.pageSize forKey:@"pageSize"] ;
    
    [NetworkTool POST:lastUrl parameters:para success:^(id responseObject) {
        
        LWArrayAllSourceModel *model = [[LWArrayAllSourceModel  alloc] initWithData:responseObject error:nil] ;
        weakSelf.model = model ;
        
        if ([model.m isEqualToString:@"success"]) {
            if (block)
            {
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

// Post下拉加载
- (void)RefreshBackNormalFooterPOSTList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl {
    __weak typeof (*&self)weakSelf = self ;
    self.pageNumber += 1 ;
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters] ;
    [para setValue:[NSString stringWithFormat:@"%ld",(long)self.pageNumber] forKey:@"pageNumber"] ;
    [para setValue:self.pageSize forKey:@"pageSize"] ;
    
    [NetworkTool POST:lastUrl parameters:para success:^(id responseObject) {
        
        LWArrayAllSourceModel *model = [[LWArrayAllSourceModel  alloc] initWithData:responseObject error:nil] ;
        if ([model.m isEqualToString:@"success"]) {
            
            for (LWArrModel_d *d in model.d) {
                [weakSelf.model.d addObject:d] ;
            }
            if (model.d.count < 9) {
                block(YES,@"endFlag") ;
            }
            else if (block)
            {
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

// 普通get加载
- (void)loadDataSourceGETList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl
{
    __weak typeof (*&self)weakSelf = self ;
    
    [NetworkTool GET:lastUrl parameters:parameters success:^(id responseObject) {
        
        LWArrayAllSourceModel *model = [[LWArrayAllSourceModel  alloc] initWithData:responseObject error:nil] ;
        
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

// get上拉刷新
- (void)RefreshNormalHeaderGETList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl {
    __weak typeof (*&self)weakSelf = self ;
    
    self.pageNumber = 1 ;
    self.model = nil ;
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters] ;
    [para setValue:[NSString stringWithFormat:@"%ld",(long)self.pageNumber] forKey:@"pageNumber"] ;
    [para setValue:self.pageSize forKey:@"pageSize"] ;
    
    [NetworkTool GET:lastUrl parameters:para success:^(id responseObject) {
        
        LWArrayAllSourceModel *model = [[LWArrayAllSourceModel  alloc] initWithData:responseObject error:nil] ;
        weakSelf.model = model ;
        
//        DebugLog(@"aaaaaaaa%ld",model.c) ;
        if ( [model.m isEqualToString:@"success"]) {
            if (block)
            {
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

// get下拉加载
- (void)RefreshBackNormalFooterGETList:(freshDataBlock)block failBlock:(FailBlock)failBlock andWithParameters:(NSDictionary *)parameters lastUrl:(NSString *)lastUrl {
    __weak typeof (*&self)weakSelf = self ;
    self.pageNumber += 1 ;
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters] ;
    [para setValue:[NSString stringWithFormat:@"%ld",(long)self.pageNumber] forKey:@"pageNumber"] ;
    [para setValue:self.pageSize forKey:@"pageSize"] ;
    
    [NetworkTool GET:lastUrl parameters:para success:^(id responseObject) {
        
        LWArrayAllSourceModel *model = [[LWArrayAllSourceModel  alloc] initWithData:responseObject error:nil] ;
        if ([model.m isEqualToString:@"success"]) {
            
            for (LWArrModel_d *d in model.d) {
                [weakSelf.model.d addObject:d] ;
            }
            if (model.d.count < 9) {
                block(YES,@"endFlag") ;
            }
            else if (block)
            {
                block(YES,nil) ;
            }
        } else if ([model.m isEqualToString:@"没有数据"]) {
            block(YES,@"endFlag") ;

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


@end
