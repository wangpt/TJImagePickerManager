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
#import "TJVoiceRecordManager.h"
@class TJAudioPlayerView;
@protocol TJAudioPlayerViewDelegate <NSObject>
-(void)audioPlayerDidFinishPlaying:(TJAudioPlayerView *)playerView path:(NSString*)path;

@end


@interface TJAudioPlayerView : UIView<UIGestureRecognizerDelegate,TJAudioPlayerManagerDelegate>
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) TJVoiceRecordManager *voiceRecord;
@property (nonatomic, weak) id <TJAudioPlayerViewDelegate> delegate;

@end
