//
//  CDCMainPageViewController.m
//  CDC
//
//  Created by 刘维 on 16/10/3.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCMainPageViewController.h"
#import "CDCMainPageCell.h"
#import "CDCMainPageHeader.h"
#import "CDCDocumentPageViewController.h"
#import "CDCLoginViewController.h"
#import "PellTableViewSelect.h"
#import "BCScanningVC.h"
#import<CommonCrypto/CommonDigest.h>
#import "CDCDocumentDetailViewController.h"

@interface CDCMainPageViewController ()<UITableViewDataSource,UITableViewDelegate,CDCMainPageHeaderDelegate,BCScanningVCDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView ;

@property (nonatomic, strong) LWDictionaryAllSourceManager *dicManager ;


@property (nonatomic, strong) LWArrayAllSourceManager *arrManager ;
/**
 *  所有文档0 本单元文档1
 */
@property (nonatomic, copy) NSString *allFile ;
@property (nonatomic, copy) NSString *orderFile ;
@property (nonatomic, copy) NSString *keyFile ;

@end


@implementation CDCMainPageViewController

- (LWDictionaryAllSourceManager *)dicManager {
    if (!_dicManager) {
        _dicManager = [[LWDictionaryAllSourceManager alloc] init] ;
    }
    return _dicManager ;
}

- (LWArrayAllSourceManager *)arrManager {
    if (!_arrManager) {
        _arrManager = [[LWArrayAllSourceManager alloc] init] ;
    }
    return _arrManager ;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        [_tableView registerNib:[UINib nibWithNibName:@"CDCMainPageCell" bundle:nil] forCellReuseIdentifier:@"CDCMainPageCell"] ;
        CDCMainPageHeader *pageheader = [[[NSBundle mainBundle] loadNibNamed:@"CDCMainPageHeader" owner:nil options:nil]firstObject] ;
        pageheader.delegate = self ;
        _tableView.tableHeaderView = pageheader ;
        // 上拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requstListGetHeaderRefresh)] ;
        // 下拉加载
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requstListGetBackRefresh)] ;
        
    }
    return _tableView ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.title = @"文档列表" ;
    
    [self  addUI] ;
    [self addLeftBarButtonAndRigtBarButton] ;
    [self initData] ;
    [self requstListGetHeaderRefresh] ;
    [self noDataTip] ;


}

- (void)addUI {
    [self.view addSubview:self.tableView] ;
    [self.tableView autoPinEdgesToSuperviewEdges] ;
}

- (void)addLeftBarButtonAndRigtBarButton {
    [self setLeftItemWithTitle:@"退出" action:@selector(exitButtonClck)] ;
    [self setRightItemWithImageName:@"nav_scan" action:@selector(scanButtonClck)] ;
}

- (void)initData {
    self.allFile = @"1" ;
    self.orderFile = @"name" ;
    self.keyFile = @"" ;
}

#pragma mark - 退出按钮
- (void)exitButtonClck {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认退出？" message:nil preferredStyle:UIAlertControllerStyleAlert];

    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        [userDefaults setValue:@"NO" forKey:@"isSuccess"];
        [userDefaults synchronize];
        
        // 左边
        CDCLoginViewController *vc = [CDCLoginViewController new] ;
        [self presentViewController:vc animated:YES completion:nil] ;
        
        
        
        
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];

    

}

#pragma mark - 扫码成功回调方法

- (void)scanButtonClck {
    
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"应用相机权限受限,请在设置中启用" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        //增加确定按钮；
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    // 右边
    BCScanningVC *scanningVC = [[BCScanningVC alloc] init];
    scanningVC.delegate = self ;
    [self.navigationController pushViewController:scanningVC animated:YES];
}

/**
 *  扫码成功回调方法
 */
-(void)finishScanningVC:(BCScanningVC *)vc result:(NSString *)result docid:(NSString *)docid {
    [self loadDataSourceWithdocid:docid] ;
}

- (void)loadDataSourceWithdocid:(NSString *)docid {
    
    WEAK_SELF
    [self.dicManager loadDataSourceGETList:^(BOOL isSuccess, NSString *error) {
        STRONG_SELF
        if (isSuccess == YES) {
            CDCDocumentPageViewController *detailVC = [[CDCDocumentPageViewController alloc] init];
            detailVC.docId = docid ;
            detailVC.naviTitle = self.dicManager.model.d.name ;
            detailVC.isScan = YES ;
            [self.navigationController pushViewController:detailVC animated:YES];
            [SVProgressHUD dismiss];
            
        } else {
            [SVProgressHUD dismiss];
            [MBProgressHUD showError:error toView:self.view];
        }
        
    } failBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:error toView:self.view];
        
    } andWithParameters:@{@"docId":docid} lastUrl:@"/doc/json/getDocDetail"] ;
}

#pragma mark - 没有数据提示

