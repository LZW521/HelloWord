//
//  PersonViewController.m
//  Present
//
//  Created by qianfeng on 15/12/19.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "PersonViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "PersonCell.h"
#import "PersonModel.h"
#import "DetailViewController.h"
#import "XWLoginController.h"
#define PATH @"http://api.liwushuo.com/v2/apps/android"
@interface PersonViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *_dataArray;
    UICollectionView *_collectionView;
    PersonModel *_model;
    NSMutableArray *_data;
}


@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray new];
    _model = [PersonModel new];
  
    _data = [NSMutableArray new];
    [self loadDataFromNet];
   
}
- (IBAction)buttonAction:(UIButton *)sender {
    XWLoginController *xw = [[XWLoginController alloc]init];
   
    [self.navigationController pushViewController:xw animated:YES];
}
-(void)loadDataFromNet{
    
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:PATH parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _model = [[PersonModel alloc]initWithData:responseObject error:nil];
        
        for (DownloadModel *downModel in _model.data.android_apps) {
            [_dataArray addObject:downModel];
            [_data addObject:downModel.download_url];
        }
        
        [_collectionView reloadData];
         [self createCollectionView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
    }];
}
- (UICollectionViewLayout *)createLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake((self.view.frame.size.width-30)/2, 100);
    layout.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    
    
    return layout;
}
-(void)createCollectionView{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 20)];
    label.text = @"推荐应用";
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 240, self.view.frame.size.width, self.view.frame.size.height-250) collectionViewLayout:[self createLayout]];
    
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.userInteractionEnabled = YES;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[PersonCell class] forCellWithReuseIdentifier:@"cellId"];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PersonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
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
