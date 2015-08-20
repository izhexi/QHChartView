//
//  CyclePieView.h
//  imqiuhang
//
//  Created by imqiuhang on 15/8/18.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "QHCycleRotationGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>


@implementation QHCycleRotationGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   if ([[event touchesForGestureRecognizer:self] count] > 1) {
      [self setState:UIGestureRecognizerStateFailed];
   }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
   if ([self state] == UIGestureRecognizerStatePossible) {
      [self setState:UIGestureRecognizerStateBegan];
   } else {
      [self setState:UIGestureRecognizerStateChanged];
   }
   UITouch *touch = [touches anyObject];

   UIView *view = [self view];
   CGPoint center = CGPointMake(CGRectGetMidX([view bounds]), CGRectGetMidY([view bounds]));
   CGPoint currentTouchPoint = [touch locationInView:view];
   CGPoint previousTouchPoint = [touch previousLocationInView:view];
   
   CGFloat angleInRadians = atan2f(currentTouchPoint.y - center.y, currentTouchPoint.x - center.x) - atan2f(previousTouchPoint.y - center.y, previousTouchPoint.x - center.x);
   
   [self setRotation:angleInRadians];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
   if ([self state] == UIGestureRecognizerStateChanged) {
      [self setState:UIGestureRecognizerStateEnded];
   } else {
      [self setState:UIGestureRecognizerStateFailed];
   }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
   [self setState:UIGestureRecognizerStateFailed];
}

@end
