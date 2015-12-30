//
//  HotModel.h
//  Present
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol HotItemsModel

@end

@interface HotDataModel : JSONModel
@property (nonatomic,copy)NSString *cover_image_url;
@property (nonatomic,copy)NSString *favorites_count;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *url;
@end


@interface HotItemsModel : JSONModel
@property (nonatomic,strong)HotDataModel *data1;
@end


@interface HotDataItemsModel : JSONModel
@property (nonatomic,strong)NSMutableArray <HotItemsModel> *items;
@end

@interface HotModel : JSONModel
@property (nonatomic,strong)HotDataItemsModel *data;
@end
