//
//  MainTableViewCell.m
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "MainTableViewCell.h"
#import "Masonry.h"
#import "NSString+Size.h"
#import "UIFont+Type.h"
#import "KnowledgeModel.h"


@interface MainTableViewCell()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *descLabel;
@end
@implementation MainTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleLabel = [[UILabel alloc] init];
        UILabel *descLabel = [[UILabel alloc] init];
        
        titleLabel.textColor = [UIColor blueColor];
        descLabel.textColor = [UIColor blueColor];
        titleLabel.font = [UIFont fontWithName:getFontType(FontTypePF) size:getSize(16)];
        descLabel.font = [UIFont fontWithName:getFontType(FontTypePF) size:getSize(16)];
        descLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:descLabel];
        self.titleLabel = titleLabel;
        self.descLabel = descLabel;
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(getSize(15));
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(getSize(60));
            make.height.mas_equalTo(getSize(20));
            
        }];
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(getSize(15));
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(getSize(-15));
            make.height.mas_equalTo(getSize(20));
            
        }];
        return self;
    }
    return nil;
}


-(void)setModel:(KnowledgeModel *)model
{
    self.titleLabel.text = model.name;
    self.descLabel.text = model.descriptions;
    CGFloat width = [model.name getSizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
    width = floor(width) + 1;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
//    [self.titleLabel setNeedsLayout];
//    [self.titleLabel setNeedsUpdateConstraints];
//    [self.titleLabel updateConstraintsIfNeeded];
    
}
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
