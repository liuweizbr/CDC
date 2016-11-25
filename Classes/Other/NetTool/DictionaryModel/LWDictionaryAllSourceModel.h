//
//  VXPublishAllSourceModel.h
//  FengHuoVXiao
//
//  Created by weiwei on 16/7/29.
//  Copyright © 2016年 fanggao. All rights reserved.
//

#import "BaseModel.h"


@protocol LWModel_permissions <NSObject>

@end

@protocol LWModel_files <NSObject>

@end
/*************** 文件基本信息 ***********/

@interface LWModel_permissions : BaseModel

@end

/*************** 查询群组（搜索）***********/
@interface LWModel_files : BaseModel

@end

@interface LWModel_Attributes : BaseModel

@end

@interface LWMoel_d : BaseModel

@property (nonatomic, copy) NSString *lastUpdate;

@property (nonatomic, assign) NSInteger corpId;

@property (nonatomic, copy) NSString *loginName;

@property (nonatomic, strong) NSMutableArray<LWModel_permissions> *permissions;

@property (nonatomic, assign) NSInteger managerId;

@property (nonatomic, assign) NSInteger regionId;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *managerName;

@property (nonatomic, strong) LWModel_Attributes *attributes;

@property (nonatomic, copy) NSString *groupName;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *regionName;

@property (nonatomic, copy) NSString *status;

/*************** 文件基本信息 ***********/

@property (nonatomic, assign) NSInteger docId;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, assign) NSInteger pages;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) BOOL deleted;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *approver;

@property (nonatomic, strong) NSMutableArray <LWModel_files>*files;

@property (nonatomic, copy) NSString *holder;

/*************** 文件列表详情 ***********/

@property (nonatomic, copy) NSString *catalog ;
@property (nonatomic, copy) NSString *fileName ;
@property (nonatomic, copy) NSString *auditor ;
@property (nonatomic, copy) NSString *author ;
@property (nonatomic, copy) NSString *executeDate ;
@property (nonatomic, copy) NSString *downloadUrl ;
@property (nonatomic, copy) NSString *contentType ;
@property (nonatomic, copy) NSString *authority ;

@end

@interface LWMoel_dms : BaseModel

@end

@interface LWDictionaryAllSourceModel : BaseModel

@property (nonatomic ,strong) LWMoel_d *d ; 

@property (nonatomic ,strong) LWMoel_dms *dms ;

@end



