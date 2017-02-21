//
//  XMHomeHotViewModel.h
//  XMProject
//
//  Created by wukexiu on 16/12/26.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMMemberRootModel.h"
#import "XMDiscoveryColumnsRootModel.h"
#import "XMGuessRootModel.h"
#import "XMCityColumnRootModel.h"
#import "XMHotRecommendsRootModel.h"
#import "XMLiveRootModel.h"

@interface XMHomeHotViewModel : NSObject


//http://mobile.ximalaya.com/mobile/discovery/v2/recommend/hotAndGuess?code=43_310000_3100&device=iPhone&version=5.4.57
//discoveryColumns//分类
//guess//猜你喜欢的
//cityColumn//城市推荐 听上海
//hotRecommends

//http://live.ximalaya.com/live-activity-web/v3/activity/recommend
//liveList //现场直播

//http://mobile.ximalaya.com/mobile/discovery/v4/recommends?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.57
//editorRecommendAlbums//小编推荐
//focusImages  //图片轮番
//specialColumn//精品听单

//http://adse.ximalaya.com/ting/feed?appid=0&device=iPhone&name=find_native&network=WIFI&operator=3&scale=2&version=5.4.57
//ad//广告


@property(nonatomic,strong)XMMemberRootModel *memberRootModel;
@property(nonatomic,strong)XMDiscoveryColumnsRootModel *discoveryColumnsRootModel;
@property(nonatomic,strong)XMGuessRootModel *guessRootModel;
@property(nonatomic,strong)XMCityColumnRootModel *cityColumnRootModel;
@property(nonatomic,strong)XMHotRecommendsRootModel *hotRecommendsRootModel;

@property(nonatomic,strong)XMLiveRootModel *liveRootModel;

@property(nonatomic,copy) void (^updateBlock)();
-(void) refreshDataSource;
@end
