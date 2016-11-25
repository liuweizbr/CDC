//
//  CDCListDetailViewController.m
//  CDC
//
//  Created by weiwei on 16/10/13.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCListDetailViewController.h"
#import "CDCFeedBackViewController.h"
#import "CDCReadFileViewController.h"

@interface CDCListDetailViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *fileNumber;
@property (weak, nonatomic) IBOutlet UILabel *fileName;
@property (weak, nonatomic) IBOutlet UILabel *auditor;
@property (weak, nonatomic) IBOutlet UILabel *editor;
@property (weak, nonatomic) IBOutlet UILabel *versionNum;
@property (weak, nonatomic) IBOutlet UILabel *startTime;

@property (nonatomic, strong) LWDictionaryAllSourceManager *dicManager ;
@property (weak, nonatomic) IBOutlet UIButton *readButton;

@end

@implementation CDCListDetailViewController

- (LWDictionaryAllSourceManager *)dicManager {
    if (!_dicManager) {
        _dicManager = [[LWDictionaryAllSourceManager alloc] init] ;
    }
    return _dicManager ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.naviTitle ;
    
    [self setUI] ;
    [self addRigtBarButton] ;
  
    [self loadDataSource] ;
    

}

- (void)setUI {
    self.readButton.layer.cornerRadius = 5 ;
    self.readButton.clipsToBounds = YES ;
}

- (void)addRigtBarButton {
    [self setLeftItemWithImageName:@"narrow_left" action:@selector(viewBack)];

}
- (void)scanButtonClck {
//    LWMoel_d *d = self.dicManager.model.d ;
    WEAK_SELF
    // 右边
    CDCFeedBackViewController *feedVc = [[CDCFeedBackViewController alloc] init] ;
    feedVc.fileCatalog = self.catalog ;
    feedVc.docId = self.docId ;
    feedVc.backBlock = ^(){
        STRONG_SELF
        [MBProgressHUD showSuccess:@"反馈成功" toView:self.view];

    } ;
    [self.navigationController pushViewController:feedVc animated:YES] ;
}
/**
 *  阅读按钮
 */
- (IBAction)readClickButton:(id)sender {
    LWMoel_d *d = self.dicManager.model.d ;
    
    if (d.downloadUrl.length != 0) {
        NSString *pathNameOnly = [d.downloadUrl substringFromIndex:12] ;
        
        NSArray *fileTpye = [self.dicManager.model.d.contentType componentsSeparatedByString:@"/"] ;
        NSArray *nameFileTpye = [d.fileName componentsSeparatedByString:@"."] ;
        
        if ([[fileTpye lastObject] isEqualToString:@"pdf"]) {
            if ([self isFileExist:[NSString stringWithFormat:@"%@.pdf",pathNameOnly]] == YES) {
                CDCReadFileViewController *readVc = [CDCReadFileViewController new] ;
                readVc.catalog = self.dicManager.model.d.catalog ;
                readVc.naviTitle = self.dicManager.model.d.fileName ;
                readVc.fileType = @".pdf" ;
                readVc.pathNameOnly = pathNameOnly ;
                [self.navigationController pushViewController:readVc animated:YES] ;
            } else {
                [self downloadSystemResourceItem:d fileType:@".pdf" pathNameOnly:pathNameOnly] ;
            }
        } else if ([[fileTpye lastObject] isEqualToString:@"word"] || [[fileTpye lastObject] isEqualToString:@"msword"] || [[nameFileTpye lastObject] isEqualToString:@"doc"]) {
            if ([self isFileExist:[NSString stringWithFormat:@"%@.doc",pathNameOnly]] == YES) {
                CDCReadFileViewController *readVc = [CDCReadFileViewController new] ;
                readVc.catalog = d.catalog ;
                readVc.naviTitle = d.fileName ;
                readVc.fileType = @".doc" ;
                readVc.pathNameOnly = pathNameOnly ;
                [self.navigationController pushViewController:readVc animated:YES] ;
            } else {
                [self downloadSystemResourceItem:d fileType:@".doc" pathNameOnly:pathNameOnly] ;
            }
        } else if ([[nameFileTpye lastObject] isEqualToString:@"docx"]) {
            if ([self isFileExist:[NSString stringWithFormat:@"%@.docx",pathNameOnly]] == YES) {
                CDCReadFileViewController *readVc = [CDCReadFileViewController new] ;
                readVc.catalog = self.dicManager.model.d.catalog ;
                readVc.naviTitle = self.dicManager.model.d.fileName ;
                readVc.fileType = @".docx" ;
                readVc.pathNameOnly = pathNameOnly ;
                [self.navigationController pushViewController:readVc animated:YES] ;
            } else {
                [self downloadSystemResourceItem:self.dicManager.model.d fileType:@".docx" pathNameOnly:pathNameOnly] ;
            }

        } else {
            if ([self isFileExist:[NSString stringWithFormat:@"%@",pathNameOnly]] == YES) {
                CDCReadFileViewController *readVc = [CDCReadFileViewController new] ;
                readVc.catalog = self.dicManager.model.d.catalog ;
                readVc.naviTitle = self.dicManager.model.d.fileName ;
                readVc.fileType = @"" ;
                readVc.pathNameOnly = pathNameOnly ;
                [self.navigationController pushViewController:readVc animated:YES] ;
            } else {
                [self downloadSystemResourceItem:self.dicManager.model.d fileType:@"" pathNameOnly:pathNameOnly] ;
            }
        }
        
    } else {
        [MBProgressHUD showError:@"该文档不存在" toView:self.view];
    }

}

