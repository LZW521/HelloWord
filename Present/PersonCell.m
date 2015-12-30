//
//  PersonCell.m
//  Present
//
//  Created by qianfeng on 15/12/19.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "PersonCell.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
//#import "HotViewController.h"
@interface PersonCell (){
    UILabel *_bigLabel;
    UILabel *_nameLabel;

    UILabel *_conment;
    UIImageView *_imageView;
}

@end
@implementation PersonCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _bigLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bigLabel.backgroundColor = [UIColor whiteColor];
        _bigLabel.layer.cornerRadius = 15;
        _bigLabel.clipsToBounds = YES;
        [self.contentView addSubview:_bigLabel];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        _imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_imageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, 10, 100, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        
        _conment = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, CGRectGetMaxY(_nameLabel.frame), 100, 40)];
        _conment.textColor = [UIColor grayColor];
        _conment.numberOfLines = 0;
        _conment.font = [UIFont systemFontOfSize:13];
          _conment.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_conment];
        
    }
    return self;
}
-(void)setData:(DownloadModel *)model
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.icon_url] placeholderImage:nil];
    _nameLabel.text = model.title;
    _conment.text = model.subtitle;
    
   
}
@end
