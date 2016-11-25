//
//  VXStudentAllSourceModel.h
//  FengHuoVXiao
//
//  Created by weiwei on 16/8/1.
//  Copyright © 2016年 fanggao. All rights reserved.
//

#import "BaseModel.h"

@protocol LWArrModel_d <NSObject>

@end

@protocol LWArrModel_files <NSObject>

@end

@interface LWArrModel_files : BaseModel

@end

@interface LWArrModel_d : BaseModel

/******************* 文件首页 *************************/

@property (nonatomic, assign) NSInteger docId;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *lastUpdate;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, assign) NSInteger pages;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger managerId;

@property (nonatomic, assign) NSInteger regionId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) BOOL deleted;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *approver;

@property (nonatomic, copy) NSString *holder;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSMutableArray<LWArrModel_files> *files;

/******************* 修订历史 *************************/


@property (nonatomic, copy) NSString *fileCatalog;


@property (nonatomic, copy) NSString *content;

/******************* 文档列表 *************************/


@property (nonatomic, copy) NSString *prefix;

@property (nonatomic, copy) NSString *catalog;

@property (nonatomic, copy) NSString *author;


@property (nonatomic, assign) NSInteger totalPages;

@property (nonatomic, assign) NSInteger endPage;

@property (nonatomic, copy) NSString *contentType;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *saveName;

@property (nonatomic, copy) NSString *year;

@property (nonatomic, assign) NSInteger times;

@property (nonatomic, assign) NSInteger startPage;

@property (nonatomic, copy) NSString *uploadName;

@property (nonatomic, copy) NSString *auditor;

@property (nonatomic, copy) NSString *uploadNameEX;
@property (nonatomic, copy) NSString *saveNameEX;
@property (nonatomic, copy) NSString *contentTypeEX;


@end

@interface LWArrModel_dms : BaseModel

@end


@interface LWArrayAllSourceModel : BaseModel

@property (nonatomic ,strong) NSMutableArray<LWArrModel_d> *d ; //

@property (nonatomic, strong) LWArrModel_dms *dms;

@end
