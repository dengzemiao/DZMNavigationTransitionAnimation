//
//  DZMGifController.m
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/13.
//  Copyright © 2019 DZM. All rights reserved.
//

#import "DZMGifController.h"
#import "DZMTabBar.h"

@interface DZMGifController ()<DZMTabBarDelegate>

/// 自定义导航栏
@property(nonatomic,weak) DZMNavigationBar *customNavigationBar;

/// 自定义导航栏
@property(nonatomic,weak) UINavigationItem *customNavigationItem;

/// tabBar
@property(nonatomic,weak) DZMTabBar *tabBar;

/// GIF
@property(nonatomic,weak) UIImageView *imageView;

@end

@implementation DZMGifController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置title
    if (self.tag > 0) { self.title = [NSString stringWithFormat:@"%ld",(long)self.tag]; }
    
    // 背景
    self.view.backgroundColor = UIColor.whiteColor;

    // 图片视图
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    imageView.frame = CGRectMake(0, (arc4random()%(int)([UIScreen mainScreen].bounds.size.height/2)), [UIScreen mainScreen].bounds.size.width, 200);
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    // 添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    [imageView addGestureRecognizer:tap];
    
    // 播放GIF
    
    // GIF地址
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"temp" withExtension:@"gif"];
    
    // 将GIF图片转换成对应的图片源
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    
    // 获取其中图片源个数，即由多少帧图片组成
    size_t frameCount = CGImageSourceGetCount(gifSource);
    
    // 定义数组存储拆分出来的图片
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    
    for (size_t i = 0 ; i < frameCount ; i++) {
        
        // 从GIF图片中取出源图片
        CGImageRef imageRef=CGImageSourceCreateImageAtIndex(gifSource , i , NULL);
        
        // 将图片源转换成UIimageView能使用的图片源
        UIImage* imageName=[UIImage imageWithCGImage:imageRef];
        
        // 将图片加入数组中
        [frames addObject:imageName];
        
        CGImageRelease(imageRef);
    }
    
    // 将图片数组加入UIImageView动画数组中
    self.imageView.animationImages = frames;
    
    // 每次动画时长
    self.imageView.animationDuration = 0.9;
    
    // 开始动画
    [self.imageView startAnimating];
    
    // 自定义导航栏(建议封装到一个base控制器里面)
    [self initCustomNavigationBar];
    
    // 自定义TabBar(建议封装到一个base控制器里面)
    if (!self.tag) { [self initTabBar]; }
}

- (void)initTabBar {
    
    DZMTabBar *tabBar = [[DZMTabBar alloc] initWithFrame:CGRectMake(0, DZM_SCREEN_SIZE.height - DZM_HEIGHT_TAB_BAR, DZM_SCREEN_SIZE.width, DZM_HEIGHT_TAB_BAR)];
    tabBar.delegate = self;
    [tabBar selectIndex:0];
    [self.view addSubview:tabBar];
    self.tabBar = tabBar;
}

- (void)initCustomNavigationBar {
    
    DZMNavigationBar *customNavigationBar = [[DZMNavigationBar alloc] initWithFrame:CGRectMake(0, 0, DZM_SCREEN_SIZE.width, DZM_HEIGHT_NAVIGATION_BAR)];
    
    UINavigationItem *customNavigationItem = [[UINavigationItem alloc] init];
    
    customNavigationItem.title = self.title;
    
    customNavigationItem.leftBarButtonItem = self.navigationItem.leftBarButtonItem;
    
    customNavigationBar.items = @[customNavigationItem];
    
    customNavigationBar.barCustomBackgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:customNavigationBar];
    
    self.customNavigationBar = customNavigationBar;
    
    self.customNavigationItem = customNavigationItem;
}

- (void)clickTap {
    
    DZMGifController *vc = [[DZMGifController alloc] init];
    
    vc.tag = self.tag + 1;
    
    [self.navigationController dzm_pushViewController:vc animated:YES];
}

#pragma mark -- DZMTabBarDelegate

- (void)tabBar:(DZMTabBar *)tabBar clickIndex:(NSInteger)index {
    
    self.tabBarController.selectedIndex = index;
}

- (void)dealloc {
    
    NSLog(@"%ld 释放了",(long)self.tag);
}

@end
