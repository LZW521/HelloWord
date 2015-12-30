//
//  SeaViewController.m
//  Present
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "SeaViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "MyCell.h"
#import "PresentModel.h"
#import "DetailViewController.h"
@interface SeaViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    PresentModel *_model;
    NSInteger offset;
    NSMutableArray *_data;
}

@end

@implementation SeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataArray = [NSMutableArray new];
    _data = [NSMutableArray new];
    offset = 1;
    [self createTableView];
    
   
}
- (void)perpareToLoadData:(BOOL)isMore {
    if (isMore) {
        if (_dataArray.count%20 == 0) {
            offset = _dataArray.count/20*20 + 1;
            
        }else{
            [_tableView.mj_footer endRefreshing];
            return;
        }
    }
    if (!isMore) {
        [_dataArray removeAllObjects];
        [_data removeAllObjects];
        
        offset = 0;
        [_tableView reloadData];
    }
    
    NSString *urlString = nil;
    
    urlString = [NSString stringWithFormat:_requestURL,_searchText,offset];
    NSLog(@"%@",urlString);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _model = [[PresentModel alloc]initWithData:responseObject error:nil];
        for (ItemsModel *itemModel in _model.data.items) {
            [_dataArray addObject:itemModel];
            [_data addObject:itemModel.content_url];
        }
        [_tableView reloadData];
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    }];
    
}
-(void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self perpareToLoadData:NO];
        
    }];
    _tableView.mj_header = header;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self perpareToLoadData:YES];
        
    }];
    _tableView.mj_footer = footer;
    
    [_tableView.mj_header beginRefreshing];

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
        return _dataArray.count;
    }
    
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        static NSString *identifier = @"cellIdentifier";
        MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        ItemsModel *model = _dataArray[indexPath.row];
        cell.model = model;
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [[NSString alloc]initWithString:_data[indexPath.row]];
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.url = str;
    [self.navigationController pushViewController:vc animated:YES];
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
