//
//  CyclePieIntroductionView.h
//  imqiuhang
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CyclePieInfo;

@interface CyclePieIntroductionView : UIView

@property (nonatomic)int index;

@property (nonatomic,strong)NSArray *cyclePieInfos;
@property (nonatomic,strong)NSArray *precents;

@end

@interface CyclePieInfo : NSObject

@property (nonatomic)int number;
@property (nonatomic,strong)NSString *introduction;

+ (CyclePieInfo *)cyclePieInfoMakeWithNumber:(int)number andIntroduction:(NSString *)introduction;

@end