//
//  DZMNavigationBar.m
//  DZMNavigationExtension
//
//  Created by 邓泽淼 on 2018/5/15.
//  Copyright © 2018年 邓泽淼. All rights reserved.
//

#import "DZMNavigationBar.h"
#import "UINavigationBar+DZM.h"

@implementation DZMNavigationBar

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (DZM_IOS_11) {
       
        for (UIView *subview in self.subviews) {
            
            if ([NSStringFromClass(subview.classForCoder) isEqualToString:@"_UIBarBackground"]) {
                
                subview.frame = self.bounds;
                
            }else if ([NSStringFromClass(subview.classForCoder) isEqualToString:@"_UINavigationBarContentView"]) {
                
                CGRect f = subview.frame;
                
                f.origin.y = DZM_HEIGHT_STATUS_BAR;
                
                subview.frame = f;
                
            }else{}
        }
    }
}

@end
