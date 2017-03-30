//
//  UIView+TJMotionEffect.h
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/3/30.
//  Copyright © 2017年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TJMotionEffect)
@property (nonatomic, strong) UIMotionEffectGroup  *effectGroup;

- (void)addXAxisWithValue:(CGFloat)xValue YAxisWithValue:(CGFloat)yValue;
@end
