//
//  PresentBaseViewController.m
//  Present
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "PresentBaseViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "LeftViewController.h"
#import "SearchViewController.h"
#import <RESideMenu/RESideMenu.h>
@interface PresentBaseViewController ()

@end

@implementation PresentBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customNavgationBar];
    [self addNavgationTitleWithTitle:self.title];
    UIImage *image = [[UIImage imageNamed:@"top_navigation_menuicon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftbarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.leftBarButtonItem = leftbarButtonItem;
    
    UIImage *image1 = [[UIImage imageNamed:@"search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightbarButtonItem = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = rightbarButtonItem;
    
}
- (void)addNavgationTitleWithTitle:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:22];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}
-(void)search{
    SearchViewController *sc = [SearchViewController new];
    [self.navigationController pushViewController:sc animated:YES];
}
- (IBAction)presentLeftMenuViewController:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)customNavgationBar{
    UIImage *image = [UIImage imageNamed:@"tabbar_bg"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
