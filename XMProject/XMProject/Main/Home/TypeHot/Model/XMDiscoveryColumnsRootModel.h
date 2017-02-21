//
//  XMDiscoveryColumnsRootModel.h
//  XMProject
//
//  Created by wukexiu on 17/1/5.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMDiscoveryColumnsRootModel : NSObject

@property(nonatomic,copy)NSNumber *ret;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray *list;

@end

@interface XMDiscoveryColumnsDetailModel : NSObject

@property(nonatomic,copy)NSNumber *detailId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *coverPath;
@property(nonatomic,copy)NSString *contentType;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *sharePic;
@property(nonatomic,assign)BOOL enableShare;
@property(nonatomic,assign)BOOL isExternalUrl;
@property(nonatomic,copy)NSNumber *contentUpdatedAt;

@end
