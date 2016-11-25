//
//  CDCFeedBackViewController.m
//  CDC
//
//  Created by weiwei on 16/10/9.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCFeedBackViewController.h"
#import <IQTextView.h>

@interface CDCFeedBackViewController ()
@property (weak, nonatomic) IBOutlet IQTextView *contentText;
@property (weak, nonatomic) IBOutlet UIButton *subjectButton;
@property (nonatomic, strong) LWDictionaryAllSourceManager *dicManager ;

@end

@implementation CDCFeedBackViewController
- (LWDictionaryAllSourceManager *)dicManager {
    if (!_dicManager) {
        _dicManager = [[LWDictionaryAllSourceManager alloc] init] ;
    }
    return _dicManager ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

    [self setLeftItemWithImageName:@"narrow_left" action:@selector(viewBack)];

    self.contentText.placeholder = @"评论" ;
//    self.contentText.
    self.title = @"反馈" ;
    [self setUI] ;

}

- (void)setUI {
    self.subjectButton.layer.cornerRadius = 5 ;
    self.subjectButton.clipsToBounds = YES ;
    
    self.contentText.layer.cornerRadius = 5 ;
    self.contentText.clipsToBounds = YES ;
    self.contentText.layer.borderWidth = 2 ;
    self.contentText.layer.borderColor = Gary_Color.CGColor ;
}

- (IBAction)subjectClickButton:(id)sender {
    if ([NSString isBlankString:self.contentText.text] == YES) {
        [MBProgressHUD showError:@"请填写反馈内容" toView:self.view];
    } else {
        [self loadDataSource] ;
        
    }
}

- (void)loadDataSource {
    
//    [SVProgressHUD show];
//    SVProgressHUD_ADD
//    WEAK_SELF
//    [self.dicManager loadDataSourceList:^(BOOL isSuccess, NSString *error) {
//        STRONG_SELF
//        if (isSuccess == YES)
//        {
//            [self.navigationController popViewControllerAnimated:YES] ;
//            [SVProgressHUD dismiss];
//        }else{
//            
//            [SVProgressHUD dismiss];
//            [MBProgressHUD showError:error toView:self.view];
//        }
//    } failBlock:^(NSString *error) {
//        [SVProgressHUD dismiss];
//        [MBProgressHUD showError:error toView:self.view];
//        
//    } andWithParameters:@{@"docId":self.docId,@"fileCatalog":self.fileCatalog,@"content":self.contentText.text,@"file":@""} lastUrl:@"/doc/json/saveFeedback"] ;
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *videoDir = [NSString stringWithFormat:@"%@/Download/huaxiao", docPath];
    NSString *turePath = [NSString stringWithFormat:@"%@/%@",videoDir,@""] ;
    [self loadDateUpdata:[NSData dataWithContentsOfFile:turePath] fileName:@"file"] ;

}

- (void)loadDateUpdata:(NSData *)data fileName:(NSString *)fileName {
    
    [SVProgressHUD show];
    SVProgressHUD_ADD
    WEAK_SELF
    [self changeUserIcon:^(BOOL isSuccess) {
        STRONG_SELF
        
        if (isSuccess == YES) {
            [SVProgressHUD dismiss];
            self.backBlock() ;

//            [MBProgressHUD showSuccess:@"反馈成功" toView:self.view];
            [self.navigationController popViewControllerAnimated:YES] ;
        }
        else
        {
            
            [SVProgressHUD dismiss];
            [MBProgressHUD showError:@"上传失败" toView:self.view];
        }
        
    } With:data fileName:fileName] ;

}

-(void)changeUserIcon:(void(^)(BOOL isSuccess))isSuccess With:(NSData *)data fileName:(NSString *)fileName
{
//    WEAK_SELF
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"doc"];
    NSData *data1 = [NSData dataWithContentsOfFile:imagePath] ;
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"docId":self.docId,@"fileCatalog":self.fileCatalog,@"content":self.contentText.text,@"file":data1}  ;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,@"/doc/json/saveFeedback"] ;
    
    //    NSLog(@"%@",dic) ;
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data1 name:@"image" fileName:@"icon.jpg" mimeType:@"image/jpeg" ];
        
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *result=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //        NSLog(@"%@",result) ;
        //        NSLog(@"%@",operation.responseString) ;
        //        NSLog(@"%@",[result objectForKey:@"tpbh"]) ;
        
        if ([result[@"c"] integerValue]==0&&result)
        {
            isSuccess(YES);
        }
        else
        {
            isSuccess(NO);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        isSuccess(NO);
    }];

    
//    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        [formData appendPartWithFileData:data1 name:@"file" fileName:[fileName stringByRemovingPercentEncoding] mimeType:@"Content-Disposition:form-data" ];
//        
//        
//    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        STRONG_SELF
//        NSDictionary *result=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        
//        if ([result[@"c"] integerValue]==0&&result)
//        {
//
//            isSuccess(YES);
//        }
//        else
//        {
//            isSuccess(NO);
//        }
//        
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        isSuccess(NO);
//    }];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
