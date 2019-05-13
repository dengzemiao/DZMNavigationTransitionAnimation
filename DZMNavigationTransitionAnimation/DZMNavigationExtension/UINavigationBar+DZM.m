//
//  UINavigationBar+DZM.m
//  DZMNavigationExtension
//
//  Created by 邓泽淼 on 2018/5/7.
//  Copyright © 2018年 邓泽淼. All rights reserved.
//

#import "UINavigationBar+DZM.h"
#import <objc/runtime.h>

@implementation UINavigationBar (DZM)

- (UIColor *)barBackgroundColor {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    
    if (DZM_IOS_11) {
        
        if (CGColorEqualToColor(barBackgroundColor.CGColor, UIColor.clearColor.CGColor)) {
            
            [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            
        }else{
            
            [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        }
        
        self.barTintColor = barBackgroundColor;
        
    }else{
        
        [self barBackgroundView:barBackgroundColor];
    }
    
    objc_setAssociatedObject(self, @selector(barBackgroundColor), barBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)barCustomBackgroundColor {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBarCustomBackgroundColor:(UIColor *)barCustomBackgroundColor {
    
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    if (DZM_IOS_11) {
        
        self.backgroundColor = barCustomBackgroundColor;
        
    }else{
        
        [self barBackgroundView:barCustomBackgroundColor];
    }
    
    objc_setAssociatedObject(self, @selector(barCustomBackgroundColor), barCustomBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)barBackgroundView {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBarBackgroundView:(UIView *)barBackgroundView {
    
    objc_setAssociatedObject(self, @selector(barBackgroundView), barBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)barShadowImageHidden {
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setBarShadowImageHidden:(BOOL)barShadowImageHidden {
    
    self.shadowImage = barShadowImageHidden ? [UIImage new] : nil;
    
    objc_setAssociatedObject(self, @selector(barShadowImageHidden), @(barShadowImageHidden), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)barAlpha {
    
    NSNumber *barAlpha = ((NSNumber *)objc_getAssociatedObject(self, _cmd));
    
    return (barAlpha != nil ? barAlpha.floatValue : 1.0);
}

- (void)setBarAlpha:(CGFloat)barAlpha {
    
    objc_setAssociatedObject(self, @selector(barAlpha), @(barAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self barAlpha:self];
}

- (void)barAlpha:(UIView *)superView {
    
    for (UIView *subview in superView.subviews) {
        
        subview.alpha = self.barAlpha;
        
        if (subview.subviews.count > 0) {
            
            [self barAlpha:subview];
        }
    }
}

- (void)barBackgroundView:(UIColor *)backgroundColor {
    
    if (!self.barBackgroundView) {
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        UIView *barBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), DZM_HEIGHT_NAVIGATION_BAR)];
        
        barBackgroundView.backgroundColor = [UIColor whiteColor];
        
        barBackgroundView.userInteractionEnabled = NO;
        
        barBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [[self.subviews firstObject] insertSubview:barBackgroundView atIndex:0];
        
        self.barBackgroundView = barBackgroundView;
    }
    
    self.barBackgroundView.backgroundColor = backgroundColor;
}

@end
