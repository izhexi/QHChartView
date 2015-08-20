//
//  CycleDrawLineView.h
//  imqiuhang
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "QHHead.h"
#import "CyclePieIntroductionView.h"

@interface CycleDrawLineView : UIView

//set
@property (nonatomic,strong)NSArray *cyclePieInfos;

//private
@property (nonatomic,strong)NSArray *points;

//get
@property (nonatomic,strong,getter=allPrecents)NSArray *precents;

@property (nonatomic,strong,getter=allAngles)NSArray *angles;

- (int)getIndexWithAngele:(float)angle;

@end