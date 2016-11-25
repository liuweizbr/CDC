//
//  CDCBaseInfoViewController.m
//  CDC
//
//  Created by weiwei on 16/10/12.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCBaseInfoViewController.h"

@interface CDCBaseInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *page;

@property (nonatomic, strong) LWDictionaryAllSourceManager *dicManager ;

@end

@implementation CDCBaseInfoViewController

- (LWDictionaryAllSourceManager *)dicManager {
    if (!_dicManager) {
        _dicManager = [[LWDictionaryAllSourceManager alloc] init] ;
    }
    return _dicManager ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadDataSource] ;

}

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
        
    } andWithParameters:@{@"docId":self.docId} lastUrl:@"/doc/json/getDocDetail"] ;
}


#pragma mark - 网络加载超时退出登录
- (void)setupExitLogin {
    // 左边
    CDCLoginViewController *vc = [CDCLoginViewController new] ;
    [self presentViewController:vc animated:YES completion:nil] ;
}

- (void)addDataArray {
    LWMoel_d *d = self.dicManager.model.d ;
    self.name.text = d.name ;
    self.type.text = d.type ;
    self.number.text = d.version ;
    self.page.text = [NSString stringWithFormat:@"%d",d.pages] ;
    

    
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
