//
//  PersonViewController.h
//  Present
//
//  Created by qianfeng on 15/12/19.
//  Copyright © 2015年 刘泽威. All rights reserved.
//


#import "XWRegisterController.h"

@interface XWRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *regisButton;

- (IBAction)getCode:(id)sender;
@end

@implementation XWRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavRight];
}

- (void)setupNavRight {
    self.title=@"注册";
    self.view.backgroundColor=[UIColor whiteColor];
    self.phone.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.phone.layer.borderWidth=1.0;
    self.phone.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 30)];
    self.phone.leftViewMode=UITextFieldViewModeAlways;
    self.phone.keyboardType=UIKeyboardTypeNumberPad;
    [self.regisButton setBackgroundImage:[UIImage imageNamed:@"go_to_taskCentre_button"] forState:UIControlStateNormal];
}

#pragma mark 退出的方法
-(void)quitRegis
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)getCode:(id)sender {
    
}
@end
