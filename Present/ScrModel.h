//
//  ScrModel.h
//  Present
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol BannersModel

@end

@interface BannersModel : JSONModel
@property (nonatomic,copy)NSString *target_url;
@property (nonatomic,copy)NSString *image_url;

@end

@interface DataModel1 : JSONModel
@property (nonatomic,strong)NSMutableArray <BannersModel> *banners;
@end
@interface ScrModel : JSONModel
@property (nonatomic,strong)DataModel1 *data;
@end
