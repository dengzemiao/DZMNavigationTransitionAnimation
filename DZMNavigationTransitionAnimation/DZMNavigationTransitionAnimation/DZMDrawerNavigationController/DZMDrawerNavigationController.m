//
//  DZMDrawerNavigationController.m
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/10.
//  Copyright © 2019 DZM. All rights reserved.
//

#import "DZMDrawerNavigationController.h"

/// 封面图缩放比例
#define DZM_SCALE_IMAGE_VIEW 0.95

/// 拖拽放大封面图计算范围(也就是在当前视图宽度的多少比例算有效距离)
#define DZM_SCALE_DRAG_RECT 0.8

/// 拖拽返回成功计算范围(也就是拖拽当前视图宽的多少比例之后算成功)
#define DZM_SCALE_DRAG_SUCCESS_RECT 0.2

/// 遮盖颜色透明度
#define DZM_ALPHA_COVER_COLOR 0.5

/// 拖拽完成之后(切换页面)收尾动画时间
#define DZM_AD_TIME 0.3

@interface DZMDrawerNavigationController ()<UIGestureRecognizerDelegate>

/// 上一个视图承载器
@property(nonatomic,strong) UIView *previousView;

/// 遮盖
@property(nonatomic,strong) UIView *cover;

/// 拖拽手势
@property(nonatomic,strong) UIPanGestureRecognizer *pan;

/// 上一个控制器
@property(nonatomic, weak) UIViewController *previousVC;

@end

@implementation DZMDrawerNavigationController

/// 封面图
- (UIView *)previousView {
    
    if (!_previousView) {
        
        _previousView = [[UIView alloc] initWithFrame:self.view.bounds];
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        
        [keyWindow addSubview:_previousView];
        
        [keyWindow insertSubview:_previousView atIndex:0];
        
        [keyWindow insertSubview:self.cover atIndex:1];
    }
    
    return _previousView;
}

/// 遮盖
- (UIView *)cover {
    
    if (!_cover) {
        
        _cover = [[UIView alloc] initWithFrame:self.view.bounds];
        
        _cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:DZM_ALPHA_COVER_COLOR];
    }
    
    return _cover;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 禁用系统返回手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // 自定义返回手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.pan = pan;
}

#pragma mark - 手势事件

/// 自定义手势事件
- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    CGPoint point = [pan translationInView:self.view];
    
    if (point.x < 0 || point.x > self.view.bounds.size.width) { return ; }
    
    CGRect rect = self.view.bounds;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        self.previousVC = self.viewControllers[self.viewControllers.count - 2];
        
        [self.previousView addSubview:self.previousVC.view];
        
        self.previousView.transform = CGAffineTransformMakeScale(DZM_SCALE_IMAGE_VIEW, DZM_SCALE_IMAGE_VIEW);
        
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        
        self.view.transform = CGAffineTransformMakeTranslation(point.x, 0);
        
        self.cover.alpha = 1 - point.x / (rect.size.width / 2);
        
        CGFloat scale = MIN(DZM_SCALE_IMAGE_VIEW + point.x / (rect.size.width * DZM_SCALE_DRAG_RECT / (1 - DZM_SCALE_IMAGE_VIEW)), 1.0);
        
        self.previousView.transform = CGAffineTransformMakeScale(scale, scale);
        
    }else{
        
        __weak DZMDrawerNavigationController *weakSelf = self;
        
        if (point.x >= (rect.size.width * DZM_SCALE_DRAG_SUCCESS_RECT)) { // 拖拽成功
            
            [UIView animateWithDuration:DZM_AD_TIME animations:^{
                
                weakSelf.cover.alpha = 0;
                
                weakSelf.previousView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                
                weakSelf.view.transform = CGAffineTransformMakeTranslation(rect.size.width, 0);
                
            } completion:^(BOOL finished) {
                
                weakSelf.view.transform = CGAffineTransformIdentity;
                
                [weakSelf.cover removeFromSuperview];
                
                weakSelf.cover = nil;
                
                [weakSelf.previousVC.view removeFromSuperview];
                
                weakSelf.previousVC = nil;
                
                [weakSelf.previousView removeFromSuperview];
                
                weakSelf.previousView = nil;
                
                [super popViewControllerAnimated:NO];
            }];
            
        }else{ // 拖拽失败
            
            [UIView animateWithDuration:DZM_AD_TIME animations:^{
                
                weakSelf.cover.alpha = 1.0;
                
                weakSelf.previousView.transform = CGAffineTransformMakeScale(DZM_SCALE_IMAGE_VIEW, DZM_SCALE_IMAGE_VIEW);
                
                weakSelf.view.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
                [weakSelf.cover removeFromSuperview];
                
                weakSelf.cover = nil;
                
                [weakSelf.previousVC.view removeFromSuperview];
                
                weakSelf.previousVC = nil;
                
                [weakSelf.previousView removeFromSuperview];
                
                weakSelf.previousView = nil;
            }];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return self.childViewControllers.count > 1;
}

#pragma mark - 系统方法拦截

- (void)setInteractivePopGestureRecognizerEnabled:(BOOL)interactivePopGestureRecognizerEnabled {
    
    self.pan.enabled = interactivePopGestureRecognizerEnabled;
}

- (BOOL)interactivePopGestureRecognizerEnabled {
    
    return self.pan.isEnabled;
}

- (void)dzm_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (animated) {
        
        __weak DZMDrawerNavigationController *weakSelf = self;
        
        CGRect rect = self.view.bounds;
        
        self.cover.alpha = 0;
        
        self.previousVC = self.viewControllers.lastObject;
        
        [self.previousView addSubview:self.previousVC.view];
        
        self.view.transform = CGAffineTransformMakeTranslation(rect.size.width, 0);
        
        [super pushViewController:viewController animated:false];
        
        [UIView animateWithDuration:DZM_AD_TIME animations:^{
            
            weakSelf.cover.alpha = 1.0;
            
            weakSelf.previousView.transform = CGAffineTransformMakeScale(DZM_SCALE_IMAGE_VIEW, DZM_SCALE_IMAGE_VIEW);
            
            weakSelf.view.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            [weakSelf.cover removeFromSuperview];
            
            weakSelf.cover = nil;
            
            [weakSelf.previousVC.view removeFromSuperview];
            
            weakSelf.previousVC = nil;
            
            [weakSelf.previousView removeFromSuperview];
            
            weakSelf.previousView = nil;
        }];
        
    }else{ [super pushViewController:viewController animated:false]; }
}

