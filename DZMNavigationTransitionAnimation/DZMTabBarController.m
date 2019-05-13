//
//  DZMTabBarController.m
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/13.
//  Copyright © 2019 DZM. All rights reserved.
//

#import "DZMTabBarController.h"
#import "DZMGifController.h"
#import "DZMNavigationController.h"
#import "DZMTableViewController.h"

@interface DZMTabBarController ()

@end

@implementation DZMTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    DZMGifController *vc1 = [[DZMGifController alloc] init];
    vc1.title = @"gif";
    DZMNavigationController *nav1 = [[DZMNavigationController alloc] initWithRootViewController:vc1];
    
    DZMTableViewController *vc2 = [[DZMTableViewController alloc] init];
    vc2.title = @"scroll";
    DZMNavigationController *nav2 = [[DZMNavigationController alloc] initWithRootViewController:vc2];
    
    [self setViewControllers:@[nav1,nav2]];
    
    // 隐藏系统tabbar
    self.tabBar.hidden = YES;
}

@end
