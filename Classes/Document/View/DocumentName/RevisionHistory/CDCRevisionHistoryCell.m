//
//  CDCRevisionHistoryCell.m
//  CDC
//
//  Created by weiwei on 16/10/9.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCRevisionHistoryCell.h"

@interface CDCRevisionHistoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *documentNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *revisionTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *revisionContentLabel;

@end

@implementation CDCRevisionHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithCellData:(LWArrModel_d *)aData atIndexPath:(NSIndexPath *)indexPath {
    self.titleNameLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1] ;
    
    
    self.documentNumLabel.text = aData.fileCatalog ;
    self.revisionTimeLabel.text = aData.createTime ;
    self.revisionContentLabel.text = aData.content ;
    
    if (indexPath.row % 2 == 0) {
        self.backgroundColor = [UIColor whiteColor] ;
    } else {
        self.backgroundColor = Gary_Color ;
    }
}

@end
