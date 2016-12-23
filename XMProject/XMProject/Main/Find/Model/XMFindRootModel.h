//
//  XMFindRootModel.h
//  XMProject
//
//  Created by wukexiu on 16/12/22.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMFindRootModel.h"

@interface XMFindRootModel : NSObject
@property(nonatomic,copy)NSNumber *findRootId;
@property(nonatomic,copy)NSNumber *ret;
@property(nonatomic,copy)NSNumber *squareTabLastReadMillisecond;
@property(nonatomic,strong)NSArray *list;
@property(nonatomic,copy)NSString *msg;
@end

@interface XMFindModel : NSObject
@property(nonatomic,copy)NSNumber *findId;
@property(nonatomic,strong)NSArray *list;
@end

@interface XMFindDetailModel : NSObject
@property(nonatomic,copy)NSNumber *findDetailId;
@property(nonatomic,copy)NSString *contentType;
@property(nonatomic,copy)NSNumber *contentUpdatedAt;
@property(nonatomic,copy)NSString *coverPath;
@property(nonatomic,assign)BOOL enableShare;
@property(nonatomic,copy)NSNumber *categoryId;
@property(nonatomic,assign)BOOL isExternalUrl;
@property(nonatomic,copy)NSString *sharePic;
@property(nonatomic,copy)NSString *subCoverPath;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *url;
@end
