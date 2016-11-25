//
//  CDCMainPageCell.m
//  CDC
//
//  Created by 刘维 on 2016/10/7.
//  Copyright © 2016年 weiwei. All rights reserved.
//

#import "CDCMainPageCell.h"

@interface CDCMainPageCell ()
@property (weak, nonatomic) IBOutlet UILabel *topNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomNameLabel;

@end

@implementation CDCMainPageCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithCellData:(LWArrModel_d *)aData atIndexPath:(NSIndexPath *)indexPath {
    self.bottomNameLabel.text = aData.type ;
    self.topNameLabel.text = aData.name ;
}

@end
