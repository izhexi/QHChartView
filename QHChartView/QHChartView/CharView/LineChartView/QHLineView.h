//
//  CyclePieView.h
//  yimashuo
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//
#import "QHHead.h"

@interface QHLineView : UIView

@property (nonatomic) CGPoint  startPoint;
@property (nonatomic) CGPoint  endPoint;

@property (strong, nonatomic) UIColor *topSpaceColor;
@property (strong, nonatomic) UIColor *bottomSpaceColor;
@property (strong, nonatomic) UIColor *lineColor;

@property (nonatomic) float lineWidth;

@end