//
//  UIView+TJMotionEffect.m
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/3/30.
//  Copyright © 2017年 tao. All rights reserved.
//

#import "UIView+TJMotionEffect.h"
#import <objc/runtime.h>
static char motionEffectFlag;

@implementation UIView (TJMotionEffect)

-(void)setEffectGroup:(UIMotionEffectGroup *)effectGroup
{
    // 清除掉关联
    objc_setAssociatedObject(self, &motionEffectFlag,
                             nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 建立关联
    objc_setAssociatedObject(self, &motionEffectFlag,
                             effectGroup, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIMotionEffectGroup *)effectGroup
{
    // 返回关联
    return objc_getAssociatedObject(self, &motionEffectFlag);
}

- (void)addXAxisWithValue:(CGFloat)xValue YAxisWithValue:(CGFloat)yValue {
    if ((xValue >= 0) && (yValue >= 0)) {
        UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        xAxis.minimumRelativeValue = @(-xValue);
        xAxis.maximumRelativeValue = @(xValue);
        
        UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        yAxis.minimumRelativeValue = @(-yValue);
        yAxis.maximumRelativeValue = @(yValue);
        
        // 先移除效果再添加效果
        [self removeSelfMotionEffect];
        UIMotionEffectGroup *group=  [UIMotionEffectGroup new];
        group.motionEffects = @[xAxis, yAxis];
        self.effectGroup = group;
        // 给view添加效果
        [self addMotionEffect:self.effectGroup];
    }
}

- (void)removeSelfMotionEffect {
    for (UIMotionEffect *effect in self.motionEffects)
    {
        //已经存在效果则删除效果
        [self removeMotionEffect:effect];
    }
}


@end
