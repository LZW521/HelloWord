//
//  FirstViewController.m
//  Present
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "FirstViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "MyCell.h"
#import "PresentModel.h"
#import "ScrModel.h"
#import "DetailViewController.h"
#define PATH1 @"http://api.liwushuo.com/v2/channels/111/items?gender=1&limit=20&offset=%ld&generation=1"
#define PATH2 @"http://api.liwushuo.com/v2/banners"
@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    PresentModel *_model;
    NSArray *_nameArray;
    UIScrollView *_scrollView;
    UIScrollView *_bigScrollView;
    UILabel *_label;
    CGFloat _screenWidth;
    UIButton *_button;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
    UIScrollView *_scrollView1;
    UIPageControl *_pageControl;
  
    NSInteger offset;
    NSMutableArray *_data;
}
@end
@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _nameArray = [NSArray new];
    _dataArray = [NSMutableArray new];
    _dataArray1 = [NSMutableArray new];
     _dataArray2 = [NSMutableArray new];
    _data = [NSMutableArray new];
    offset = 1;
    
   
    [self createBigScrollView];
    [self createScrollView];
    [self createTableView];
    [self createButton];
    [self addTableView];
    [self createScrollView1];
    [self initData];
    [self creatrPage];
}
- (void)createScrollView1 {
    _scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,210)];

    _scrollView1.contentSize = CGSizeMake(self.view.frame.size.width*_dataArray1.count, 210);
    _scrollView1.showsHorizontalScrollIndicator =NO;
    _scrollView1.pagingEnabled =YES;
    _scrollView1.delegate = self;
   
    [self createScrollImage];
}

