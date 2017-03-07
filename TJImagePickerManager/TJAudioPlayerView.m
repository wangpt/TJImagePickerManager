//
//  TJAudioPlayerView.m
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/2/28.
//  Copyright © 2017年 tao. All rights reserved.
//

#import "TJAudioPlayerView.h"
#define BLACK_HEIGHT 230
#define BLACK_WIDTH 210

@interface TJAudioPlayerView ()

@property (retain, nonatomic) UIButton * recordButton;
@property (retain, nonatomic) UIButton * finishButton;
@property (retain, nonatomic) UIButton * playButton;


@end
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
- (CGFloat)width{
    return self.frame.size.width;
}
#pragma mark - init

- (UIButton *)recordButton{
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _recordButton.frame = CGRectMake(0, 0, 85, 44);
        _recordButton.center = CGPointMake(BLACK_WIDTH/2, BLACK_HEIGHT-50);
        [_recordButton setTitle:@"长按录音" forState:UIControlStateNormal];
        UILongPressGestureRecognizer *longPrees = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(recordBtnLongPressed:)];
        longPrees.delegate = self;
        [_recordButton addGestureRecognizer:longPrees];
    }
    return _recordButton;
}
- (UIButton *)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _playButton.frame = CGRectMake(20, 0, 40, 44);
        _playButton.center = CGPointMake(_playButton.center.x,BLACK_HEIGHT-44);
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playPause) forControlEvents:UIControlEventTouchUpInside];
//        _playButton.hidden = YES;
        
    }
    return _playButton;
    
}
- (UIButton *)finishButton{
    if (!_finishButton) {
        _finishButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _finishButton.frame = CGRectMake(BLACK_WIDTH-40-20, 0, 40, 44);
        _finishButton.center = CGPointMake(_finishButton.center.x,BLACK_HEIGHT-44);
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];

//        _finishButton.hidden = YES;

    }
    return _finishButton;
}

- (TJVoiceRecordManager *)voiceRecord{
    if (!_voiceRecord) {
        _voiceRecord = [[TJVoiceRecordManager alloc]init];
        
    }
    return _voiceRecord;
}


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
    UIView *blackView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, BLACK_WIDTH, BLACK_HEIGHT)];
    blackView.layer.cornerRadius=10;
    [self addSubview:blackView];
    blackView.alpha = 0.8;
    blackView.center = self.center;
    blackView.backgroundColor =[UIColor blackColor];
    [blackView addSubview:self.recordButton];
    [blackView addSubview:self.playButton];
    [blackView addSubview:self.finishButton];

}


#pragma mark - 长按录音
- (void)recordBtnLongPressed:(UILongPressGestureRecognizer*) longPressedRecognizer{
    //长按开始
    if(longPressedRecognizer.state == UIGestureRecognizerStateBegan) {

        [self.voiceRecord startRecordingWithStartRecorderCompletion:^{

            
        }];
        
    }//长按结束
    else if(longPressedRecognizer.state == UIGestureRecognizerStateEnded || longPressedRecognizer.state == UIGestureRecognizerStateCancelled){
        typeof(self) __weak weakSelf = self;
        [self.voiceRecord stopRecordingWithStopRecorderCompletion:^{
            typeof(weakSelf) __strong strongSelf = weakSelf;
            strongSelf.recordButton.hidden = YES;
            strongSelf.finishButton.hidden = NO;

        }];
    }
}
#pragma mark - 播放录音

- (void)playPause{
//    if([player isPlaying])
//    {
//        [player pause];
//        [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
//    }
//    //If the track is not player, play the track and change the play button to "Pause"
//    else
//    {
//        [player play];
//        [self.playBtn setTitle:@"暂停" forState:UIControlStateNormal];
//    }
   
    TJAudioPlayerManager *audioPlayer= [TJAudioPlayerManager shareInstance];
    if ([audioPlayer.player isPlaying]) {
        [[TJAudioPlayerManager shareInstance]managerAudioWithFileName:self.voiceRecord.recordPath toPlay:NO];

    }else{
        [[TJAudioPlayerManager shareInstance]managerAudioWithFileName:self.voiceRecord.recordPath toPlay:YES];

    }
    

}
#pragma mark - 完成录音




@end
