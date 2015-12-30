//
//  SearchViewController.m
//  Present
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "SearchViewController.h"
#import "NSString+Common.h"
#import "SeaViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createBack];
    [self createSearchBar];
    [self createLabel];
}
-(void)createBack{
    UIImage *imag = [UIImage imageNamed:@"888"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.image = imag;
    [self.view addSubview:imageView];
}
-(void)createLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Avenir-Oblique" size:15];
    label.text = @"搜索礼物——请输入111   搜索海淘——请输入129\n\n搜索美食——请输入118   搜索数码——请输入121\n\n搜索运动——请输入123    搜索创意——请输入125\n\n搜索家居——请输入112   搜索感谢——请输入36\n\n搜索送爸爸妈妈——请输入6\n\n搜索纪念日——请输入31\n\n搜索送女朋友——请输入10\n\n搜索乔迁——请输入35\n\n搜索科技范——请输入28\n\n搜索涨姿势——请输入120";
    [self.view addSubview:label];
}
- (void)createSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0)];
    searchBar.placeholder = @"search";
    searchBar.delegate = self;
    
    [self.view addSubview:searchBar];
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
    for (UIView *view in [searchBar.subviews[0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length > 0) {
        SeaViewController *searchViewController = [SeaViewController new];
        searchViewController.requestURL = @"http://api.liwushuo.com/v2/channels/%@/items?gender=1&limit=20&offset=%ld&generation=1";
        searchViewController.searchText = URLEncodedString(searchBar.text);
        searchViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchViewController animated:YES];
    }
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    
    
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
