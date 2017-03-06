//
//  TJVoiceRecordManager.h
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/3/2.
//  Copyright © 2017年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
typedef void(^TJPauseRecorderCompletion)();
typedef void(^TJStopRecorderCompletion)();
typedef void(^TJRecordProgress)(float progress);
typedef void(^TJPeakPowerForChannel)(float peakPowerForChannel);
typedef void(^TJCancellRecorderDeleteFileCompletion)();
typedef BOOL(^TJPrepareRecorderCompletion)();
typedef void(^TJResumeRecorderCompletion)();
typedef void(^TJStartRecorderCompletion)();


@interface TJVoiceRecordManager : NSObject <AVAudioRecorderDelegate>
{
    NSTimer *_timer;
    BOOL _isPause;

}
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, copy) NSString *recordPath;
@property (nonatomic, copy) NSString *recordDuration;
@property (nonatomic, assign) float maxRecordTime; // 默认 60秒为最大
@property (nonatomic, readonly) NSTimeInterval currentTimeInterval;//当前显示时间

@property (nonatomic, copy) TJRecordProgress recordProgress;//播放进度
@property (nonatomic, copy) TJPeakPowerForChannel peakPowerForChannel;//扬声器进度
@property (nonatomic, copy) TJStopRecorderCompletion maxTimeStopRecorderCompletion;


- (void)prepareRecordingWithPath:(NSString *)path prepareRecorderCompletion:(TJPrepareRecorderCompletion)prepareRecorderCompletion;

- (void)startRecordingWithStartRecorderCompletion:(TJStartRecorderCompletion)startRecorderCompletion;

@end
