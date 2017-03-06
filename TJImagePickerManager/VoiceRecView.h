//
//  VoiceRecView.h
//  BaoLiaoProject
//
//  Created by Devil on 13-11-14.
//  Copyright (c) 2013年 com.shinyv. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@protocol VoiceDelegate <NSObject>
-(void)voiceFinishedWith:(NSString*)voiceurl;

@end


@interface VoiceRecView : UIView<AVAudioPlayerDelegate,UIGestureRecognizerDelegate>{
    
    NSTimer * _timer;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
    BOOL isRecording;
    float originX;
    float originY;
    
 }
- (id)initWithVoiceRecView;
@property(nonatomic,retain)NSURL *recordedFile;
@property (retain, nonatomic) IBOutlet UIView *blackView;
@property (retain, nonatomic) IBOutlet UIImageView *topImageView;
- (IBAction)playPause:(id)sender;
-(IBAction)finishted:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *bgImageView;
@property (retain, nonatomic) IBOutlet UIButton *playBtn;
@property (retain, nonatomic) IBOutlet UIButton *recBtn;
@property (retain, nonatomic) IBOutlet UIButton *finishBtn;
@property(nonatomic,assign)id<VoiceDelegate> delegate;
@end
