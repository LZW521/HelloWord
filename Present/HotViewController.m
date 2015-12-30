
//
//  HotViewController.m
//  Present
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "HotViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "HotCell.h"
#import "HotModel.h"
#import "DetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#define PATH @"http://api.liwushuo.com/v2/items?gender=1&limit=20&offset=%ld&generation=1"
@interface HotViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *_dataArray;
    UICollectionView *_collectionView;
    HotModel *_model;
    NSInteger offset;
    NSMutableArray *_data;
}

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    _model = [HotModel new];
    offset = 1;
    _data = [NSMutableArray new];
    [self createCollectionView];
}
-(void)loadDataFromNet:(BOOL)isMore{
    if (isMore) {
        
        if (_dataArray.count%20 == 0) {
            
            offset = _dataArray.count/20*19 + 1;
            
        }else{
            [_collectionView.mj_footer endRefreshing];
            return;
        }
    }
    if (!isMore) {
        
        
        [_dataArray removeAllObjects];
        [_data removeAllObjects];
        offset = 0;
        [_collectionView reloadData];
        
    }
    
    NSString *url = [NSString stringWithFormat:PATH,offset];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         _model = [[HotModel alloc]initWithData:responseObject error:nil];
        
        for (HotItemsModel *dataModel in _model.data.items) {
            [_dataArray addObject:dataModel.data1];
            [_data addObject:dataModel.data1.url];
        }

        [_collectionView reloadData];
         isMore?[_collectionView.mj_footer endRefreshing]:[_collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         isMore?[_collectionView.mj_footer endRefreshing]:[_collectionView.mj_header endRefreshing];
    }];
}
- (UICollectionViewLayout *)createLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.minimumLineSpacing = 20;
    layout.itemSize = CGSizeMake((self.view.frame.size.width-60)/2, 235);
    layout.sectionInset = UIEdgeInsetsMake(20,20,20,20);
    
    
    return layout;
}
-(void)createCollectionView{
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self createLayout]];
    
    
    _collectionView.backgroundColor = [UIColor colorWithRed:166/255.0 green:236/255.0 blue:1/255.0 alpha:1.0];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.userInteractionEnabled = YES;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[HotCell class] forCellWithReuseIdentifier:@"cellId"];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
        
    }];
    _collectionView.mj_header = header;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataFromNet:YES];
        
    }];
    _collectionView.mj_footer = footer;
    
    [_collectionView.mj_header beginRefreshing];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
  
    [cell setData:_dataArray[indexPath.item]];
  
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [[NSString alloc]initWithString:_data[indexPath.row]];
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.url = str;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
