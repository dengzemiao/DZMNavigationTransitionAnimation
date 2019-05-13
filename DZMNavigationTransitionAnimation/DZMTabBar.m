//
//  DZMTabBar.m
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/13.
//  Copyright © 2019 DZM. All rights reserved.
//

#import "DZMTabBar.h"


@interface DZMTabBar()

@property(nonatomic,strong) NSMutableArray<UIButton *> *items;

@property(nonatomic,weak) UIView *spaceLine;

@end

@implementation DZMTabBar

- (NSMutableArray<UIButton *> *)items {
    
    if (!_items) {
        
        _items = [NSMutableArray array];
    }
    
    return _items;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubviews];
    }
    
    return self;
}

- (void)addSubviews {
    
    UIView *spaceLine = [[UIView alloc] init];
    spaceLine.backgroundColor = UIColor.grayColor;
    [self addSubview:spaceLine];
    self.spaceLine = spaceLine;
    
    NSArray *titles = @[@"gif", @"scroll"];
    
    for (int i = 0; i < titles.count; i++) {
        
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.tag = i;
        [item setTitle:titles[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [item addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        [self.items addObject:item];
    }
}

- (void)selectIndex:(NSInteger)index {
    
    self.items[index].selected = YES;
}

- (void)clickButton:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(tabBar:clickIndex:)]) {
        
        [self.delegate tabBar:self clickIndex:button.tag];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.spaceLine.frame = CGRectMake(0, 0, self.bounds.size.width, 0.5);
    
    CGFloat itemW = self.bounds.size.width / self.items.count;
   
    for (int i = 0; i < self.items.count; i++) {
        
        UIButton *button = self.items[i];
        
        button.frame = CGRectMake(i * itemW, 0, itemW, self.bounds.size.height);
    }
}

@end
