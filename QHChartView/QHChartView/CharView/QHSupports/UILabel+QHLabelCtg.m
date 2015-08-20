//
//  UILabel+QHLabelCtg.m
//  yimashuo
//
//  Created by imqiuhang on 15/8/17.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#import "UILabel+QHLabelCtg.h"

@implementation UILabel (QHLabelCtg)

- (void)setText:(NSString *)aText andFont:(UIFont *)aFont andTextColor:(UIColor *)aColor {
    self.text      = aText;
    self.font      = aFont;
    self.textColor = aColor;
}

@end
