//
//  ZPEditTableViewCell.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/18.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPEditTableViewCell.h"

@implementation ZPEditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *backView = [[UIView alloc] initWithFrame:self.frame];
        backView.backgroundColor = [UIColor orangeColor];
        UIView *selectBackView = [[UIView alloc] initWithFrame:self.frame];
        selectBackView.backgroundColor = [UIColor yellowColor];
        self.backgroundView = backView;
        self.imageView.image = [UIImage imageNamed:@"cell_image"];
        self.selectedBackgroundView = selectBackView;
        //self.indentationLevel = 5;
        //self.indentationWidth = 10;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.backgroundColor = [UIColor blueColor];
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.backgroundColor = [UIColor whiteColor];
        }];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
