//
//  VoiceRecView.m
//  BaoLiaoProject
//
//  Created by Devil on 13-11-14.
//  Copyright (c) 2013年 com.shinyv. All rights reserved.
//

#import "VoiceRecView.h"

@implementation VoiceRecView

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#pragma mark - 类目方法（私有）

- (id)initWithVoiceRecView
{
    self =[[[NSBundle mainBundle] loadNibNamed:@"VoiceRecView" owner:self options:nil] lastObject];
    if (self) {
        originX=self.topImageView.frame.origin.x;
        originY=self.topImageView.frame.origin.y;
        self.layer.cornerRadius=10;
        self.topImageView.contentMode = UIViewContentModeBottom;
        self.topImageView.clipsToBounds = YES;
        self.playBtn.hidden=YES;
        self.finishBtn.hidden=YES;
        self.blackView.layer.cornerRadius = 10;
         self.blackView.layer.masksToBounds = YES;
        
        UILongPressGestureRecognizer *longPrees = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(recordBtnLongPressed:)];
        longPrees.delegate = self;
        [self.recBtn addGestureRecognizer:longPrees];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if(session == nil){
            NSLog(@"Error creating session: %@", [sessionError description]);
        }
        else{
            [session setActive:YES error:nil];

        }
     }
    return self;
}

#pragma mark - 长按录音
- (void)recordBtnLongPressed:(UILongPressGestureRecognizer*) longPressedRecognizer{
    //长按开始
    if(longPressedRecognizer.state == UIGestureRecognizerStateBegan) {
        [self startRec];
        
    }//长按结束
    else if(longPressedRecognizer.state == UIGestureRecognizerStateEnded || longPressedRecognizer.state == UIGestureRecognizerStateCancelled){
        
 
        self.recBtn.hidden=YES;
        self.finishBtn.hidden=NO;
        self.playBtn.hidden=NO;
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
        


    }
}

#pragma mark - RecorderPath Helper Method

- (NSString *)getRecorderPath {
    NSString *recorderPath = nil;
    recorderPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    recorderPath = [recorderPath stringByAppendingFormat:@"%@-MySound.m4a", [dateFormatter stringFromDate:now]];
    return recorderPath;
}

-(void)startRec{
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSURL *url1 = [NSURL fileURLWithPath:[self getRecorderPath]];
    self.recordedFile =url1;
    if (!recorder) {

        recorder = [[AVAudioRecorder alloc] initWithURL:self.recordedFile settings:recordSetting error:nil];
        recorder.meteringEnabled = YES;
        [recorder prepareToRecord];
        [recorder record];
    }
   
    if (player) {
        player =nil;
    }
     
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];



}
- (void)detectionVoice
{
    if (recorder) {
         [recorder updateMeters];//刷新音量数据
        double lowPassResults = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
        NSLog(@"%lf",lowPassResults);
        double dis =1-lowPassResults;
        self.topImageView.frame= CGRectMake(originX, originY+dis*self.bgImageView.bounds.size.height, self.topImageView.frame.size.width  , self.bgImageView.bounds.size.height*lowPassResults);
    }
}

-(IBAction)finishted:(id)sender{
    [self removeFromSuperview];
    if (self.delegate) {
        [self.delegate voiceFinishedWith:self.recordedFile.relativePath];
    }

}
- (IBAction)playPause:(id)sender
{
    //If the track is playing, pause and achange playButton text to "Play"
    if([player isPlaying])
    {
        [player pause];
        [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }
    //If the track is not player, play the track and change the play button to "Pause"
    else
    {
        [player play];
        [self.playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
}



- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
}

@end
