//
//  JFSkinModel.h
//  yourenPower
//
//  Created by admin on 2018/6/1.
//  Copyright © 2018年 yourenguoji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFSkinModel : NSObject

// 主题色
@property (nonatomic, strong) UIColor *themeColor;
// 导航栏文字_normal
@property (nonatomic, strong) UIColor *navTitleNormalColor;
// 导航栏文字_selected
@property (nonatomic, strong) UIColor *navTitleSelectedColor;
// TabBar文字_selected
@property (nonatomic, strong) UIColor *tabBarTitleNormalColor;
// TabBar文字_selected
@property (nonatomic, strong) UIColor *tabBarTitleSelectedColor;

// tab按钮默认颜色
@property (nonatomic, strong) UIColor *tabBarBtnTitleNormalColor;
// 背景色
@property (nonatomic, strong) UIColor *backColor;
// 分割线颜色
@property (nonatomic, strong) UIColor *separatorLineColor;
// 主界面颜色
@property (nonatomic, strong) UIColor *frontColor;
// 大标题颜色
@property (nonatomic, strong) UIColor *titleColor;
// 内容颜色
@property (nonatomic, strong) UIColor *contentDataColor;
// 小标题颜色
@property (nonatomic, strong) UIColor *subTitleColor;
// 特殊文字颜色
@property (nonatomic, strong) UIColor *flagTitleColor;
// 特殊文字颜色
@property (nonatomic, strong) UIColor *flagTitleOrangeColor;
// 输入框背景颜色
@property (nonatomic, strong) UIColor *textViewBackColor;
// 顶部分栏文字颜色
@property (nonatomic, strong) UIColor *columnBtnTextColor;
// 顶部分栏底部移动条颜色
@property (nonatomic, strong) UIColor *columnBtnLineColor;
@end
