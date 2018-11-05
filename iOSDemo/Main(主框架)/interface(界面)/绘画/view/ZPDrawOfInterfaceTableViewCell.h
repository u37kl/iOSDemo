//
//  ZPDrawOfInterfaceTableViewCell.h
//  iphoneTestRelease
//
//  Created by ww on 2018/10/29.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZPDrawOfInterfaceTableViewCellColorType){
    ZPDrawOfInterfaceTableViewCellColorTypePink,
    ZPDrawOfInterfaceTableViewCellColorTypePurple
};

NS_ASSUME_NONNULL_BEGIN
@protocol ZPDrawOfInterfaceTableViewCellModelProtocol <NSObject>

@property (nonatomic, assign) NSUInteger color;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *titleName;

@end

@interface ZPDrawOfInterfaceTableViewCell : UITableViewCell

-(void)setModel:(id<ZPDrawOfInterfaceTableViewCellModelProtocol>)model;
@end

NS_ASSUME_NONNULL_END
