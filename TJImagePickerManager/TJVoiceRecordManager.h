//
//  TJVoiceRecordManager.h
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/3/2.
//  Copyright © 2017年 tao. All rights reserved.
//  录音

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
typedef void(^TJPauseRecorderCompletion)();
typedef void(^TJStopRecorderCompletion)();
typedef void(^TJRecordProgress)(float progress);
typedef void(^TJPeakPowerForChannel)(float peakPowerForChannel);
typedef void(^TJCancellRecorderDeleteFileCompletion)();
typedef void(^TJPrepareRecorderCompletion)();
typedef void(^TJResumeRecorderCompletion)();
typedef void(^TJStartRecorderCompletion)();


@interface TJVoiceRecordManager : NSObject <AVAudioRecorderDelegate>
{
    BOOL _isPause;

}
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong)     NSTimer * timer;


@property (nonatomic, copy) NSString *recordPath;
@property (nonatomic, copy) NSString *recordDuration;
@property (nonatomic, assign) float maxRecordTime; // 默认 60秒为最大
@property (nonatomic, readonly) NSTimeInterval currentTimeInterval;//当前显示时间

@property (nonatomic, copy) TJRecordProgress recordProgress;//播放进度
@property (nonatomic, copy) TJPeakPowerForChannel peakPowerForChannel;//扬声器进度
@property (nonatomic, copy) TJStopRecorderCompletion maxTimeStopRecorderCompletion;


- (void)startRecordingWithStartRecorderCompletion:(TJStartRecorderCompletion)startRecorderCompletion;
- (void)stopRecordingWithStopRecorderCompletion:(TJStopRecorderCompletion)stopRecorderCompletion;

@end
