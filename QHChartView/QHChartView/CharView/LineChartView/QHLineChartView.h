//
//  CyclePieView.h
//  yimashuo
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//
#import "QHHead.h"

#import "QHCircleDotView.h"
#import "QHLineView.h"
#import "CyclePieIntroductionView.h"

@protocol QHLineChartViewDelegate <NSObject>

@optional

- (void)didTouchAreaWithIndex:(int)index;

- (void)didReleaseAreaWithIndex:(int)index;


@end

@interface QHLineChartView : UIView
{
    @protected
    UIView *touchFlowLineView;
    QHCircleDotView *touchedDot;
    int curChoosedTag;
    UILabel *touchNumLable;
}

@property (nonatomic,weak)id <QHLineChartViewDelegate> delegate;

@property (strong, nonatomic) UIColor *underLineSpaceColor;
@property (strong, nonatomic) UIColor *topLineSpaceColor;

//set
@property (nonatomic,strong)NSArray *chartInfos;


@end
