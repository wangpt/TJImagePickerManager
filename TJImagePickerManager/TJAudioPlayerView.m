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
#define RGB(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A/1.0]

@interface TJAudioPlayerView ()

@property (retain, nonatomic) UIButton * recordButton;
@property (retain, nonatomic) UIButton * finishButton;
@property (retain, nonatomic) UIButton * playButton;
@property (retain, nonatomic) UIView * blackView;
@property (retain, nonatomic) UIImageView *animateImageView;
@property (retain, nonatomic) UIImageView *animateBackImageView;




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
- (UIView *)blackView{
    if (!_blackView) {
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BLACK_WIDTH, BLACK_HEIGHT)];
        _blackView.center = self.center;
        _blackView.layer.cornerRadius = 10;
        _blackView.backgroundColor = RGB(0, 0, 0, 0.8);
        [_blackView addSubview:self.animateBackImageView];
        [_blackView addSubview:self.animateImageView];
        [_blackView addSubview:self.recordButton];
        [_blackView addSubview:self.playButton];
        [_blackView addSubview:self.finishButton];

    }
    return _blackView;
}


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
        [_playButton addTarget:self action:@selector(playOrPausePlayer) forControlEvents:UIControlEventTouchUpInside];
        _playButton.hidden = YES;
        
    }
    return _playButton;
    
}
- (UIButton *)finishButton{
    if (!_finishButton) {
        _finishButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _finishButton.frame = CGRectMake(BLACK_WIDTH-40-20, 0, 40, 44);
        _finishButton.center = CGPointMake(_finishButton.center.x,BLACK_HEIGHT-44);
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [_finishButton addTarget:self action:@selector(finishPlayer) forControlEvents:UIControlEventTouchUpInside];
        _finishButton.hidden = YES;

    }
    return _finishButton;
}
- (UIImageView *)animateBackImageView{
    if (!_animateBackImageView) {
        _animateBackImageView = [[UIImageView alloc]init];
        CGFloat x = self.blackView.frame.size.width/2 - 76/2;
        _animateBackImageView.frame = CGRectMake(x, 40, 76, 110);
        _animateBackImageView.image = [UIImage imageNamed:@"record_animate_back"];

    }
    return _animateBackImageView;

}
- (UIImageView *)animateImageView{
    if (!_animateImageView) {
        _animateImageView = [[UIImageView alloc]init];
        CGFloat x = self.blackView.frame.size.width/2 - 76/2;
        _animateImageView.frame = CGRectMake(x, 40, 76, 110);
        _animateImageView.image = [UIImage imageNamed:@"record_animate_play"];
        _animateImageView.contentMode = UIViewContentModeBottom;
        _animateImageView.clipsToBounds = YES;
    }
    return _animateImageView;

}

- (TJVoiceRecordManager *)voiceRecord{
    if (!_voiceRecord) {
        _voiceRecord = [[TJVoiceRecordManager alloc]init];
        typeof(self) __weak weakSelf = self;
        _voiceRecord.peakPowerForChannel = ^(float peakPowerForChannel) {
            typeof(weakSelf) __strong strongSelf = weakSelf;
            CGFloat height =  strongSelf.animateBackImageView.frame.size.height;
            double dis = 1 - peakPowerForChannel;
            [TJAudioPlayerView setY:40+dis*height view:strongSelf.animateImageView];
            [TJAudioPlayerView setHeight:height*peakPowerForChannel view:strongSelf.animateImageView];

        };
        
    }
    return _voiceRecord;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *backView =[[UIView alloc]initWithFrame:self.frame];
        [self addSubview:backView];
        UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc]init];
        [backView addGestureRecognizer:tapGestureRecognizer];
        [tapGestureRecognizer addTarget:self action:@selector(cancelledFormSubView)];
        [self addSubview:self.blackView];
    }
    return self;
}


- (void)cancelledFormSubView{
    [self.voiceRecord cancelledDeleteWithCompletion:^{
        [self removeFromSuperview];
    }];
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
            strongSelf.playButton.hidden = NO;


        }];
    }
}
#pragma mark - 播放或暂停录音

- (void)playOrPausePlayer{
    TJAudioPlayerManager *audioPlayer= [TJAudioPlayerManager shareInstance];
    audioPlayer.delegate = self;
    if (![audioPlayer isPlaying]) {
        [[TJAudioPlayerManager shareInstance]playAudioWithFileName:self.voiceRecord.recordPath];
        [self.playButton setTitle:@"暂停" forState:UIControlStateNormal];

    }else{
        [[TJAudioPlayerManager shareInstance]pausePlayingAudio];
        [self.playButton setTitle:@"播放" forState:UIControlStateNormal];

    }

}
#pragma mark - 完成录音

- (void)finishPlayer{
    [[TJAudioPlayerManager shareInstance] stopAudio];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(audioPlayerDidFinishPlaying: path:)]) {
        [self.delegate audioPlayerDidFinishPlaying:self path:self.voiceRecord.recordPath];
    }
    [self removeFromSuperview];

}


- (void)didAudioPlayerStopPlay:(AVAudioPlayer*)audioPlayer{
    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
}



@end
