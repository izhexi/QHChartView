//
//  CyclePieView.h
//  yimashuo
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#define animationLineSpeed 10.f
#define minBottomGap 80.f

#import "QHLineChartView.h"

@implementation QHLineChartView


- (void)setChartInfos:(NSArray *)chartInfos {
    _chartInfos = chartInfos;
    [self reloadView];
}

- (void)initBaseData {

    self.underLineSpaceColor = [UIColor blackColor];
    self.topLineSpaceColor = [UIColor blackColor];
    curChoosedTag = -1;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];
        [self initBaseData];
    }
    return self;
}

- (void)reloadView {
    if (!self.chartInfos||self.chartInfos.count<=0) {
        return;
    }
    [self reloadLinesAndDots];
    [self reloadIntroductionLables];
    
    UIView *panGestureRecognizerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.width, self.height)];
    panGestureRecognizerView.backgroundColor = [UIColor clearColor];
    [self addSubview:panGestureRecognizerView];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGestureRecognizerView addGestureRecognizer:panGestureRecognizer];
  
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    if (!touchFlowLineView) {
        touchFlowLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.height)];
        touchFlowLineView.backgroundColor = [UIColor whiteColor];
        touchFlowLineView.alpha = 0;
        [self addSubview:touchFlowLineView];
    }
    
    if (!touchNumLable) {
        touchNumLable = [[UILabel alloc] init];
        [touchNumLable setText:nil andFont:defaultFont(24) andTextColor:[UIColor whiteColor]];
        touchNumLable.textAlignment  =NSTextAlignmentCenter;
        
        [self addSubview:touchNumLable];
    }
    touchNumLable.alpha  = 1.f;
    
    CGPoint translation = [recognizer locationInView:self];
    
    touchFlowLineView.left = translation.x;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        touchFlowLineView.alpha = 0.6;
    } completion:nil];
    
    touchedDot = [self closestDotFromVerticalLine:touchFlowLineView];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        touchNumLable.centerX = touchedDot.left - 50;
        touchNumLable.bottom = touchedDot.top +50;
    }
    
    CyclePieInfo *info = self.chartInfos [touchedDot.tag];
    touchNumLable.text = [NSString stringWithFormat:@"%i",info.number];
    [touchNumLable sizeToFit];
    if ((int)touchedDot.tag!=curChoosedTag) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            touchNumLable.top = touchedDot.top -30;
            if (touchedDot.tag==0) {
                touchNumLable.left =touchedDot.left+10;
            }else if (touchedDot.tag==self.chartInfos.count-1) {
                touchNumLable.right =touchedDot.left-10;
            }else {
                touchNumLable.centerX =touchedDot.centerX;
            }
        } completion:nil];
    }
    
    touchedDot.alpha = 1.f;
    if ((int)touchedDot.tag!=curChoosedTag) {
        if ([self.delegate respondsToSelector:@selector(didTouchAreaWithIndex:)]) {
            [self.delegate didTouchAreaWithIndex:((int)touchedDot.tag)];
        }
        curChoosedTag = (int)touchedDot.tag;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([self.delegate respondsToSelector:@selector(didReleaseAreaWithIndex:)]) [self.delegate didReleaseAreaWithIndex:(int)(touchedDot.tag )];
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            touchedDot.alpha = 0;
            touchFlowLineView.alpha = 0;
            touchNumLable.alpha = 0;
        } completion:nil];
    }
}


