//
//  DZMTabBar.h
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/13.
//  Copyright © 2019 DZM. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DZM_HEIGHT_TAB_BAR (DZM_X ? 83 : 49)

NS_ASSUME_NONNULL_BEGIN

@class DZMTabBar;
@protocol DZMTabBarDelegate <NSObject>

- (void)tabBar:(DZMTabBar *)tabBar clickIndex:(NSInteger)index;

@end

@interface DZMTabBar : UIView

/// 代理
@property(nonatomic,weak) id<DZMTabBarDelegate> delegate;

/// 选中Item
- (void)selectIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
