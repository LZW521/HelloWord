//
//  LeftViewController.m
//  Present
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "LeftViewController.h"
#define SNOW_W   35
#define SNOW_H   35
#define kScreenSize [UIScreen mainScreen].bounds.size
@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
}
- (void)updateTimer:(NSTimer*)timer
{
    NSInteger w = kScreenSize.width;
    CGFloat startXPos = arc4random()%w;
    CGFloat endXPos   = arc4random()%w;
    UIImageView *snowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(startXPos, -SNOW_H, SNOW_W, SNOW_H)];
    snowImageView.image = [UIImage imageNamed:@"flake"];
    [self.view addSubview:snowImageView];
    
    [UIView animateWithDuration:5 animations:^{
 
        CGRect endFrame = CGRectMake(endXPos, kScreenSize.height-SNOW_H, SNOW_W, SNOW_H);
        snowImageView.frame = endFrame;
        snowImageView.alpha = 1.0;
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:1 animations:^{
            snowImageView.alpha = 0.0;
        } completion:^(BOOL finished) {

            [snowImageView removeFromSuperview];
        }];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