//异步下载
-(void)downloadSystemResourceItem:(LWMoel_d *)item fileType:(NSString *)fileType pathNameOnly:(NSString *)pathNameOnly {
    [SVProgressHUD show];
    SVProgressHUD_ADD
    WEAK_SELF
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    NSString *string = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,item.downloadUrl] ;
    NSURL * url = [NSURL URLWithString:[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task= [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        
        NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@%@",pathNameOnly,fileType]];
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        STRONG_SELF
        [SVProgressHUD dismiss];
        
        
        CDCReadFileViewController *readVc = [CDCReadFileViewController new] ;
        readVc.downloadUrl = item.downloadUrl ;
        readVc.catalog = item.catalog ;
        readVc.fileType = fileType ;
        readVc.naviTitle = item.fileName ;
        readVc.pathNameOnly = pathNameOnly ;
        [self.navigationController pushViewController:readVc animated:YES] ;
        
    }];
    
    
    [task resume];
    
}

//判断文件是否已经在沙盒中已经存在？
- (BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    
//    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}


#pragma mark - 加载网络请求
- (void)loadDataSource {
    
    WEAK_SELF
    [self.dicManager loadDataSourceGETList:^(BOOL isSuccess, NSString *error) {
        STRONG_SELF
        if (isSuccess == YES) {
            [self addDataArray] ;
            [SVProgressHUD dismiss];
            
        } else {
            if ([error isEqualToString:@"未登陆，请重新登录"]) {
                [SVProgressHUD dismiss];
                [MBProgressHUD showError:error toView:self.view];
                [self setupExitLogin] ;
            } else {
                [SVProgressHUD dismiss];
                [MBProgressHUD showError:error toView:self.view];
            }
        }
        
    } failBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:error toView:self.view];
        
    } andWithParameters:@{@"docId":self.docId,@"catalog":self.catalog} lastUrl:@"/doc/json/getDocFile"] ;
}


#pragma mark - 网络加载超时退出登录
- (void)setupExitLogin {
    // 左边
    CDCLoginViewController *vc = [CDCLoginViewController new] ;
    [self presentViewController:vc animated:YES completion:nil] ;
}


- (void)addDataArray {
    
    
    LWMoel_d *d = self.dicManager.model.d ;
    self.fileNumber.text = d.catalog ;
    self.fileName.text = d.fileName ;
    self.auditor.text = d.auditor ;
    self.editor.text = d.author ;
    self.versionNum.text = d.version ;
    self.startTime.text = d.executeDate ;
    
    if ([d.authority isEqualToString:@"反馈"]) {
        [self setRightItemWithTitle:d.authority action:@selector(scanButtonClck)] ;
    } 
    
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
