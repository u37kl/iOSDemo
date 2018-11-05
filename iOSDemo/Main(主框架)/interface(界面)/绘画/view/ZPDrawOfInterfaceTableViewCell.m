//
//  ZPDrawOfInterfaceTableViewCell.m
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPDrawOfInterfaceTableViewCell.h"

@interface ZPDrawOfInterfaceTableViewCell ()
@property (nonatomic, weak) UIImageView *baseView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, assign) NSUInteger color;
@end

@implementation ZPDrawOfInterfaceTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [JFSKinManager skinManager].model.backColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *baseView = [[UIImageView alloc] init];
        [self.contentView addSubview:baseView];
        self.baseView = baseView;
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(baseView.superview).offset(10);
            make.bottom.equalTo(baseView.superview).offset(-10);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont getPFRWithSize:14];
        titleLabel.textColor = [JFSKinManager skinManager].model.titleColor;
        [self.baseView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).offset(100);
            make.right.equalTo(self.baseView).offset(-100);
            make.top.equalTo(self.baseView).offset(20);
            make.bottom.equalTo(self.baseView).offset(-20);
        }];

    }
    return self;
}

-(void)setModel:(id<ZPDrawOfInterfaceTableViewCellModelProtocol>)model
{
    self.color = model.color;
    self.titleLabel.text = model.titleName;
    self.baseView.image = [UIImage imageNamed:model.imageName];
    self.baseView.backgroundColor = JFColorAlpha_v(model.color, 1);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height - 20);
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:maskLayer.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(10, 10)];
    maskLayer.path = path.CGPath;
    self.baseView.layer.mask = maskLayer;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.baseView.backgroundColor = [JFSKinManager skinManager].model.hightedColor;
    }else{
        self.baseView.backgroundColor = JFColorAlpha_v(self.color, 1);
    }
}

@end
