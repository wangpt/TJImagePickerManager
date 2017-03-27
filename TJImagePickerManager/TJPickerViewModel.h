//
//  TJPickerViewModel.h
//  TJActionSheet
//
//  Created by 王朋涛 on 17/2/20.
//  Copyright © 2017年 tao. All rights reserved.
//  媒体管理

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TJImagePickerManager.h"
#import "MWPhotoBrowser.h"
#import "QBImagePickerController.h"
#import "TJAudioPlayerView.h"

@protocol TJPickerViewModelDelegate <NSObject>

@optional
- (void)tj_imagePickerViewModelStyle:(TJAssetReportMediaType)type didFinishPickingAssets:(NSArray *)assets;
@end

@interface TJPickerViewModel : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate,MWPhotoBrowserDelegate,QBImagePickerControllerDelegate,TJAudioPlayerViewDelegate,UIVideoEditorControllerDelegate>
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;
@property (nonatomic, assign) NSTimeInterval videoMaximumDuration ;//设置最长录制5分钟

@property (nonatomic, weak) id<TJPickerViewModelDelegate> delegate;

+ (instancetype)shareSingle;
- (void)takeAssetWithStyle:(TJAssetReportMediaType)type;//附件上传
- (void)playMediaViewWithAsset:(id)asset image:(UIImage *)image;//播放媒体
@end
