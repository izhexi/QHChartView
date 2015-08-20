//
//  CycleDrawLineView.m
//  imqiuhang
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "CycleDrawLineView.h"

@implementation CycleDrawLineView


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    

    
    for(int idx = 0; idx < self.points.count; idx++) {
        CGContextMoveToPoint(context, self.width/2.f, self.height/2.f);
        CGPoint point = [self.points[idx] CGPointValue];
        CGContextAddLineToPoint(context, point.x, point.y);
  
    }
    
    CGContextStrokePath(context);
}

- (void)setCyclePieInfos:(NSArray *)cyclePieInfos {
    
    if (!cyclePieInfos||cyclePieInfos.count<=0) {
        return;
    }
    _cyclePieInfos = cyclePieInfos;
    
    int totalCount = 0;
    
    
    for(CyclePieInfo *info in cyclePieInfos) {
        totalCount +=info.number;
    }
    
    NSMutableArray *percents = [[NSMutableArray alloc] initWithCapacity:10];
    
    for(CyclePieInfo *info in cyclePieInfos) {
        float precent = info.number*1.00f/totalCount;
        [percents addObject:@(precent)];
    }
    
    self.precents = [percents copy];
    
    
    NSMutableArray *curPoints = [[NSMutableArray alloc] initWithCapacity:10];
    
    float curPrecent = 0.0f;
    
    NSMutableArray *angels = [[NSMutableArray alloc] initWithCapacity:10];
    for(NSNumber *num in percents) {
        curPrecent +=[num floatValue];
        
        
        float angle = 2*M_PI*curPrecent;
        [angels addObject:@(angle)];
        
        float x = (1+sin(angle-M_PI/2))/2.f*self.height;
        float y = (1+sin(angle+M_PI))/2.f*self.height;
        
        [curPoints addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        
    }
    
    [self setAngles:[angels copy]];
    
    [self setPoints:[curPoints copy]];
    
    
    [self setNeedsDisplay];
}


- (int)getIndexWithAngele:(float)angle {
    
    float realAngle = [self realAngle:(angle+M_PI_2)] ;
    
    for (int i=0;i<self.allAngles.count;i++) {
        float indexAngel = [self.allAngles[i] floatValue];
        
        if (realAngle<indexAngel) {
            return i;
        }
    }
    
    return 0;
}

- (float)realAngle:(float)angle {
    while (angle>2*M_PI) {
        angle-=2*M_PI;
    }
    
    while (angle<0) {
        angle+=2*M_PI;
    }
    
    
    return angle;
}


@end
