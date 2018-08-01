//
//  ZPHomeTableViewCell.m
//  iOSDemoiPhone
//
//  Created by ww on 2018/7/30.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPHomeTableViewCell.h"

@interface ZPHomeTableViewCell()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *lastMessageLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation ZPHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
//        self.selectionStyle = UITable ViewCellSelectionStyleNone; 
        self.contentView.backgroundColor = [UIColor whiteColor];
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = 6;
        _iconImageView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
        _iconImageView.layer.borderWidth = 0.5;
        [self.contentView addSubview:_iconImageView];
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 10, 10, 200, 25)];
        [self.contentView addSubview:_userNameLabel];
        
        _lastMessageLabel = [UILabel new];
        _lastMessageLabel.textColor = [UIColor grayColor];
        _lastMessageLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_lastMessageLabel];
        
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    _lastMessageLabel.frame = CGRectMake(CGRectGetMinX(_userNameLabel.frame), CGRectGetMaxY(_userNameLabel.frame), screenWidth - CGRectGetMinX(_userNameLabel.frame) - 10, 25);
    _timeLabel.frame = CGRectMake(screenWidth - 200 - 10, 10, 200, 25);
}




//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

- (void)setModel:(LYHomeCellModel *)model {
    _model = model;
    
    _iconImageView.image = [UIImage imageNamed:model.iconName];
    
    _userNameLabel.text = model.userName;
    
    _lastMessageLabel.text = model.lastMessage;
    
    _timeLabel.text = model.timeString;
}

@end
