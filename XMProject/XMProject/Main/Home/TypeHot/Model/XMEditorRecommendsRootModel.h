//
//  XMEditorRecommendsRootModel.h
//  XMProject
//
//  Created by wukexiu on 17/1/6.
//  Copyright © 2017年 wukexiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMEditorRecommendsRootModel : NSObject

@property(nonatomic,copy)NSNumber *ret;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL hasMore;
@property(nonatomic,strong)NSArray *list;

@end

@interface XMEditorRecommendsDetailModel : NSObject

@end
