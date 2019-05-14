//
//  UINavigationController+DZM.h
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/10.
//  Copyright © 2019 DZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZMDrawerNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (DZM)

/// 返回手势启用(禁用) 默认:NO
@property(nonatomic,assign) BOOL dzm_interactivePopDisabled;

/// PUSH
- (void)dzm_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/// POP
- (void)dzm_popViewControllerAnimated:(BOOL)animated;

/// POP ROOT
- (void)dzm_popToRootViewControllerAnimated:(BOOL)animated;

@end

// 这个只用于自定义扩展使用 还没有支持类似 FDFullscreenPopGesture 上用于系统导航的功能。不过可以加上。
@interface UIViewController (DZM)

/// 单个页面返回手势启用(禁用) 默认:NO
@property(nonatomic,assign) BOOL dzm_interactivePopDisabled;

/// 单个页面导航栏隐藏(显示) 默认:NO
@property(nonatomic,assign) BOOL dzm_prefersNavigationBarHidden;

@end

NS_ASSUME_NONNULL_END
