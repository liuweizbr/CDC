//
//  CDCDocumentPageView.m
//  CDC
//
//  Created by weiwei on 16/10/9.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCDocumentPageView.h"

@interface CDCDocumentPageView ()

@property (nonatomic, strong) UIButton *myBtn;
@property (nonatomic, strong) UIButton *musicBtn;
@property (nonatomic, strong) UIButton *findBtn;

@end

@implementation CDCDocumentPageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIButton *)myBtn{
    if (!_myBtn) {
        _myBtn = [UIButton newAutoLayoutView];
        [_myBtn setTitle:@"基本信息" forState:UIControlStateNormal];
        [_myBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
        _myBtn.backgroundColor = Main_Color ;
        [_myBtn addTarget:self action:@selector(myBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _myBtn.layer.borderWidth = 0.5 ;
        _myBtn.titleLabel.font = buttomFont(15) ;
        _myBtn.backgroundColor = [UIColor whiteColor] ;
        _myBtn.layer.borderColor = Gary_Color.CGColor ;
    }
    return _myBtn;
}

-(UIButton *)musicBtn{
    if (!_musicBtn) {
        _musicBtn = [UIButton newAutoLayoutView];
        [_musicBtn setTitle:@"文件列表" forState:UIControlStateNormal];
        [_musicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        [_musicBtn addTarget:self action:@selector(musicClick) forControlEvents:UIControlEventTouchUpInside];
        _musicBtn.layer.borderWidth = 0.5 ;
        _musicBtn.titleLabel.font = buttomFont(15) ;
        _musicBtn.backgroundColor = [UIColor whiteColor] ;
        _musicBtn.layer.borderColor = Gary_Color.CGColor ;
    }
    return _musicBtn;
}

-(UIButton *)findBtn{
    if (!_findBtn) {
        _findBtn = [UIButton newAutoLayoutView];
        [_findBtn setTitle:@"修订历史" forState:UIControlStateNormal];
        [_findBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        [_findBtn addTarget:self action:@selector(findClick) forControlEvents:UIControlEventTouchUpInside];
        _findBtn.layer.borderWidth = 0.5 ;
        _findBtn.titleLabel.font = buttomFont(15) ;
        _findBtn.backgroundColor = [UIColor whiteColor] ;
        _findBtn.layer.borderColor = Gary_Color.CGColor ;
    }
    return _findBtn;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.selecteIndex = 1;
    
    [self addSubview:self.myBtn];
    [self addSubview:self.musicBtn];
    [self addSubview:self.findBtn];
    [self setupConstraints];
    
    
    
}
-(void)setupConstraints{
    
    [self.myBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [self.myBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [self.myBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self];
    
    [self.musicBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.myBtn withOffset:0];
    [self.musicBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [self.musicBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self];

    
    [self.findBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.musicBtn withOffset:0];
    [self.findBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
    [self.findBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [self.findBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self];

    [self.musicBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.myBtn];
    [self.findBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.myBtn];


}

-(void)setSelecteIndex:(NSInteger)selecteIndex{
    _selecteIndex = selecteIndex;
    if (selecteIndex == 1) {
        [self.myBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
        self.myBtn.backgroundColor = Main_Color ;
        [self.musicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        self.musicBtn.backgroundColor = [UIColor whiteColor] ;
        [self.findBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        self.findBtn.backgroundColor = [UIColor whiteColor] ;
        
    }else if (selecteIndex == 2){
        [self.musicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
        self.musicBtn.backgroundColor = Main_Color ;
        [self.myBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        self.myBtn.backgroundColor = [UIColor whiteColor] ;
        [self.findBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        self.findBtn.backgroundColor = [UIColor whiteColor] ;
    }else{
        [self.findBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
        self.findBtn.backgroundColor = Main_Color ;
        [self.myBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        self.myBtn.backgroundColor = [UIColor whiteColor] ;
        [self.musicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        self.musicBtn.backgroundColor = [UIColor whiteColor] ;
    }
}

#pragma mark - Action
-(void)myBtnClick{
    [self.myBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    self.myBtn.backgroundColor = Main_Color ;
    [self.musicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    self.musicBtn.backgroundColor = [UIColor whiteColor] ;
    [self.findBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    self.findBtn.backgroundColor = [UIColor whiteColor] ;
    
    if ([self.delegate respondsToSelector:@selector(mainTitleView:clickIndex:)]) {
        [self.delegate mainTitleView:self clickIndex:1];
    }
}

-(void)musicClick{
    [self.musicBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    self.musicBtn.backgroundColor = Main_Color ;
    [self.myBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    self.myBtn.backgroundColor = [UIColor whiteColor] ;
    [self.findBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    self.findBtn.backgroundColor = [UIColor whiteColor] ;
    
    if ([self.delegate respondsToSelector:@selector(mainTitleView:clickIndex:)]) {
        [self.delegate mainTitleView:self clickIndex:2];
    }
}
-(void)findClick{
    [self.findBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    self.findBtn.backgroundColor = Main_Color ;
    [self.myBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    self.myBtn.backgroundColor = [UIColor whiteColor] ;
    [self.musicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
    self.musicBtn.backgroundColor = [UIColor whiteColor] ;
    
    if ([self.delegate respondsToSelector:@selector(mainTitleView:clickIndex:)]) {
        [self.delegate mainTitleView:self clickIndex:3];
    }
    
}


@end
