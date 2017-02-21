//
//  XMHotRecommendsRootModel.h
//  XMProject
//
//  Created by wukexiu on 17/1/6.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMHotRecommendsRootModel : NSObject

@property(nonatomic,copy)NSNumber *ret;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray *list;

@end

@interface XMHotRecommendsModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *contentType;
@property(nonatomic,assign)BOOL isFinished;
@property(nonatomic,copy)NSNumber *categoryId;
@property(nonatomic,copy)NSNumber *categoryType;
@property(nonatomic,copy)NSNumber *count;
@property(nonatomic,assign)BOOL hasMore;
@property(nonatomic,strong)NSArray *list;
@property(nonatomic,assign)BOOL filterSupported;
@property(nonatomic,assign)BOOL isPaid;

@end

@interface XMHotRecommendsDetailModel : NSObject

@property(nonatomic,copy)NSNumber *detailId;
@property(nonatomic,copy)NSNumber *albumId;
@property(nonatomic,copy)NSNumber *uid;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *albumCoverUrl290;
@property(nonatomic,copy)NSString *coverSmall;
@property(nonatomic,copy)NSString *coverMiddle;
@property(nonatomic,copy)NSString *coverLarge;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *tags;
@property(nonatomic,copy)NSNumber *tracks;
@property(nonatomic,copy)NSNumber *playsCounts;
@property(nonatomic,copy)NSNumber *isFinished;
@property(nonatomic,copy)NSNumber *serialState;
@property(nonatomic,copy)NSNumber *trackId;
@property(nonatomic,copy)NSString *trackTitle;
@property(nonatomic,copy)NSString *recSrc;
@property(nonatomic,copy)NSString *recTrack;
@property(nonatomic,copy)NSString *provider;
@property(nonatomic,assign)BOOL isPaid;
@property(nonatomic,copy)NSNumber *commentsCount;
@property(nonatomic,copy)NSNumber *priceTypeId;
@property(nonatomic,copy)NSNumber *price;
@property(nonatomic,copy)NSNumber *discountedPrice;
@property(nonatomic,copy)NSNumber *score;
@property(nonatomic,copy)NSString *displayPrice;
@property(nonatomic,copy)NSString *displayDiscountedPrice;
@property(nonatomic,copy)NSNumber *priceTypeEnum;

@end
