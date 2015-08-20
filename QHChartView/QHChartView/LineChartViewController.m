//
//  LineChartViewController.m
//  QHChartView
//
//  Created by imqiuhang on 15/8/20.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "LineChartViewController.h"
#import "QHLineChartView.h"

@interface LineChartViewController ()<QHLineChartViewDelegate>

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LineChartView";
    self.view.backgroundColor = [QHUtil colorWithHexString:@"#2C2C3A"];
    [self initView];
}

- (void)initView {
   NSArray * lineGraphViewInfos = @[
                           [CyclePieInfo cyclePieInfoMakeWithNumber:20
                                                    andIntroduction:@"20岁以下"],
                           
                           [CyclePieInfo cyclePieInfoMakeWithNumber:40
                                                    andIntroduction:@"20-25岁"],
                           
                           [CyclePieInfo cyclePieInfoMakeWithNumber:30
                                                    andIntroduction:@"25-30岁"],
                           
                           [CyclePieInfo cyclePieInfoMakeWithNumber:60
                                                    andIntroduction:@"30-40岁"],
                           
                           [CyclePieInfo cyclePieInfoMakeWithNumber:50
                                                    andIntroduction:@"40岁以上"],
                           ];
    
    
    QHLineChartView * lineChartView = [[QHLineChartView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 270)];
    lineChartView.centerX = self.view.width/2.f;
    lineChartView.top = 64;
    lineChartView.topLineSpaceColor = [QHUtil colorWithHexString:@"#2C2C3A"];
    lineChartView.underLineSpaceColor = [QHUtil colorWithHexString:@"#FF3D5B"];
    lineChartView.delegate = self;
    lineChartView.chartInfos = lineGraphViewInfos;
    [self.view addSubview:lineChartView];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    lable.top = lineChartView.bottom + 40;
    lable.centerX = self.view.width/2.f;
    lable.textAlignment = NSTextAlignmentCenter;
    [lable setText:@"左右滑动试试" andFont:defaultFont(16) andTextColor:[UIColor whiteColor]];
    [self.view addSubview:lable];
}

- (void)didTouchAreaWithIndex:(int)index {
    MSLog(@"移到了第%i段",index);
}

- (void)didReleaseAreaWithIndex:(int)index {
    MSLog(@"从第%i段释放了手势",index);
}


@end
