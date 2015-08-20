//
//  CyclePieView.m
//  yimashuo
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "CyclePieView.h"
#import "QHCycleRotationGestureRecognizer.h"
#import "CyclePieIntroductionView.h"

#define piePointerBackgroundImgViewSizeProportion 0.5f
#define piePointerBackgroundImgViewTriangleHeight 21.f/2.f

@implementation CyclePieView
{
    float angle;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        angle = 0.f;
        [self initView];
    }
    return self;
}

- (void)initView {
    pieColorBackgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MIN(self.width, self.height), MIN(self.width, self.height))];
    pieColorBackgroundImgView.centerX = self.width/2.f;
    pieColorBackgroundImgView.centerY = self.height/2.f;
    pieColorBackgroundImgView.image = [UIImage imageNamed:@"pieColorfulBg"];
        pieColorBackgroundImgView.userInteractionEnabled = YES;
    [self addSubview:pieColorBackgroundImgView];
    
    piePointerBackgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pieColorBackgroundImgView.width*piePointerBackgroundImgViewSizeProportion, 0)];
    CGSize  imageRealSize = [UIImage imageNamed:@"piePointerBg"].size;
    piePointerBackgroundImgView.height = piePointerBackgroundImgView.width*(imageRealSize.height/imageRealSize.width);
    piePointerBackgroundImgView.image = [UIImage imageNamed:@"piePointerBg"];
    
    float scale = piePointerBackgroundImgView.height/ imageRealSize.height;
    float moveTopHeight = scale*piePointerBackgroundImgViewTriangleHeight/2.f;
    
    piePointerBackgroundImgView.centerX = self.width/2.f;
    piePointerBackgroundImgView.centerY = self.height/2.f -moveTopHeight;
    [self addSubview:piePointerBackgroundImgView];
    
    [pieColorBackgroundImgView addGestureRecognizer:[[QHCycleRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotating:)]];
    
    cycleDrawLineView = [[CycleDrawLineView alloc] initWithFrame:pieColorBackgroundImgView.bounds];
    cycleDrawLineView.backgroundColor = [UIColor clearColor];
    [pieColorBackgroundImgView addSubview:cycleDrawLineView];

}

- (void)setCyclePieInfos:(NSArray *)cyclePieInfos {
    _cyclePieInfos = cyclePieInfos;
    
    cycleDrawLineView.cyclePieInfos = cyclePieInfos;
    if (!cyclePieIntroductionView) {
        cyclePieIntroductionView =[[CyclePieIntroductionView alloc] init];
        cyclePieIntroductionView.centerX  =self.width/2.f;
        cyclePieIntroductionView.centerY = self.height/2.f;
        [self addSubview:cyclePieIntroductionView];
    }
    
    cyclePieIntroductionView.cyclePieInfos = cycleDrawLineView.cyclePieInfos;
    cyclePieIntroductionView.precents = cycleDrawLineView.allPrecents;
    
    int index = [cycleDrawLineView getIndexWithAngele:angle];
    cyclePieIntroductionView.index = index;
}

- (void)rotating:(QHCycleRotationGestureRecognizer *)recognizer {
    UIView *view = [recognizer view];
    [view setTransform:CGAffineTransformRotate(view.transform, recognizer.rotation)];
    angle-=recognizer.rotation;

    int index = [cycleDrawLineView getIndexWithAngele:angle];
    cyclePieIntroductionView.index = index;
}


@end
