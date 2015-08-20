//
//  PieChartViewController.m
//  QHChartView
//
//  Created by imqiuhang on 15/8/20.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "PieChartViewController.h"
#import "CyclePieView.h"

@interface PieChartViewController ()

@end

@implementation PieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PieChartView";
    self.view.backgroundColor = [QHUtil colorWithHexString:@"#2C2C3A"];
    [self initView];
}


- (void)initView {
  NSArray *  cyclePieInfos = @[
                      [CyclePieInfo cyclePieInfoMakeWithNumber:20
                                               andIntroduction:@"混合肤质"],
                      
                      [CyclePieInfo cyclePieInfoMakeWithNumber:40
                                               andIntroduction:@"干性肤质"],
                      
                      [CyclePieInfo cyclePieInfoMakeWithNumber:30
                                               andIntroduction:@"油性肤质"],
                      
                      [CyclePieInfo cyclePieInfoMakeWithNumber:50
                                               andIntroduction:@"敏感肤质"]
                      ];
    
    CyclePieView *cyclePieView = [[CyclePieView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    cyclePieView.centerX = self.view.width/2.f;
    cyclePieView.centerY = self.view.height/2.f;;
    [self.view addSubview:cyclePieView];
    cyclePieView.cyclePieInfos = cyclePieInfos;
    
    
}


@end
