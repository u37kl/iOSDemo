//
//  ZPControlOfInterfaceCollectionCell.m
//  iOSDemo
//
//  Created by ww on 2018/10/23.
//  Copyright © 2018年 ww. All rights reserved.
//

#import "ZPControlOfInterfaceCollectionCell.h"
#import "Masonry.h"

@interface ZPControlOfInterfaceCollectionCell ()
@property (nonatomic, weak) UIImageView *contentImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *typeLabel;
@property (nonatomic, weak) UIButton *moreBtn;
@end

@implementation ZPControlOfInterfaceCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        CAShapeLayer *markLayer = [[CAShapeLayer alloc] init];
        markLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        CGSize radii = CGSizeMake(20, 20);
        UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, markLayer.frame.size.width, markLayer.frame.size.height) byRoundingCorners:corners cornerRadii:radii];
        markLayer.path = path.CGPath;
        self.layer.mask = markLayer;
        
        UIImageView *contentImageView = [[UIImageView alloc] init];
        contentImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:contentImageView];
        _contentImageView = contentImageView;
        [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
            make.height.mas_equalTo(120);
        }];
        
        UILabel *typeLabel = [[UILabel alloc] init];
        typeLabel.backgroundColor = [UIColor orangeColor];
        typeLabel.textColor = [UIColor blackColor];
        typeLabel.text = @"我我我我我我我我我我我我我我我我我我我我";
        typeLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:typeLabel];
        _typeLabel = typeLabel;
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(12);
        }];
        
        UIButton *moreBtn = [[UIButton alloc] init];
         moreBtn.backgroundColor = [UIColor lightGrayColor];
        [moreBtn setImage:[UIImage imageNamed:@"buildInterfaceMore"] forState:UIControlStateNormal];
        [self.contentView addSubview:moreBtn];
        
        _moreBtn = moreBtn;
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.left.equalTo(typeLabel.mas_right).offset(10);
            make.centerY.equalTo(typeLabel);
            make.height.width.mas_equalTo(20);
            
        }];
        

        
        UILabel *titleLabel = [[UILabel alloc] init];
         titleLabel.backgroundColor = [UIColor greenColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.numberOfLines = 2;
        titleLabel.text = @"我我我我我我我我我我我我我我我我我我我我";
        titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentImageView.mas_bottom).offset(10);
            make.bottom.equalTo(self.typeLabel.mas_top).offset(-10);
        }];
        
    }
    return self;
}

@end
