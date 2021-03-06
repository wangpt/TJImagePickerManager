//
//  TJAudioPlayerManager.h
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/3/2.
//  Copyright © 2017年 tao. All rights reserved.
//  声音播放

#import <Foundation/Foundation.h>
#import "TJAudioPlayerManager.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol TJAudioPlayerManagerDelegate <NSObject>

@optional
- (void)didAudioPlayerBeginPlay:(AVAudioPlayer*)audioPlayer;
- (void)didAudioPlayerStopPlay:(AVAudioPlayer*)audioPlayer;
- (void)didAudioPlayerPausePlay:(AVAudioPlayer*)audioPlayer;

@end

@interface TJAudioPlayerManager : NSObject<AVAudioPlayerDelegate>
+ (id)shareInstance;

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, copy) NSString *playingFileName;
@property (nonatomic, assign) id <TJAudioPlayerManagerDelegate> delegate;
- (BOOL)isPlaying;//播放状态
- (void)playAudioWithFileName:(NSString*)fileName;//播放
- (void)pausePlayingAudio;//暂停
- (void)stopAudio;//停止
@end
