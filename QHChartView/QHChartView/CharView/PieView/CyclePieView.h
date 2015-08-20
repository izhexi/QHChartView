//
//  CyclePieView.h
//  yimashuo
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "QHHead.h"
#import "CycleDrawLineView.h"

@interface CyclePieView : UIView
{
 @protected
    UIImageView *pieColorBackgroundImgView, *piePointerBackgroundImgView;
    CycleDrawLineView *cycleDrawLineView;
    CyclePieIntroductionView *cyclePieIntroductionView ;
}

@property (nonatomic,strong)NSArray *cyclePieInfos;;

@end
