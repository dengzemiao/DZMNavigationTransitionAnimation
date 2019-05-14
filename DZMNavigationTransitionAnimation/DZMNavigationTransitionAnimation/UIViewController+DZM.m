//
//  UIViewController+DZM.m
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/14.
//  Copyright © 2019 DZM. All rights reserved.
//

#import "UIViewController+DZM.h"
#import <objc/runtime.h>

@implementation UIViewController (DZM)

- (BOOL)dzm_interactivePopDisabled {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setDzm_interactivePopDisabled:(BOOL)disabled {
    
    objc_setAssociatedObject(self, @selector(dzm_interactivePopDisabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)dzm_prefersNavigationBarHidden {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setDzm_prefersNavigationBarHidden:(BOOL)hidden {
    
    objc_setAssociatedObject(self, @selector(dzm_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
