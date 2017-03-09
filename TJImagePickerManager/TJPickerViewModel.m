//
//  TJPickerViewModel.m
//  TJActionSheet
//
//  Created by 王朋涛 on 17/2/20.
//  Copyright © 2017年 tao. All rights reserved.
//

#import "TJPickerViewModel.h"
#import "TJImagePickerManager.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>

@interface TJPickerViewModel ()
@property (nonatomic,strong) MWPhotoBrowser *webphotoBrowser;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic,assign) TJAssetReportMediaType  type;


@end


@implementation TJPickerViewModel
#pragma mark - 单利
+ (instancetype)viewModel
{
    static TJPickerViewModel * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
        _manager.videoMaximumDuration = 60.0f;
        _manager.maximumNumberOfSelection = 3;
    });
    return _manager;
}
#pragma mark - 懒加载

-(MWPhotoBrowser *)webphotoBrowser{
    if (!_webphotoBrowser) {
        _webphotoBrowser= [[MWPhotoBrowser alloc] initWithDelegate:(id)self];
        _webphotoBrowser.displayNavArrows = YES;
        _webphotoBrowser.enableSwipeToDismiss = YES;
    }
    return _webphotoBrowser;
    
}


#pragma mark - 附件上报

- (void)takeAssetWithStyle:(TJAssetReportMediaType)type{
    self.type = type;
    if (type ==TJAssetReportMediaTypePhoto) {//选择照片
        QBImagePickerController* _multipleImagePickerController = [QBImagePickerController new];
        _multipleImagePickerController.delegate = self;
        _multipleImagePickerController.mediaType = QBImagePickerMediaTypeImage;
        _multipleImagePickerController.allowsMultipleSelection = YES;
        _multipleImagePickerController.showsNumberOfSelectedAssets = YES;
        _multipleImagePickerController.maximumNumberOfSelection = self.maximumNumberOfSelection;
        [[[ UIApplication sharedApplication ] keyWindow ].rootViewController presentViewController:_multipleImagePickerController animated:YES completion:NULL];
        
    }else if (type==TJAssetReportMediaTypeCamera){//拍照
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePickerController = [UIImagePickerController new];
            //            [imagePickerController setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
            imagePickerController.delegate = self;
            imagePickerController.title=@"照片";
            if ([[TJImagePickerManager manager] isCameraAvailable]) {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [[[ UIApplication sharedApplication ] keyWindow ].rootViewController presentViewController:imagePickerController animated:YES completion:^{
                }];
            }
        }
        
    }else if (type==TJAssetReportMediaTypeCameraShot){//拍摄
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePickerController = [UIImagePickerController new];
            imagePickerController.delegate = self;
            imagePickerController.title=@"拍摄";
            imagePickerController.mediaTypes = [NSArray arrayWithObject:@"public.movie"];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.videoMaximumDuration = self.videoMaximumDuration;//设置最长录制5分钟
            [[[ UIApplication sharedApplication ] keyWindow ].rootViewController presentViewController:imagePickerController animated:YES completion:^{
            }];
        }
    
    
    }
    else if(type == TJAssetReportMediaTypeAudio) {//音频
        UIView * view = [[ UIApplication sharedApplication ] keyWindow ];
        TJAudioPlayerView *playerView =[[TJAudioPlayerView alloc]initWithFrame:view.frame];
        playerView.delegate = self;
        [view addSubview:playerView];
    }
    
    
}

#pragma mark - QBImagePickerControllerDelegate
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
    NSLog(@"Selected assets:");
    NSLog(@"%@", assets);
    if (self.delegate &&[self.delegate respondsToSelector:@selector(tj_imagePickerViewModelStyle:didFinishPickingAssets:)]) {
        [self.delegate tj_imagePickerViewModelStyle:self.type didFinishPickingAssets:assets];
    }
    [[[ UIApplication sharedApplication ] keyWindow ].rootViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"Canceled.");
    
    [[[ UIApplication sharedApplication ] keyWindow ].rootViewController dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - imagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [[TJImagePickerManager manager] saveAssectWithAlbumName:@"应急指挥" fileUrl:nil fileImage:image completion:^(NSError *error) {
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            }else{
                ///成功保存后进行获取
                [[TJImagePickerManager manager] getAssetsWithAllowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TJAssetModel *> *models) {
                    TJAssetModel *assetModel = [models lastObject];
                    [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                }];
            }
        }];
        
    }else{
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        [[TJImagePickerManager manager] saveAssectWithAlbumName:@"应急指挥" fileUrl:videoURL fileImage:nil completion:^(NSError *error) {
            if (error) {
                NSLog(@"视频保存失败 %@",error);
            }else{
                ///成功保存后进行获取
                [[TJImagePickerManager manager] getAssetsWithAllowPickingVideo:YES allowPickingImage:NO completion:^(NSArray<TJAssetModel *> *models) {
                    TJAssetModel *assetModel = [models lastObject];
                    [self refreshCollectionViewWithAddedAsset:assetModel.asset image:nil];
                }];
            }
        }];
        
    }
    
}
#pragma mark - TJAudioPlayerViewDelegate
- (void)audioPlayerDidFinishPlaying:(TJAudioPlayerView *)playerView path:(NSString *)path{
    [self refreshCollectionViewWithAddedAsset:path image:nil];
}
#pragma mark - 刷新和获取方法
//当image存在时取出照片
- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(tj_imagePickerViewModelStyle:didFinishPickingAssets:)]) {
        [self.delegate tj_imagePickerViewModelStyle:self.type didFinishPickingAssets:@[asset]];
        return;
    }
    //播放图片或视频
    if (image) {//图片
        [[TJImagePickerManager manager]getOriginalPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info) {
            NSMutableArray *photos = [[NSMutableArray alloc] init];
            [photos addObject:[MWPhoto photoWithImage:photo]];
            self.photos=photos;
            [self.webphotoBrowser setCurrentPhotoIndex:0];
            [self.webphotoBrowser reloadData];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.webphotoBrowser];
            nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [[[ UIApplication sharedApplication ] keyWindow ].rootViewController presentViewController:nc animated:YES completion:nil];
        }];
    }else{//视频
        
        [[TJImagePickerManager manager]getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
//            UIImage *photo = [TJImagePickerManager getVideoImageFromPathUrl:[NSURL fileURLWithPath:outputPath]];
            NSMutableArray *photos = [[NSMutableArray alloc] init];
//            [photos addObject:[MWPhoto photoWithImage:photo]];
            [photos addObject:[MWPhoto videoWithURL:[NSURL fileURLWithPath:outputPath]]];

            self.photos=photos;
            [self.webphotoBrowser setCurrentPhotoIndex:0];
            [self.webphotoBrowser reloadData];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.webphotoBrowser];
            nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [[[ UIApplication sharedApplication ] keyWindow ].rootViewController presentViewController:nc animated:YES completion:nil];
            
        }];
        
        
    }
    
}
#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}


@end
