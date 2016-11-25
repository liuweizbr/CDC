//
//  CDCDocumentPageViewController.m
//  CDC
//
//  Created by weiwei on 16/10/9.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCDocumentPageViewController.h"
#import "CDCDocumentPageView.h"
#import "CDCBaseInfoViewController.h" // 基本信息
#import "CDCDocumentDetailViewController.h" // 文件列表
#import "CDCRevisionHistoryViewController.h" // 修改记录


@interface CDCDocumentPageViewController ()<CDCDocumentPageViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *contentPageVCs;
@property (nonatomic, strong)CDCDocumentPageView *titleView;

@property (nonatomic, strong) CDCBaseInfoViewController *myVC;
@property (nonatomic, strong) CDCDocumentDetailViewController *musicVC;
@property (nonatomic, strong) CDCRevisionHistoryViewController *findVC;

@end

@implementation CDCDocumentPageViewController

- (UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        
        NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}
- (CDCBaseInfoViewController *)myVC{
    
    if (!_myVC) {
        _myVC = [CDCBaseInfoViewController new];
        _myVC.docId = self.docId ;
    }
    return _myVC;
}
- (CDCDocumentDetailViewController *)musicVC{
    if (!_musicVC) {
        _musicVC = [CDCDocumentDetailViewController new];
        _musicVC.docId = self.docId ;
        _musicVC.isHiden = YES ;

    }
    return _musicVC;
}

- (CDCRevisionHistoryViewController *)findVC{
    if (!_findVC) {
        _findVC = [CDCRevisionHistoryViewController new];
        _findVC.docId = self.docId ;

    }
    return _findVC;
}

-(NSMutableArray *)contentPageVCs{
    if (!_contentPageVCs) {
        _contentPageVCs = [[NSMutableArray alloc]initWithArray:@[self.myVC,self.musicVC,self.findVC]];
        
    }
    return _contentPageVCs;
}

- (CDCDocumentPageView *)titleView {
    if (!_titleView) {
        _titleView = [[CDCDocumentPageView alloc]initWithFrame:CGRectMake(0, kScreen_Height - 108, kScreen_Width, 44)];
        _titleView.delegate = self;
        _titleView.layer.borderWidth = 0.5 ;
        _titleView.backgroundColor = [UIColor whiteColor] ;
        _titleView.layer.borderColor = Gary_Color.CGColor ;

    }
    return _titleView ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftItemWithImageName:@"narrow_left" action:@selector(viewBack)];

    self.title = self.naviTitle ;
    [self initBottomView];
    
    [self initUI];


}

- (void)initBottomView {


}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor] ;
    [self.pageViewController setViewControllers:@[self.myVC]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    [self.view addSubview:self.titleView] ;

    
}

- (UIViewController *)lastContentVC:(UIViewController *)viewController
{
    NSInteger index = [self.contentPageVCs indexOfObject:viewController];
    if (index <= 0) {
        index = 0;
    }else{
        index--;
    }
    return [self.contentPageVCs objectAtIndex:index];
}

- (UIViewController *)nextContentVC:(UIViewController *)viewController
{
    NSInteger index = [self.contentPageVCs indexOfObject:viewController];
    if (index >= 2) {
        index = 2;
    }else{
        index++;
    }
    return [self.contentPageVCs objectAtIndex:index];
}


// 得到相应的VC对象
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    if ((self.contentPageVCs.count == 0) || (index >= self.contentPageVCs.count) ) {
        return nil;
    }
    return [self.contentPageVCs objectAtIndex:index];
}
// 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    return [self.contentPageVCs indexOfObject:viewController];
}

#pragma mark- UIPageViewControllerDataSource

// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:viewController];
    if (index <= 0 || index == NSNotFound) {
        return nil;
    }
    
    UIViewController *contentVC = [self lastContentVC:viewController];
    
    index--;
    
    //    contentVC.modelYearListDic =[self.pageContentData safeObjectAtIndex:index];
    
    return contentVC;
    
}

// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound || index >= 2) {
        return nil;
    }
    
    UIViewController *contentVC = [self nextContentVC:viewController];
    index++;
    //    contentVC.modelYearListDic =[self.pageContentData safeObjectAtIndex:index];
    return contentVC;
    
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    
    
    // Select tab
    NSUInteger index = [self indexOfViewController:viewController];
    self.titleView.selecteIndex = index + 1;
    
    
    return;
}

- (void)viewBack {
    if (self.isScan == YES) {
        [self.navigationController popToRootViewControllerAnimated:YES] ;
    } else {
        [self.navigationController popViewControllerAnimated:YES] ;
    }
}

#pragma mark - QMMainTitleViewDelegate
-(void)mainTitleView:(CDCDocumentPageView *)view clickIndex:(NSInteger)index{
    
    
    UIViewController *viewController = [self viewControllerAtIndex:index-1];
    [self.pageViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
        
    }];
    
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
