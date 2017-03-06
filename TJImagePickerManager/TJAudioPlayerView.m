//
//  TJAudioPlayerView.m
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/2/28.
//  Copyright © 2017年 tao. All rights reserved.
//

#import "TJAudioPlayerView.h"
#define BLACK_HEIGHT 230


@implementation TJAudioPlayerView
#pragma mark - viewframe
+ (void)setX:(CGFloat)x view:(UIView *)view
{
    CGRect frame = view.frame;
    frame.origin.x = x;
    view.frame = frame;
}

+ (CGFloat)getX:(UIView *)view
{
    return view.frame.origin.x;
}
+ (void)setY:(CGFloat)y view:(UIView *)view
{
    CGRect frame = view.frame;
    frame.origin.y = y;
    view.frame = frame;
}

+ (CGFloat)getY:(UIView *)view
{
    return view.frame.origin.y;
}

+ (void)setWidth:(CGFloat)width view:(UIView *)view
{
    CGRect frame = view.frame;
    frame.size.width = width;
    view.frame = frame;
}

+ (CGFloat)getWidth:(UIView *)view
{
    return view.frame.size.width;
    
}
+ (void)setHeight:(CGFloat)height view:(UIView *)view

{
    CGRect frame = view.frame;
    frame.size.height = height;
    view.frame = frame;
}
+ (CGFloat)getHeight:(UIView *)view
{
    return view.frame.size.height;
}

#pragma mark - init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup{
    //背景色
    UIView *blackView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, BLACK_HEIGHT, BLACK_HEIGHT)];
    blackView.layer.cornerRadius=10;
    [self addSubview:blackView];
    blackView.center = self.center;
    blackView.backgroundColor =[UIColor blackColor];
    [blackView addSubview:self.recordButton];
    
}
- (UIButton *)recordButton{
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        UILongPressGestureRecognizer *longPrees = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(recordBtnLongPressed:)];
        longPrees.delegate = self;
        [_recordButton addGestureRecognizer:longPrees];
    }
    return _recordButton;
}

#pragma mark - 长按录音
- (void)recordBtnLongPressed:(UILongPressGestureRecognizer*) longPressedRecognizer{
    //长按开始
    if(longPressedRecognizer.state == UIGestureRecognizerStateBegan) {
       // [self startRec];
        
        
    }//长按结束
    else if(longPressedRecognizer.state == UIGestureRecognizerStateEnded || longPressedRecognizer.state == UIGestureRecognizerStateCancelled){
        /*
        
        self.recBtn.hidden=YES;
        self.finishBtn.hidden=NO;
        self.playBtn.hidden=NO;
        if (recorder) {
            [recorder stop];
            recorder = nil;
        }
        
        self.recBtn.hidden=YES;
        self.finishBtn.hidden=NO;
        self.playBtn.hidden=NO;
        if (recorder) {
            [recorder stop];
            recorder = nil;
        }
        
        NSError *playerError;
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordedFile error:&playerError];
        
        if (player == nil)
        {
            NSLog(@"ERror creating player: %@", [playerError description]);
        }
        player.delegate = self;
        */
        
        
    }
}



@end