- (void)noDataTip {
    [self __doInit];
    ///
    [self.view addSubview:self.emptyView];
    [self.emptyView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:72];
    [self.emptyView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
    [self.emptyView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
    [self.emptyView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
    
    
    [self showEmptyView:NO text:nil];
}

-(void)showEmptyView:(BOOL)show text:(NSString *)text {
    
    [self.emptyView show:show withText:text];
}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
}

#pragma mark - UITabelViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrManager.model.d.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDCMainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDCMainPageCell"] ;
    [cell updateWithCellData:self.arrManager.model.d[indexPath.row] atIndexPath:indexPath] ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView endEditing:YES] ;

    CDCDocumentPageViewController *vc = [CDCDocumentPageViewController new] ;
    
    LWArrModel_d *d = self.arrManager.model.d[indexPath.row] ;
    vc.docId = [NSString stringWithFormat:@"%d",d.docId] ;
    vc.naviTitle = d.name ;
    vc.isScan = NO ;
    [self.navigationController pushViewController:vc animated:YES] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65 ;
}

#pragma mark -- CDCMainPageHeaderDelegate 
- (void)mainTitleView:(UIButton *)sender clickIndex:(NSInteger)index {
    if (index == 1) {
        self.allFile = @"1" ;    // 本单元文档
        [self requstListGetHeaderRefresh] ;
    } else if (index == 2) {
        self.allFile = @"0" ;    // 全部文档
        [self requstListGetHeaderRefresh] ;

    } else {
        sender.selected =  !sender.selected;
        [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(sender.mj_x,127 , sender.mj_w, 40 *2) selectData:@[@"按名称排序",@"按类型排序"]
         
         
                                                            action:^(NSInteger index) {
                                                                
//                                                                NSLog(@"%d",index) ;
                                                                if (index == 0) {
                                                                    [sender setTitle:@"按名称排序" forState:UIControlStateNormal] ;
                                                                    self.orderFile = @"name" ;
                                                                    [self requstListGetHeaderRefresh] ;
                                                                    
                                                                } else {
                                                                    [sender setTitle:@"按类型排序" forState:UIControlStateNormal] ;
                                                                    self.orderFile = @"type" ;
                                                                    [self requstListGetHeaderRefresh] ;

                                                                }
                                                                
                                                            } animated:YES];
        
//        sender.selected = NO ;

    }
}

#pragma mark -- CDCMainPageHeaderDelegate

- (void)inputTextMainTitleView:(UITextField *)text {
    
    if ([text.text isEqualToString:@""]) {
        self.keyFile = text.text ;
        [self requstListGetHeaderRefresh] ;
    }
}

- (void)textFieldShouldReturnTitleView:(UITextField *)text {
    self.keyFile = text.text ;

    [self requstListGetHeaderRefresh] ;

}


#pragma mark -- UITableView 头部 尾部刷新
/**
 *  头部刷新
 */
- (void)requstListGetHeaderRefresh {
        [SVProgressHUD show];
        SVProgressHUD_ADD
        WEAK_SELF
        [self.arrManager RefreshNormalHeaderGETList:^(BOOL isSuccess, NSString *error) {
            STRONG_SELF
            if (isSuccess == YES){
                [self.tableView reloadData] ;
                [SVProgressHUD dismiss];
                if (self.arrManager.model.d.count == 0) {
                    [self.emptyView show:YES withText:@"没有数据"];
                } else {
                    [self.emptyView show:NO withText:@""];
                }
            } else {
                if ([error isEqualToString:@"未登陆，请重新登录"]) {
                    [SVProgressHUD dismiss];
                    [MBProgressHUD showError:error toView:self.view];
                    [self setupExitLogin] ;
                } else {
                    if ([error isEqualToString:@"没有数据"]) {
                        [self.emptyView show:YES withText:@"没有数据"];
                    } else {
                        [self.emptyView show:NO withText:@""];
                    }
                    [MBProgressHUD showError:error toView:self.view];
                }

            }
            [weakSelf.tableView.mj_header endRefreshing] ;

        } failBlock:^(NSString *error) {
            [SVProgressHUD dismiss];
            [MBProgressHUD showError:error toView:self.view];
        } andWithParameters:@{@"key":self.keyFile,@"type":self.allFile,@"order":self.orderFile} lastUrl:@"/doc/json/getDocList"] ;
}

#pragma mark - 网络加载超时退出登录
- (void)setupExitLogin {
    // 左边
    CDCLoginViewController *vc = [CDCLoginViewController new] ;
    [self presentViewController:vc animated:YES completion:nil] ;
}

/**
 *  尾部刷新
 */
- (void)requstListGetBackRefresh {
    __weak typeof(*&self)weakSelf = self ;
    [SVProgressHUD show];
    SVProgressHUD_ADD
    [self.arrManager RefreshBackNormalFooterGETList:^(BOOL isSuccess, NSString *error) {
        if (isSuccess == YES) {
            if ([error isEqualToString:@"endFlag"]) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData] ;
            }
            else {
                [weakSelf.tableView.mj_footer endRefreshing] ;
                [weakSelf.tableView reloadData] ;
            }
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
        
    } andWithParameters:@{@"key":self.keyFile,@"type":self.allFile,@"order":self.orderFile} lastUrl:@"/doc/json/getDocList"] ;
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES] ;
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
