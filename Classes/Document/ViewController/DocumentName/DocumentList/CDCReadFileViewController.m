//
//  CDCReadFileViewController.m
//  CDC
//
//  Created by weiwei on 16/10/14.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCReadFileViewController.h"
#import <WebKit/WebKit.h>

@interface CDCReadFileViewController ()
@property (nonatomic ,strong) WKWebView *web ;

@end

@implementation CDCReadFileViewController

- (WKWebView *)web {
    if (!_web) {
        _web = [WKWebView newAutoLayoutView] ;
    }
    return _web ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftItemWithImageName:@"narrow_left" action:@selector(viewBack)];

    self.title = self.naviTitle ;

    [self initUI] ;

    [self loadURL] ;
}

- (void)initUI {

    [self.view addSubview:self.web] ;

    [self.web autoPinEdgesToSuperviewEdges] ;

}

- (void)loadURL {
//    
//    NSString *string = [NSString stringWithFormat:@"%@%@",kBaseUrlStr_Phone,self.downloadUrl] ;
//    NSURL *url = [NSURL URLWithString:string];
    // 根据URL创建请求
    
//    NSString * str = @"www.baidu.com/s?wd=你好";
//    NSURL * url = [NSURL URLWithString:[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
//    
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString* path = [NSString stringWithFormat:@"%@/%@%@",documentsDirectory,self.catalog,self.fileType] ;
    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@%@",self.pathNameOnly,self.fileType]];
    
//    NSURL *fileURL = [NSURL fileURLWithPath:path1] ;
//    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    // WKWebView加载请求
//    [self.web loadRequest:request];
    
    
    //调用逻辑
    if(path){
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            // iOS9. One year later things are OK.
            NSURL *fileURL = [NSURL fileURLWithPath:path];
            [self.web loadFileURL:fileURL allowingReadAccessToURL:fileURL];
        } else {
            // iOS8. Things can be workaround-ed
            //   Brave people can do just this
            //   fileURL = try! pathForBuggyWKWebView8(fileURL)
            //   webView.loadRequest(NSURLRequest(URL: fileURL))
            
            NSURL *fileURL = [self fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:path]];
            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
            [self.web loadRequest:request];
        }
    }
}

//将文件copy到tmp目录
- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
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
