//
//  DetailViewController.m
//  ZZ15171002LiuZeWei
//
//  Created by qianfeng on 15/12/12.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>

#import "PresentModel.h"
@interface DetailViewController ()

@property (nonatomic, strong)WKWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updataImageURL];
}
- (void)updataImageURL{
  
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50)];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView.allowsBackForwardNavigationGestures = YES;
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
