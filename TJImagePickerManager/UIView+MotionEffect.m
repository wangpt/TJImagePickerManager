//
//  UIView+MotionEffect.m
//  Zhilv
//
//  Created by 王朋涛 on 17/3/31.
//  Copyright © 2017年 wangpt. All rights reserved.
//  添加动画效果

#import "UIView+MotionEffect.h"

@implementation UIView (MotionEffect)
- (void)addMotionEffectXAxisValue:(CGFloat)xValue motionEffectYAxisValue:(CGFloat)yValue{
    if ((xValue >= 0) && (yValue >= 0)) {
        UIInterpolatingMotionEffect *interpolatingHorizontal = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        interpolatingHorizontal.minimumRelativeValue = @(-xValue);
        interpolatingHorizontal.maximumRelativeValue = @(xValue);
        UIInterpolatingMotionEffect *interpolatingVertical = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        interpolatingVertical.minimumRelativeValue = @(-yValue);
        interpolatingVertical.maximumRelativeValue =@(yValue);
        UIMotionEffectGroup *group=  [UIMotionEffectGroup new];
        group.motionEffects = @[interpolatingHorizontal, interpolatingVertical];
        [self removeSubViewMotionEffect];
        [self addMotionEffect:group];
        
    }
}

- (void)removeSubViewMotionEffect{
    for (UIMotionEffect *effect in self.motionEffects)
    {
        //已经存在效果则删除效果
        [self removeMotionEffect:effect];
    }
}

@end
