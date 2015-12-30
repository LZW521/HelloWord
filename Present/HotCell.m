//
//  HotCell.m
//  Present
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "HotCell.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
//#import "HotViewController.h"
@interface HotCell (){
    UILabel *_bigLabel;
    UILabel *_nameLabel;
    UILabel *_priceLabel;
    UILabel *_favoritesLabel;
    UIImageView *_imageView;
    UIImageView *_smallImageView;
}

@end

@implementation HotCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _bigLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bigLabel.backgroundColor = [UIColor whiteColor];
        _bigLabel.layer.cornerRadius = 15;
//        _bigLabel.alpha = 0.3;
        _bigLabel.clipsToBounds = YES;
        [self.contentView addSubview:_bigLabel];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-20, 155)];
        _imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_imageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_imageView.frame), frame.size.width-20, 40)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_nameLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameLabel.frame), 80, 20)];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_priceLabel];
        _smallImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame)+10, CGRectGetMaxY(_nameLabel.frame), 20, 20)];
        UIImage *image = [UIImage imageNamed:@"45.jpg"];
        _smallImageView.image = image;
        [self.contentView addSubview:_smallImageView];
        _favoritesLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_smallImageView.frame), CGRectGetMaxY(_nameLabel.frame), 50, 20)];
        _favoritesLabel.textColor = [UIColor grayColor];
        _favoritesLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_favoritesLabel];
        
    }
    return self;
}
-(void)setData:(HotDataModel *)model
{
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:nil];
    _nameLabel.text = model.name;
    _priceLabel.text = model.price;
    
    _favoritesLabel.text = model.favorites_count;
}
@end
