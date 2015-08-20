//
//  CyclePieView.h
//  yimashuo
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//
#import "QHCircleDotView.h"

@implementation QHCircleDotView

- (id)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    [[UIColor whiteColor] set];
    CGContextFillPath(context);
    
    CGRect redRect = CGRectMake(self.width/2.f-self.width/4.f, self.height/2.f-self.height/4.f, self.width/2.f, self.height/2.f);
    CGContextAddEllipseInRect(context, redRect);
    [[QHUtil colorWithHexString:@"#FF4252"] set];
    CGContextFillPath(context);
}

@end