//
//  XMLiveRootModel.h
//  XMProject
//
//  Created by wukexiu on 17/1/6.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLiveRootModel : NSObject

@property(nonatomic,strong)NSArray *data;
@property(nonatomic,copy)NSNumber *ret;

@end

@interface XMLiveModel : NSObject

@property(nonatomic,copy)NSNumber *chatId;
@property(nonatomic,copy)NSString *coverPath;
@property(nonatomic,copy)NSNumber *endTs;
@property(nonatomic,copy)NSNumber *liveId;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSNumber *onlineCount;
@property(nonatomic,copy)NSNumber *playCount;
@property(nonatomic,copy)NSNumber *scheduleId;
@property(nonatomic,copy)NSString *shortDescription;
@property(nonatomic,copy)NSNumber *startTs;
@property(nonatomic,copy)NSNumber *status;

@end
