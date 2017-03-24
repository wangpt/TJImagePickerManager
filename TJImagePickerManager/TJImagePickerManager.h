//
//  TJImagePickerManager.h
//  TJActionSheet
//
//  Created by 王朋涛 on 17/2/15.
//  Copyright © 2017年 tao. All rights reserved.
//  选择视频或图片

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <Foundation/Foundation.h>

#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)

typedef enum : NSUInteger {
    TJAssetReportMediaTypePhoto = 0,//选择照片
    TJAssetReportMediaTypeCamera,//拍照
    TJAssetReportMediaTypeVideo,//选择视频
    TJAssetReportMediaTypeCameraShot,//拍摄
    TJAssetReportMediaTypeAudio//音频
} TJAssetReportMediaType;///上传方式

typedef enum : NSUInteger {
    TJAssetModelMediaTypePhoto = 0,
    TJAssetModelMediaTypePhotoGif,
    TJAssetModelMediaTypeVideo,
    TJAssetModelMediaTypeAudio
} TJAssetModelMediaType; //媒体样式

@interface TJAssetModel : NSObject
@property (nonatomic, strong) id asset;             ///< PHAsset or ALAsset
@property (nonatomic, assign) TJAssetModelMediaType type;
@property (nonatomic, copy) NSString *timeLength;
/// 用一个PHAsset/ALAsset实例，初始化一个照片模型
+ (instancetype)modelWithAsset:(id)asset type:(TJAssetModelMediaType)type;
+ (instancetype)modelWithAsset:(id)asset type:(TJAssetModelMediaType)type timeLength:(NSString *)timeLength;
@end


@interface TJAlbumModel : NSObject

@property (nonatomic, strong) NSString *name;        ///< The album name
@property (nonatomic, assign) NSInteger count;       ///< Count of photos the album contain
@property (nonatomic, strong) id result;             ///< PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset>
@end




@interface TJImagePickerManager : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面
@property (nonatomic, assign) BOOL sortAscendingByModificationDate;

///单利
+ (instancetype)shareInstance ;

///是否有摄像头
- (BOOL) isCameraAvailable;

///授权状态
- (NSInteger)authorizationStatus;

///获取相册最新的媒体
+ (PHAsset *)latestAssetFromPHAssetMediaType:(PHAssetMediaType)type;

///保存图片或视频到自定义相册
- (void)saveAssectWithAlbumName:(NSString *)albumName fileUrl:(NSURL *)fileUrl fileImage:(UIImage *)image completion:(void (^)(NSError *error))completion;

///保存图片到系统相册
- (void)savePhotoWithImage:(UIImage *)image completion:(void (^)(NSError *error))completion;
- (void)saveVideoWithPath:(NSURL *)fileUrl completion:(void (^)(NSError *error))completion;


/// Get Assets 获得Asset数组
- (void)getAssetsWithAllowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<TJAssetModel *> *))completion;


///获取原图
- (void)getOriginalPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion;

///获取视频
- (void)getVideoOutputPathWithAsset:(id)asset completion:(void (^)(NSString *outputPath))completion;

///获取视频中的一张图片
+ (UIImage *)getVideoImageFromPathUrl:(NSURL *)videoURL;

///获取视频总长度
+(CGFloat) getVideoTotaltime:(NSURL *) movieUrl;

@end


