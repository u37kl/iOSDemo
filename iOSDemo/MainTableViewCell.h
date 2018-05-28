//
//  MainTableViewCell.h
//  iOSDemo
//
//  Created by ww on 2018/5/13.
//  Copyright © 2018年 ww. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KnowledgeModel;

#define kMainTableViewCell @"MainTableViewCell"
@interface MainTableViewCell : UITableViewCell
-(void)setModel:(KnowledgeModel *)model;
@end
