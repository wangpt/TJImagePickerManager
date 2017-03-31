//
//  UIView+MotionEffect.h
//  Zhilv
//
//  Created by 王朋涛 on 17/3/31.
//  Copyright © 2017年 wangpt. All rights reserved.
//  添加动态效果

#import <UIKit/UIKit.h>

@interface UIView (MotionEffect)

- (void)addMotionEffectXAxisValue:(CGFloat)xValue motionEffectYAxisValue:(CGFloat)yValue;
- (void)removeSubViewMotionEffect;

@end
