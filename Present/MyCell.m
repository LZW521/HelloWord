//
//  MyCell.m
//  Present
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import "MyCell.h"
#import <UIImageView+WebCache.h>
@implementation MyCell{
    UILabel *_titleLabel;
    UIImageView *_coverImageView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customViews];
    }
    return self;
}
- (void)customViews {
    
    _coverImageView = [UIImageView new];
    [self.contentView addSubview:_coverImageView];
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
}
- (void)setModel:(ItemsModel *)model {
    
    _model = model;
        _titleLabel.text = model.title ;
    _titleLabel.textColor = [UIColor greenColor];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:15];
        [_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:nil];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.clipsToBounds = YES;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leftPadding = 10;
    CGFloat topPadding = 10;
     CGFloat width = CGRectGetWidth([[UIScreen mainScreen]bounds]);
    _coverImageView.frame = CGRectMake(leftPadding, topPadding, width-2*leftPadding, 160);
    
    _titleLabel.frame = CGRectMake(leftPadding+10, topPadding+120, width-2*leftPadding, 40);
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