- (void)reloadLinesAndDots {
    
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[QHCircleDotView class]]||[subview isKindOfClass:[QHLineView class]])
            [subview removeFromSuperview];
    }
    
    NSMutableArray *positions = [[NSMutableArray alloc] initWithCapacity:self.chartInfos.count];
    
    for (int i = 0; i < self.chartInfos.count; i++) {
        
        CyclePieInfo *info = self.chartInfos[i];
        float dotValue = info.number;
        
        float positionX = (self.width/(self.chartInfos.count - 1))*i;
        float positionY = (self.height - minBottomGap) - ((dotValue - [self getMinNumber]) / (([self getMaxNumber] - [self getMinNumber]) / (self.height - minBottomGap))) + 40;
        
        [positions addObject:[NSValue valueWithCGPoint:CGPointMake(positionX, positionY)]];
        
        QHCircleDotView *circleDot = [[QHCircleDotView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        circleDot.center = CGPointMake(positionX, positionY);
        circleDot.tag = i;
        circleDot.alpha = 0;
        [self addSubview:circleDot];
        
        [UIView animateWithDuration:0.5 delay:i/(animationLineSpeed) options:UIViewAnimationOptionCurveEaseOut animations:^{
            circleDot.alpha = 1.f;
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                circleDot.alpha = 0;
            } completion:nil];
        }];
        
        
    }
    
    for (int i = 0; i < positions.count-1; i++) {
        CGPoint positionLeft = [positions[i] CGPointValue];
        CGPoint positionRight = [positions[i+1] CGPointValue];
        QHLineView *lineView = [[QHLineView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        lineView.startPoint = CGPointMake(positionLeft.x, positionLeft.y);
        lineView.endPoint = CGPointMake(positionRight.x, positionRight.y);
        lineView.topSpaceColor = self.topLineSpaceColor;
        lineView.bottomSpaceColor = self.underLineSpaceColor;
        lineView.lineColor = [UIColor whiteColor];
        lineView.lineWidth = 3.0;
        [self addSubview:lineView];
        [self sendSubviewToBack:lineView];
        
        lineView.alpha = 0;
        [UIView animateWithDuration:1.5 delay:i/(animationLineSpeed) options:UIViewAnimationOptionCurveEaseOut animations:^{
            lineView.alpha = 1.0;
        } completion:nil];

    }
}


- (float)getMaxNumber {
    float curNum;
    float maxNum = 0;
    
    for (int i = 0; i < self.chartInfos.count; i++) {
        CyclePieInfo *info =self.chartInfos[i];
        curNum  = info.number;
        
        if (curNum > maxNum) {
            maxNum = curNum;
        }
    }
    
    return maxNum;
}

- (float)getMinNumber {
    
    float curNum;
    float minNum = INT_MAX;
    
    for (int i = 0; i < self.chartInfos.count; i++) {
        CyclePieInfo *info =self.chartInfos[i];
        curNum = info.number;
        
        if (curNum < minNum) {
            minNum = curNum;
        }
    }
    
    return minNum;
}


- (QHCircleDotView *)closestDotFromVerticalLine:(UIView *)aVerticalLine {
    
    int currentTouchTag  = INT_MAX;
    
    for (QHCircleDotView *curDotView in self.subviews) {
        if ([curDotView isKindOfClass:[QHCircleDotView class]]) {
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                curDotView.alpha = 0;
            } completion:nil];
            
            if (pow(((curDotView.center.x) - aVerticalLine.left), 2) < currentTouchTag) {
                currentTouchTag = pow(((curDotView.center.x) - aVerticalLine.left), 2);
                touchedDot = curDotView;
            }
        }
    }
    
    return touchedDot;
}

- (void)reloadIntroductionLables {
    
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[UILabel class]])
            [subview removeFromSuperview];
    }
    
    for (int i = 0; i < self.chartInfos.count; i++) {
        UILabel *introductionLable = [[UILabel alloc] init];
        CyclePieInfo *info =self.chartInfos[i];
        [introductionLable setText:info.introduction andFont:defaultFont(12) andTextColor:[UIColor whiteColor]];
        introductionLable.width = self.width/self.chartInfos.count;
        introductionLable.height = 30.f;
        introductionLable.left = i*self.width/(self.chartInfos.count);
        introductionLable.textAlignment = NSTextAlignmentCenter;
        introductionLable.centerY = self.height - 10;
        introductionLable.textAlignment = 1;
        [self addSubview:introductionLable];
    }
    
}

- (void)drawRect:(CGRect)rect {
    
    [self drawGradientColor:UIGraphicsGetCurrentContext() rect:rect options:kCGGradientDrawsBeforeStartLocation colors:@[[QHUtil colorWithHexString:@"#FF2E64"],[QHUtil colorWithHexString:@"#FF5145"]]];
}

//绘制渐变色的资料==找了好久http://blog.csdn.net/majiakun1/article/details/17848285

- (void)drawGradientColor:(CGContextRef)p_context
                     rect:(CGRect)p_clipRect
                  options:(CGGradientDrawingOptions)p_options
                   colors:(NSArray *)p_colors {
    
    CGContextSaveGState(p_context);// 保持住现在的context
    CGContextClipToRect(p_context, p_clipRect);// 截取对应的context
    int colorCount = (int)p_colors.count;
    int numOfComponents = 4;
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colorComponents[colorCount * numOfComponents];
    for (int i = 0; i < colorCount; i++) {
        UIColor *color = p_colors[i];
        CGColorRef temcolorRef = color.CGColor;
        const CGFloat *components = CGColorGetComponents(temcolorRef);
        for (int j = 0; j < numOfComponents; ++j) {
            colorComponents[i * numOfComponents + j] = components[j];
        }
    }
    CGGradientRef gradient =  CGGradientCreateWithColorComponents(rgb, colorComponents, NULL, colorCount);
    CGColorSpaceRelease(rgb);
    CGPoint startPoint = p_clipRect.origin;
    CGPoint endPoint = CGPointMake(CGRectGetMinX(p_clipRect), CGRectGetMaxY(p_clipRect));
    CGContextDrawLinearGradient(p_context, gradient, startPoint, endPoint, p_options);
    CGGradientRelease(gradient);
    CGContextRestoreGState(p_context);// 恢复到之前的context
}

@end