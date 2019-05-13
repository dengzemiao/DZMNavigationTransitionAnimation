//
//  UINavigationBar+DZM.h
//  DZMNavigationExtension
//
//  Created by 邓泽淼 on 2018/5/7.
//  Copyright © 2018年 邓泽淼. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DZM_SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define DZM_IOS_11 [UIDevice currentDevice].systemVersion.floatValue >= 11.0
#define DZM_X (CGSizeEqualToSize(DZM_SCREEN_SIZE, CGSizeMake(375, 812)) || CGSizeEqualToSize(DZM_SCREEN_SIZE, CGSizeMake(414, 896)))
#define DZM_HEIGHT_NAVIGATION_BAR (DZM_X ? 88 : 64)
#define DZM_HEIGHT_STATUS_BAR (DZM_X ? 44 : 20)

@interface UINavigationBar (DZM)

/// 导航栏背景颜色
@property (nonatomic, strong, nullable) UIColor *barBackgroundColor;

/// 自定义导航栏背景颜色
@property (nonatomic, strong, nullable) UIColor *barCustomBackgroundColor;

/// 导航栏分割线
@property (nonatomic, assign) BOOL barShadowImageHidden;

/// 导航栏整体透明度
@property (nonatomic, assign) CGFloat barAlpha;

@end