- (void)dzm_popViewControllerAnimated:(BOOL)animated {
    
    if (animated) {
        
        __weak DZMDrawerNavigationController *weakSelf = self;
        
        CGRect rect = self.view.bounds;
        
        self.previousVC = self.viewControllers[self.viewControllers.count - 2];
        
        [self.previousView addSubview:self.previousVC.view];
        
        self.previousView.transform = CGAffineTransformMakeScale(DZM_SCALE_IMAGE_VIEW, DZM_SCALE_IMAGE_VIEW);
        
        [UIView animateWithDuration:DZM_AD_TIME animations:^{
            
            weakSelf.cover.alpha = 0;
            
            weakSelf.previousView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
            weakSelf.view.transform = CGAffineTransformMakeTranslation(rect.size.width, 0);
            
        } completion:^(BOOL finished) {
            
            weakSelf.view.transform = CGAffineTransformIdentity;
            
            [weakSelf.cover removeFromSuperview];
            
            weakSelf.cover = nil;
            
            [weakSelf.previousVC.view removeFromSuperview];
            
            weakSelf.previousVC = nil;
            
            [weakSelf.previousView removeFromSuperview];
            
            weakSelf.previousView = nil;
            
            [super popViewControllerAnimated:NO];
        }];
        
    }else{ [super popViewControllerAnimated:NO]; }
}

- (void)dzm_popToRootViewControllerAnimated:(BOOL)animated {
    
    if (animated) {
        
        __weak DZMDrawerNavigationController *weakSelf = self;
        
        CGRect rect = self.view.bounds;
        
        self.previousVC = self.viewControllers[self.viewControllers.count - 2];
        
        [self.previousView addSubview:self.previousVC.view];
        
        self.previousView.transform = CGAffineTransformMakeScale(DZM_SCALE_IMAGE_VIEW, DZM_SCALE_IMAGE_VIEW);
        
        [UIView animateWithDuration:DZM_AD_TIME animations:^{
            
            weakSelf.cover.alpha = 0;
            
            weakSelf.previousView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
            weakSelf.view.transform = CGAffineTransformMakeTranslation(rect.size.width, 0);
            
        } completion:^(BOOL finished) {
            
            weakSelf.view.transform = CGAffineTransformIdentity;
            
            [weakSelf.cover removeFromSuperview];
            
            weakSelf.cover = nil;
            
            [weakSelf.previousVC.view removeFromSuperview];
            
            weakSelf.previousVC = nil;
            
            [weakSelf.previousView removeFromSuperview];
            
            weakSelf.previousView = nil;
            
            [super popToRootViewControllerAnimated:NO];
        }];
        
    }else{ [super popToRootViewControllerAnimated:NO]; }
}

@end
