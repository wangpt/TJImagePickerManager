//
//  ViewController.m
//  TJActionSheet
//
//  Created by 王朋涛 on 17/2/6.
//  Copyright © 2017年 tao. All rights reserved.
//

#import "ViewController.h"
#import "TJActionSheet.h"
#import "TJImagePickerManager.h"
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import "TJVoiceRecordManager.h"
#import "TJAudioPlayerView.h"
#import "TJMediaLibraryView.h"
@interface ViewController ()
@property (nonatomic,strong)TJMediaLibraryView * libraryView;
@property (nonatomic,strong)TJVoiceRecordManager * voiceRecord;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat width = self.view.frame.size.width;
    [TJPickerViewModel shareSingle].delegate = self;
    self.libraryView =[[TJMediaLibraryView alloc]initWithFrame:CGRectMake(0, 400, width, 44)];
    [self.view addSubview:self.libraryView];
    self.libraryView.backgroundColor = [UIColor redColor];
}
- (IBAction)reportPhoto:(id)sender {
    TJActionSheet *sheet = [TJActionSheet sheetWithTitle:@"请选择您需要的上传方式" buttonTitles:@[@"从手机选择",@"拍照"] redButtonIndex:-1 clicked:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [TJPickerViewModel shareSingle].maximumNumberOfSelection = 2;
            [[TJPickerViewModel shareSingle] takeAssetWithStyle:TJAssetReportMediaTypePhoto];
        }else if (buttonIndex == 1){
            [[TJPickerViewModel shareSingle] takeAssetWithStyle:TJAssetReportMediaTypeCamera];
        }
    }];
    [sheet show];
}
- (IBAction)reportVideo:(id)sender {
    TJActionSheet *sheet = [TJActionSheet sheetWithTitle:@"请选择您需要的上传方式" buttonTitles:@[@"拍摄"] redButtonIndex:-1 clicked:^(NSInteger buttonIndex) {
        [[TJPickerViewModel shareSingle] takeAssetWithStyle:TJAssetReportMediaTypeCameraShot];
    }];
    
    [sheet show];
}
- (IBAction)reportAudio:(id)sender {
    
    TJActionSheet *sheet = [TJActionSheet sheetWithTitle:@"请选择您需要的上传方式" buttonTitles:@[@"录音"] redButtonIndex:-1 clicked:^(NSInteger buttonIndex) {
        [[TJPickerViewModel shareSingle] takeAssetWithStyle:TJAssetReportMediaTypeAudio];
    

    }];
    
    [sheet show];
    
}


- (void)tj_imagePickerViewModelStyle:(TJAssetReportMediaType)type didFinishPickingAssets:(NSArray *)assets{

    if (type == TJAssetReportMediaTypePhoto||type ==TJAssetReportMediaTypeCamera) {//照片
        [assets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PHAsset *asset = obj;
            [[TJImagePickerManager shareInstance]getOriginalPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info) {
                TJMediaEntity *entity =[[TJMediaEntity alloc]init];
                entity.asset = asset;
                entity.assetImage = photo;
                entity.assetType = type;
                [self.libraryView addLittleMeidaButtonFromEntity:entity];

            }];
        }];
        
    }else if (type ==TJAssetReportMediaTypeCameraShot){//录像
        PHAsset *asset = assets.firstObject;
        [[TJImagePickerManager shareInstance]getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
            TJMediaEntity *entity =[[TJMediaEntity alloc]init];
            entity.asset = asset;
            entity.assetPath = outputPath;
            entity.assetType = type;
            [self.libraryView addLittleMeidaButtonFromEntity:entity];
            
        }];
        
        
    }else{//录音
        NSString *path = assets.firstObject;
        TJMediaEntity *entity =[[TJMediaEntity alloc]init];
        entity.assetPath = path;
        entity.assetType = TJAssetReportMediaTypeAudio;
        [self.libraryView addLittleMeidaButtonFromEntity:entity];
        
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
