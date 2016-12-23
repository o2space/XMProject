//
//  XMFindViewModel.h
//  XMProject
//
//  Created by wukexiu on 16/12/23.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMFindRootModel.h"

@interface XMFindViewModel : NSObject

@property(nonatomic,strong)XMFindRootModel *findRootModel;
@property(nonatomic,copy) void (^updateBlock)();
-(void) refreshDataSource;
@end
