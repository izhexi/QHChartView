//
//  CyclePieIntroductionView.m
//  imqiuhang
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "QHHead.h"
#import "CyclePieIntroductionView.h"

@implementation CyclePieIntroductionView
{
    UILabel *titleLable,
            *subTitleLable,
            *precentLable;
    int curIndex;
}

- (instancetype)init {
    if (self=[super init]) {
        curIndex = -1;
        self.size = CGSizeMake(70, 70);
        [self initView];
    }
    return self;
}

- (void)initView {
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(7, 12, 46, 30)];
    [titleLable setText:nil andFont:defaultFont(30) andTextColor:[UIColor whiteColor]];
    titleLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:titleLable];
    
    subTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(7, 41, 56, 13)];
    [subTitleLable setText:nil andFont:defaultFont(11) andTextColor:[UIColor whiteColor]];
    subTitleLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:subTitleLable];
    
    precentLable = [[UILabel alloc] initWithFrame:CGRectMake(54, 13, 10, 12)];
    [precentLable setText:nil andFont:defaultFont(12) andTextColor:[UIColor whiteColor]];
    [self addSubview:precentLable];
    
}

- (void)setIndex:(int)index {
    if (curIndex==index||index<0||index>=self.precents.count||index>=self.cyclePieInfos.count) {
        return;
    }
    _index = index;
    curIndex = index;
    [self resetIntroductionView];
    
}

- (void)resetIntroductionView {
    int present = [self.precents[self.index] floatValue]*100;
    titleLable.text = [NSString stringWithFormat:@"%i",present];
    
    CyclePieInfo *info = self.cyclePieInfos[self.index];
    subTitleLable.text = info.introduction;
    
    precentLable.text = @"%";
}

@end


@implementation CyclePieInfo

+ (CyclePieInfo *)cyclePieInfoMakeWithNumber:(int)number andIntroduction:(NSString *)introduction {
    CyclePieInfo *cyclePieInfo = [CyclePieInfo new];
    cyclePieInfo.number = number;
    cyclePieInfo.introduction = introduction;
    return cyclePieInfo;
}

@end


