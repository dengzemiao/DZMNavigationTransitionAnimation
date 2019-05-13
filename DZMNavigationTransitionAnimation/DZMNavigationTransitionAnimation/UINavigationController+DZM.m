//
//  UINavigationController+DZM.m
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/10.
//  Copyright © 2019 DZM. All rights reserved.
//

#import "UINavigationController+DZM.h"

@implementation UINavigationController (DZM)

- (void)setDzm_interactivePopDisabled:(BOOL)dzm_interactivePopDisabled {
    
    self.interactivePopGestureRecognizer.enabled = dzm_interactivePopDisabled;
}

- (BOOL)dzm_interactivePopDisabled {
    
    return self.interactivePopGestureRecognizer.enabled;
}

- (void)dzm_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self pushViewController:viewController animated:animated];
}

- (void)dzm_popViewControllerAnimated:(BOOL)animated {
    
    [self popViewControllerAnimated:animated];
}

- (void)dzm_popToRootViewControllerAnimated:(BOOL)animated {
    
    [self popToRootViewControllerAnimated:animated];
}

@end
