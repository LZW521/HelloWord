//
//  PresentTabBarController.m
//  
//
//  Created by qianfeng on 15/12/15.
//
//

#import "PresentTabBarController.h"
#import "PresentBaseViewController.h"
@interface PresentTabBarController ()

@end

@implementation PresentTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewControllers];
    [self createSplashView];
    
}
-(void)createViewControllers{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"AppButton" ofType:@"plist"];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:plistPath];
    NSMutableArray *controllers = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        Class class = NSClassFromString(dict[@"className"]);
        PresentBaseViewController *pvc = [[class alloc]init];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:pvc];
        pvc.tabBarItem.selectedImage = [[UIImage imageNamed:dict[@"highlighted"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        pvc.tabBarItem.image = [[UIImage imageNamed:dict[@"nomal"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        pvc.title = [NSString stringWithString:dict[@"title"]];
       
        [controllers addObject:nvc];
    }
  
    
    self.viewControllers = controllers;
}
-(void)createSplashView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"23.jpg"];
    [self.view addSubview:imageView];
    [UIView animateWithDuration:3 animations:^{
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
