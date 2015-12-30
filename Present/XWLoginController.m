//
//  PersonViewController.h
//  Present
//
//  Created by qianfeng on 15/12/19.
//  Copyright © 2015年 刘泽威. All rights reserved.
//


#import "XWLoginController.h"
#import "XWRegisterController.h"

@interface XWLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *lossPassword;

@property (weak, nonatomic) IBOutlet UIButton *qucikRegisterBtn;


- (IBAction)registerClick:(id)sender;

@end

@implementation XWLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavRight];
    [self addGesture];
}

#pragma mark 添加退出当前页的按钮
-(void)setupNavRight
{
    self.title=@"登陆";
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"] forState:UIControlStateNormal];
    self.lossPassword.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.lossPassword.contentEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    [self.lossPassword setBackgroundImage:[UIImage imageNamed:@"login_forgot_button"] forState:UIControlStateNormal];
    self.qucikRegisterBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.qucikRegisterBtn.contentEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    [self.qucikRegisterBtn setBackgroundImage:[UIImage imageNamed:@"login_forgot_button"] forState:UIControlStateNormal];
}


#pragma mark 给当前view添加识别手势
-(void)addGesture
{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

-(void)tap
{
    [self.view endEditing:YES];
}

-(void)quit
{
    if(self.dismissType){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (IBAction)registerClick:(id)sender {
    XWRegisterController *regist=[[XWRegisterController alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
    
}
@end