- (void)createScrollImage {
    for (int i = 0; i < _dataArray1.count; i++) {
        UIImageView *imgeView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollView1.frame.size.width*(i+1), 0, self.view.frame.size.width, 210)];
        [imgeView sd_setImageWithURL:_dataArray1[i]];
        [_scrollView1 addSubview:imgeView];
        
        if (i == 0) {
                UIImageView *imgeView = [[UIImageView alloc] initWithFrame:CGRectMake((_dataArray1.count+1)*_scrollView1.frame.size.width, 0, _scrollView1.frame.size.width, 210)];
                [imgeView sd_setImageWithURL:_dataArray1[0]];
                [_scrollView1 addSubview:imgeView];
        }
        if (i == _dataArray1.count-1) {
            UIImageView *imgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView1.frame.size.width, 210)];
            [imgeView sd_setImageWithURL:_dataArray1[_dataArray1.count-1]];
            [_scrollView1 addSubview:imgeView];
        }
        _scrollView1.contentSize = CGSizeMake((_dataArray1.count + 2)*_scrollView1.frame.size.width, _scrollView1.frame.size.height);
        _scrollView1.contentOffset = CGPointMake(CGRectGetWidth(_scrollView1.frame), 0);
        _scrollView1.pagingEnabled = YES;
        _scrollView1.showsHorizontalScrollIndicator = NO;
        _scrollView1.delegate = self;
    }
}
-(void)initData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:PATH2 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      ScrModel *model = [[ScrModel alloc]initWithData:responseObject error:nil];
        for (BannersModel *bannersModel in model.data.banners) {
            [_dataArray1 addObject:bannersModel.image_url];
            [_dataArray2 addObject:bannersModel.target_url];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
-(void)loadDataFromNet:(BOOL)isMore{
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
    NSString *url = [NSString stringWithFormat:PATH1,(long)offset];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _model = [[PresentModel alloc]initWithData:responseObject error:nil];
        for (ItemsModel *itemModel in _model.data.items) {
            [_dataArray addObject:itemModel];
            [_data addObject:itemModel.content_url];
        }
        [self createScrollView1];
        _tableView.tableHeaderView = _scrollView1;
        [_tableView reloadData];
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    }];
}
- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}
- (void)createBigScrollView {
    _bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _bigScrollView.delegate = self;
    _bigScrollView.contentSize = CGSizeMake(4*self.view.frame.size.width, self.view.frame.size.height);
    _bigScrollView.pagingEnabled = YES;
    _bigScrollView.showsHorizontalScrollIndicator = NO;
    _bigScrollView.showsVerticalScrollIndicator = NO;
    _bigScrollView.alwaysBounceHorizontal = NO;
    [self.view addSubview:_bigScrollView];
}
-(void)addTableView{
    for (NSInteger i = 0; i < _nameArray.count-1; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*(i+1), 40, self.view.frame.size.width, self.view.frame.size.height-64-90) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0  blue:arc4random()%255/255.0  alpha:1];
        [_bigScrollView addSubview:tableView];
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [tableView.mj_header endRefreshing];
        }];
        tableView.mj_header = header;
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [tableView.mj_footer endRefreshing];
        }];
        tableView.mj_footer = footer;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _bigScrollView) {
        NSInteger index = _bigScrollView.contentOffset.x/self.view.frame.size.width;
        _tableView = _bigScrollView.subviews[index];
        UIButton *button = (UIButton *)[self.view viewWithTag:index+100];
        _button.selected = NO;
        _button.transform = CGAffineTransformMakeScale(1, 1);
        button.selected = YES;
        _button = button;
        _button.transform = CGAffineTransformMakeScale(1.1, 1.1);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"NewsURLs" ofType:@"plist"];
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:plistPath];
        int a = _bigScrollView.contentOffset.x/self.view.frame.size.width;
        NSString *str= [NSString stringWithString:array[a][@"url"]];
      [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _model = [[PresentModel alloc]initWithData:responseObject error:nil];
            [_dataArray removeAllObjects];
            [_data removeAllObjects];
            [_tableView reloadData];
            for (ItemsModel *itemModel in _model.data.items) {
                [_dataArray addObject:itemModel];
                [_data addObject:itemModel.content_url];
            }
            [_tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
    if (scrollView == _scrollView1) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_scrollView1 addGestureRecognizer:tap];
    }
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    float b = _scrollView1.contentOffset.x/self.view.frame.size.width;
    int a = b-1;
    NSString *str = [[NSString alloc]initWithString:_dataArray2[a]];
    NSLog(@"%d",a);
    
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.url = str;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _bigScrollView) {
        [UIView animateWithDuration:0.5 animations:^{
//            if ((_bigScrollView.contentOffset.x/self.view.frame.size.width) < 3) {
            _label.frame = CGRectMake(scrollView.contentOffset.x/_bigScrollView.frame.size.width*_screenWidth, CGRectGetMaxY(_button.frame)-1, _screenWidth, 2);
//            }
                   }];
        
    }
    if (scrollView == _scrollView1) {
        if (scrollView.contentOffset.x == 0) {
            scrollView.contentOffset = CGPointMake(_scrollView1.frame.size.width*_dataArray1.count, 0);
        }
        if (scrollView.contentOffset.x == (_dataArray1.count+1)*_scrollView1.frame.size.width) {
            scrollView.contentOffset = CGPointMake(_scrollView1.frame.size.width, 0);
        }
        
        CGPoint offSet = scrollView.contentOffset;
         NSInteger index = offSet.x/scrollView.frame.size.width + 0.5;
        _pageControl.currentPage = index-1;
        
    }
}
- (void)creatrPage {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(150, 220, 100, 20)];
    _pageControl.numberOfPages = _dataArray1.count;

    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];

    _pageControl.pageIndicatorTintColor = [UIColor grayColor];

    [self.view addSubview:_pageControl];
}
-(void)createButton{
    _nameArray = @[@"礼物",@"海淘",@"美食",@"数码"];
    _screenWidth = self.view.frame.size.width/4;
    for (NSInteger i = 0; i < _nameArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(_screenWidth*i, 0, _screenWidth, 35);
        [button setTitle:_nameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         button.tag = 100+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
       
        button.userInteractionEnabled = YES;
        [_scrollView addSubview:button];
        if (i == 0) {
            button.selected = YES;
            _button = button;
            _button.transform = CGAffineTransformMakeScale(1.2, 1.2);
            _label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)-1, _screenWidth, 2)];
            _label.backgroundColor = [UIColor redColor];
            [_scrollView addSubview:_label];
        }
    }
    _scrollView.contentSize = CGSizeMake(_screenWidth*_nameArray.count, 40);
    _scrollView.showsHorizontalScrollIndicator = NO;
}
- (void)buttonClick:(UIButton *)button {
    
    if (_button == button) {
        return;
    }
    button.selected = YES;
    _button.selected = NO;
    _button.transform = CGAffineTransformMakeScale(1, 1);
    _button = button;
    _button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.5 animations:^{
        _label.frame = CGRectMake(CGRectGetMinX(_button.frame), CGRectGetMaxY(_button.frame)-1, _screenWidth, 2);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _bigScrollView.contentOffset = CGPointMake(self.view.frame.size.width*(button.tag-100), 0);
    }];
    if (button.tag>100&&button.tag<=103) {
        
    
    _tableView = _bigScrollView.subviews[button.tag-100];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"NewsURLs" ofType:@"plist"];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:plistPath];
   
    NSString *str= [NSString stringWithString:array[button.tag-100][@"url"]];
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _model = [[PresentModel alloc]initWithData:responseObject error:nil];
        [_dataArray removeAllObjects];
        [_data removeAllObjects];
        [_tableView reloadData];
        for (ItemsModel *itemModel in _model.data.items) {
            [_dataArray addObject:itemModel];
            [_data addObject:itemModel.content_url];
        }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    }
}

-(void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-64-90) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _scrollView1;
    [_bigScrollView addSubview:_tableView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataFromNet:NO];
        
    }];
    _tableView.mj_header = header;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataFromNet:YES];
        
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
    if (tableView == _tableView) {
    static NSString *identifier = @"cellIdentifier";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    ItemsModel *model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
    }
    static NSString *identifier = @"identifier";
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
@end
