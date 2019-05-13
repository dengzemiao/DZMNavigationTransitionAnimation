//
//  DZMNavigationController.m
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/13.
//  Copyright © 2019 DZM. All rights reserved.
//

#import "DZMNavigationController.h"

@interface DZMNavigationController ()

@end

@implementation DZMNavigationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)dzm_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(clickBack)];
    }
    
    [super dzm_pushViewController:viewController animated:animated];
}

- (void)clickBack {
    
    [self dzm_popViewControllerAnimated:YES];
}

@end
