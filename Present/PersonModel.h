//
//  PersonModel.h
//  Present
//
//  Created by qianfeng on 15/12/19.
//  Copyright © 2015年 刘泽威. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol DownloadModel

@end


@interface DownloadModel : JSONModel
@property (nonatomic,copy)NSString *download_url;
@property (nonatomic,copy)NSString *icon_url;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subtitle;
@end

@interface PersonDataModel : JSONModel
@property (nonatomic,strong)NSMutableArray <DownloadModel>*android_apps;

@end


@interface PersonModel : JSONModel
@property (nonatomic,strong)PersonDataModel *data;
@end
