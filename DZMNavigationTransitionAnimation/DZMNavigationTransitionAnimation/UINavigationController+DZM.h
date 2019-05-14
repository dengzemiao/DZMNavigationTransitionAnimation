//
//  UINavigationController+DZM.h
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/10.
//  Copyright © 2019 DZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+DZM.h"
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

NS_ASSUME_NONNULL_END
