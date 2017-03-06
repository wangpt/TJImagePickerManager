//
//  TJAudioPlayerView.h
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/2/28.
//  Copyright © 2017年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TJAudioPlayerManager.h"
@interface TJAudioPlayerView : UIView<UIGestureRecognizerDelegate>
+ (void)setX:(CGFloat)x view:(UIView *)view;
+ (CGFloat)getX:(UIView *)view;
+ (void)setY:(CGFloat)y view:(UIView *)view;
+ (CGFloat)getY:(UIView *)view;
+ (void)setWidth:(CGFloat)width view:(UIView *)view;
+ (CGFloat)getWidth:(UIView *)view;
+ (void)setHeight:(CGFloat)height view:(UIView *)view;
+ (CGFloat)getHeight:(UIView *)view;
@property (retain, nonatomic) UIButton * recordButton;
@property (nonatomic, strong) AVAudioPlayer *player;


@end
