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
#import "VoiceRecView.h"
@interface ViewController ()<VoiceDelegate>
@property (nonatomic,strong)VoiceRecView * recView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [TJPickerViewModel viewModel].delegate = self;

}
- (IBAction)reportPhoto:(id)sender {
    
    TJActionSheet *sheet = [TJActionSheet sheetWithTitle:@"请选择您需要的上传方式" buttonTitles:@[@"从手机选择",@"拍照"] redButtonIndex:-1 clicked:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [TJPickerViewModel viewModel].maximumNumberOfSelection = 2;
            [[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypePhoto];
        }else if (buttonIndex == 1){
            [[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypeCamera];
        }
    }];
    [sheet show];
}
- (IBAction)reportVideo:(id)sender {
    TJActionSheet *sheet = [TJActionSheet sheetWithTitle:@"请选择您需要的上传方式" buttonTitles:@[@"拍摄"] redButtonIndex:-1 clicked:^(NSInteger buttonIndex) {
        [[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypeCameraShot];
    }];
    
    [sheet show];
}
- (IBAction)reportAudio:(id)sender {
    TJActionSheet *sheet = [TJActionSheet sheetWithTitle:@"请选择您需要的上传方式" buttonTitles:@[@"录音"] redButtonIndex:-1 clicked:^(NSInteger buttonIndex) {
//        [[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypeAudio];
        
        self.recView= [[VoiceRecView alloc]initWithVoiceRecView];
        _recView.delegate=self;
        [self.view addSubview:_recView];
        self.recView.frame =CGRectMake((self.view.frame.size.width-self.recView.frame.size.width)/2, self.recView.frame.origin.y, self.recView.frame.size.width, self.recView.frame.size.height);

    }];
    
    [sheet show];
    
}
-(void)voiceFinishedWith:(NSString *)voiceurl{
    [self.recView removeFromSuperview];
    self.recView.delegate=nil;
//    TJImageEntity *entity =[[TJImageEntity alloc]init];
//    entity.assetPath = voiceurl;
//    entity.assetType = VOICETYPE;
//    [self addMediaBtnWithEntity:entity];
}
- (void)tj_imagePickerViewModelStyle:(TJAssetReportMediaType)type didFinishPickingAssets:(NSArray *)assets{
    NSLog(@"%@",assets);

    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
