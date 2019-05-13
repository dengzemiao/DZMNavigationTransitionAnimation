//
//  DZMTableViewController.m
//  DZMNavigationTransitionAnimation
//
//  Created by dengzemiao on 2019/5/13.
//  Copyright © 2019 DZM. All rights reserved.
//

#import "DZMTableViewController.h"
#import "DZMTabBar.h"

@interface DZMTableViewController ()<DZMTabBarDelegate,UITableViewDelegate,UITableViewDataSource>

/// 自定义导航栏
@property(nonatomic,weak) DZMNavigationBar *customNavigationBar;

/// 自定义导航栏
@property(nonatomic,weak) UINavigationItem *customNavigationItem;

/// tabBar
@property(nonatomic,weak) DZMTabBar *tabBar;

/// tableView
@property(nonatomic,weak) UITableView *tableView;

@end

@implementation DZMTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置title
    if (self.tag > 0) { self.title = [NSString stringWithFormat:@"%ld",(long)self.tag]; }
    
    // 背景
    self.view.backgroundColor = UIColor.whiteColor;

    // tableView
    [self initTableView];
    
    // 自定义导航栏(建议封装到一个base控制器里面)
    [self initCustomNavigationBar];
    
    // 自定义TabBar(建议封装到一个base控制器里面)
    // 这里判断是我不想写太多子控制器了。
    if (!self.tag) { [self initTabBar]; }
}

- (void)initTableView {
    
    CGFloat tableViewHeight = DZM_SCREEN_SIZE.height - DZM_HEIGHT_NAVIGATION_BAR - (self.tag ? 0 : DZM_HEIGHT_TAB_BAR);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, DZM_HEIGHT_NAVIGATION_BAR, DZM_SCREEN_SIZE.width, tableViewHeight)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)initTabBar {
    
    DZMTabBar *tabBar = [[DZMTabBar alloc] initWithFrame:CGRectMake(0, DZM_SCREEN_SIZE.height - DZM_HEIGHT_TAB_BAR, DZM_SCREEN_SIZE.width, DZM_HEIGHT_TAB_BAR)];
    tabBar.delegate = self;
    [tabBar selectIndex:1];
    [self.tableView.superview addSubview:tabBar];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DZMTableViewController"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DZMTableViewController"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DZMTableViewController *vc = [[DZMTableViewController alloc] init];
    
    vc.tag = self.tag + 1;
    
    [self.navigationController dzm_pushViewController:vc animated:YES];
}

#pragma mark -- DZMTabBarDelegate

- (void)tabBar:(DZMTabBar *)tabBar clickIndex:(NSInteger)index {
    
    self.tabBarController.selectedIndex = index;
}

@end
