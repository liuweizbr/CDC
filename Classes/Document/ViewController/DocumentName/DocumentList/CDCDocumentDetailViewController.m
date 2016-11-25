//
//  CDCDocumentDetailViewController.m
//  CDC
//
//  Created by 刘维 on 2016/10/7.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCDocumentDetailViewController.h"
#import "CDCDocumentDetailCell.h"
#import "CDCDocumentDetailHeader.h"
#import "CDCListDetailViewController.h"

@interface CDCDocumentDetailViewController ()<UITableViewDataSource,UITableViewDelegate,CDCDocumentDetailHeaderDelegate>

@property (nonatomic, strong) UITableView *tableView ;

@property (nonatomic, strong) LWArrayAllSourceManager *arrManager ;
@property (nonatomic, copy) NSString *keyFile ;

@end

@implementation CDCDocumentDetailViewController

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
        [_tableView registerNib:[UINib nibWithNibName:@"CDCDocumentDetailCell" bundle:nil] forCellReuseIdentifier:@"CDCDocumentDetailCell"] ;
        CDCDocumentDetailHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"CDCDocumentDetailHeader" owner:nil options:nil]firstObject] ;
        header.delegate = self ;
        _tableView.tableHeaderView = header ;
        // 上拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requstListGetHeaderRefresh)] ;
        // 下拉加载
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requstListGetBackRefresh)] ;
    }
    return _tableView ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self initData] ;
    
    [self  addUI] ;
    
    [self requstListGetHeaderRefresh] ;
    
    [self noDataTip] ;
    


}



- (void)initData {
    self.keyFile = @"" ;
}


- (void)addUI {
    [self.view addSubview:self.tableView] ;
    if (self.isHiden == YES) {
        [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view] ;
        [self.tableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view] ;
        [self.tableView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view] ;
        [self.tableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view withOffset:-44] ;
        
    } else {
        [self.tableView autoPinEdgesToSuperviewEdges] ;
        [self setLeftItemWithImageName:@"narrow_left" action:@selector(viewBackRoot)];

    }
}



#pragma mark - 没有数据提示

- (void)noDataTip {
    [self __doInit];
    ///
    [self.view addSubview:self.emptyView];
    [self.emptyView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:40];
    [self.emptyView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
    [self.emptyView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
    [self.emptyView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];

    
    [self showEmptyView:NO text:nil];
}

-(void)showEmptyView:(BOOL)show text:(NSString *)text {
    
    [self.emptyView show:show withText:text];
}

#pragma mark -- UITableView 头部 尾部刷新
/**
 *  头部刷新
 */
- (void)requstListGetHeaderRefresh {
    __weak typeof(*&self)weakSelf = self ;
    [SVProgressHUD show];
    SVProgressHUD_ADD
    [self.arrManager RefreshNormalHeaderGETList:^(BOOL isSuccess, NSString *error) {
        if (isSuccess == YES) {
            [weakSelf.tableView reloadData] ;
            [SVProgressHUD dismiss];
            [weakSelf.tableView.mj_header endRefreshing] ;
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
                [SVProgressHUD dismiss];
                [MBProgressHUD showError:error toView:self.view];
            }
        }
        [weakSelf.tableView.mj_footer endRefreshing] ;

    } failBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:error toView:self.view];
        
    } andWithParameters:@{@"key":self.keyFile,@"docId":self.docId} lastUrl:@"/doc/json/getDocFileList"] ;
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
                [SVProgressHUD dismiss];

            }
            else {
                if ([error isEqualToString:@"未登陆，请重新登录"]) {
                    [SVProgressHUD dismiss];
                    [MBProgressHUD showError:error toView:self.view] ;
                    [self setupExitLogin] ;
                } else {
                    [weakSelf.tableView.mj_footer endRefreshing] ;
                    [weakSelf.tableView reloadData] ;
                }
                [SVProgressHUD dismiss];
                }

        } else {
            [SVProgressHUD dismiss];
            [MBProgressHUD showError:error toView:self.view];
        }
        
    } failBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [MBProgressHUD showError:error toView:self.view];
        
    } andWithParameters:@{@"key":self.keyFile,@"docId":self.docId} lastUrl:@"/doc/json/getDocFileList"] ;
}


#pragma mark - UITabelViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrManager.model.d.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDCDocumentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CDCDocumentDetailCell"] ;
    [cell updateWithCellData:self.arrManager.model.d[indexPath.row] atIndexPath:indexPath] ;

    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView endEditing:YES] ;

    LWArrModel_d *d = self.arrManager.model.d[indexPath.row] ;
    CDCListDetailViewController *vc = [[CDCListDetailViewController alloc] init] ;
    vc.docId = [NSString stringWithFormat:@"%ld",(long)d.docId] ;
    vc.catalog = d.catalog ;
    if ([NSString isBlankString:d.name] == NO) {
        vc.naviTitle = d.name ;
    } else {
        vc.naviTitle = d.catalog ;
    }
    [self.navigationController pushViewController:vc animated:YES] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44 ;
}

#pragma mark -- CDCDocumentDetailHeaderDelegate
- (void)inputTexDocumentDetailView:(UITextField *)text {
    if ([text.text isEqualToString:@""]) {
        self.keyFile = text.text ;
        [self requstListGetHeaderRefresh] ;
    }
}

- (void)textFieldShouldReturnTitleView:(UITextField *)text {
    self.keyFile = text.text ;
    
    [self requstListGetHeaderRefresh] ;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES] ;
}

- (void)viewBackRoot {
    [self.navigationController popToRootViewControllerAnimated:YES] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
