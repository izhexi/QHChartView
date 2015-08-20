//
//  LWUtil.h
//  QHSimpleFrame
//
//  Created by imqiuhang on 15/3/31.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

/**
 *  @author imqiuhang
 *
 *  @brief  一些常用的公共方法
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface QHUtil: NSObject

+ (UIColor *) colorWithHexString: (NSString *)color;

+ (UIColor *) colorWithHexString: (NSString *)color alpha:(float)alpha;

+ (UIWindow *)currentVisibleWindow;

+ (UIViewController *)currentVisibleController ;


@end



