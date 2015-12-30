//
//  PresentModel.h
//  Present
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ItemsModel

@end

@interface ItemsModel : JSONModel
@property (nonatomic,copy)NSString *content_url;
@property (nonatomic,copy)NSString *cover_image_url;
@property (nonatomic,copy)NSString *title;
@end

@interface DataModel : JSONModel
@property (nonatomic,strong)NSMutableArray <ItemsModel> *items;
@end


@interface PresentModel : JSONModel
@property (nonatomic,strong)DataModel *data;
@end
