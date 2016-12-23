//
//  XMFindViewModel.m
//  XMProject
//
//  Created by wukexiu on 16/12/23.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMFindViewModel.h"
#import "NetworkTools.h"
//http://mobile.ximalaya.com/mobile/v1/no_read?device=iPhone&squareTabLastReadMillisecond=1482466546305&uid=67384161&version=5.4.57
//http://mobile.ximalaya.com/mobile/v1/homePage?device=iPhone&uid=67384161
static NSString *const kFindAPI = @"http://mobile.ximalaya.com/mobile/discovery/v1/square/list?cityCode=43_310000_3100&device=iPhone&uid=67384161&version=";

@implementation XMFindViewModel

-(void) refreshDataSource{
    [[NetworkTools shareInstance] requestDataWithURL:kFindAPI success:^(id responseObject) {
        _findRootModel = [[XMFindRootModel alloc] mj_setKeyValues:responseObject];
        if (_updateBlock) {
            _updateBlock();
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
