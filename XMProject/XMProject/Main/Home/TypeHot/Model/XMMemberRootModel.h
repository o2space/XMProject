//
//  XMMemberRootModel.h
//  XMProject
//
//  Created by wukexiu on 17/1/5.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMMemberRootModel : NSObject

@property(nonatomic,copy)NSNumber *ret;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL hasMore;
@property(nonatomic,strong)NSArray *list;

@end

@interface XMMemberRootDetailModel : NSObject

@property(nonatomic,copy)NSNumber *uid;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subTitle;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSArray *ownerTitle;
@property(nonatomic,copy)NSString *bannerUrl;
@property(nonatomic,assign)BOOL isAuthorizedMember;
@property(nonatomic,copy)NSNumber *memberProductId;

@end
