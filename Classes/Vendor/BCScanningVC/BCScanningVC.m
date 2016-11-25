//
//  BCBuyVC.m
//  BusinessCircle
//
//  Created by GorDon on 16/7/21.
//  Copyright © 2016年 JiaParts. All rights reserved.
//

#import "BCScanningVC.h"
//#import "BCTradeDetailVC.h"
#import "CDCDocumentPageViewController.h"
#import<CommonCrypto/CommonDigest.h>

#define Height [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
#define XCenter self.view.center.x
#define YCenter self.view.center.y

#define SHeight 0

#define SWidth (XCenter+30)


@interface BCScanningVC () <AVCaptureMetadataOutputObjectsDelegate>
//{
//    UIImageView * imageView;
//}


{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    UIImageView * imageView;

}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;


@end

@implementation BCScanningVC

-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.title = @"二维码" ;
    
    [self setLeftItemWithImageName:@"narrow_left" action:@selector(viewBack)];
//    [self setNaviButtonType:NaviButton_Return isLeft:YES];
    [self initUI];
}

- (void)initUI{
    UILabel * labIntroudction= [UILabel newAutoLayoutView];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.font = [UIFont systemFontOfSize:14];
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=[NSString stringWithFormat:@"将二维码至于取景框内扫描"];
    labIntroudction.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:labIntroudction];
    
    CGFloat leftMargin = 50 ;
//    CGFloat rigthMargin = 50 ;
    
    CGFloat image_width = (kScreen_Width - 2*leftMargin) ;
    CGFloat image_height = image_width ;
    CGFloat image_x = leftMargin ;
    CGFloat image_y = (kScreen_Height - image_width)/2-64 ;


    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(image_x,image_y,image_width,image_height)];
    imageView.image = [UIImage imageNamed:@"scanscanBg"];
    [self.view addSubview:imageView];
    
    [labIntroudction autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageView withOffset:10];
    [labIntroudction autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view withOffset:30];
    [labIntroudction autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view withOffset:-30];
    [labIntroudction autoSetDimension:ALDimensionHeight toSize:50];
    
    
    
    upOrdown = NO;
    num =0;
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5, SWidth-10,1)];
    _line.image = [UIImage imageNamed:@"scanLine"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5+2*num, SWidth-10,1);
        
        if (num ==(int)(( SWidth-10)/2)) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame =CGRectMake(CGRectGetMinX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+5+2*num, SWidth-10,1);
        
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}


- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _output.rectOfInterest =[self rectOfInterestByScanViewRect:imageView.frame];//CGRectMake(0.1, 0, 0.9, 1);//
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    
    
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResize;
    _preview.frame =self.view.bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    [self.view bringSubviewToFront:imageView];
    
    [self setOverView];
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        /**
         *  获取扫描结果
         */
        stringValue = metadataObject.stringValue;
    }
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"扫描结果：%@", stringValue] preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [_session startRunning];
//    }]];
//    [self presentViewController:alert animated:true completion:nil];
//
    
    if (stringValue.length > 0) {
        
//        if ([self.delegate respondsToSelector:@selector(finishScanningVC:result:)]) {
//            [self.delegate finishScanningVC:self result:stringValue];
//        }
        ////                    当面交易
        //            BCTradeDetailVC *tradeVc = [[BCTradeDetailVC alloc] init];
        //            [self.navigationController pushViewController:tradeVc animated:YES];
        
        NSDictionary *dic = [NSDictionary dictionaryWithJsonString:stringValue] ;
        
        NSInteger intId = [dic[@"id"] integerValue] ;
        
        NSString *idString = [NSString stringWithFormat:@"%ld",(long)intId] ;
        NSString *md5String = [self md5:[NSString stringWithFormat:@"%@%@",idString,@"jikong"]] ;
        NSString *keyString = [md5String substringToIndex:8] ;
        if ([dic[@"key"] isEqualToString:keyString]) {
            
            if ([self.delegate respondsToSelector:@selector(finishScanningVC:result:docid:)]) {
                [self.delegate finishScanningVC:self result:stringValue docid:dic[@"id"]] ;
            }
            
        } else {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"该文档不存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
//            WEAK_SELF
//            增加确定按钮；
            [alertController addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                STRONG_SELF
                [_session startRunning];
                
                
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
 

        
    }
    
    [_session stopRunning];
//    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^
//     {
//         [timer invalidate];
//
//     }];
    
    

}

- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;
    
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
    
    return CGRectMake(x, y, w, h);
}

#pragma mark - 添加模糊效果
- (void)setOverView {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(imageView.frame);
    CGFloat y = CGRectGetMinY(imageView.frame);
    CGFloat w = CGRectGetWidth(imageView.frame);
    CGFloat h = CGRectGetHeight(imageView.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

- (void)creatView:(CGRect)rect {
    CGFloat alpha = 0.5;
    UIColor *backColor = [UIColor grayColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [self.view addSubview:view];
}

- (void)viewBack {
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
