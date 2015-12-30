//
//  AppDelegate.m
//  Present
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "AppDelegate.h"
#import "PresentTabBarController.h"
#import "LeftViewController.h"
#import <MMDrawerController/MMDrawerController.h>
#import <RESideMenu/RESideMenu.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    PresentTabBarController *ptb = [[PresentTabBarController alloc]init];
    LeftViewController *leftView = [LeftViewController new];
    
    ptb.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
    
//     MMDrawerController *drawController = [[MMDrawerController alloc] initWithCenterViewController:ptb leftDrawerViewController:leftView rightDrawerViewController:nil];
//    // 设置左边视图窗口的大小
//    drawController.maximumLeftDrawerWidth = 280;
//    // 设置是否显示阴影
//    drawController.showsShadow = NO;
//    // 设置打开抽屉的手势(全部)
//    drawController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
//    // 设置关闭抽屉的手势
//    drawController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
//    self.window.rootViewController = drawController;
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:ptb leftMenuViewController:leftView rightMenuViewController:nil];
 self.window.rootViewController = sideMenuViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
