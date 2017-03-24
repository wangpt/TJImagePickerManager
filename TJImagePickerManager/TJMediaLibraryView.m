//
//  TJMediaLibraryView.m
//  Zhilv
//
//  Created by 王朋涛 on 17/2/22.
//  Copyright © 2017年 wangpt. All rights reserved.
//

#import "TJMediaLibraryView.h"

@implementation TJMediaEntity

@end

@implementation LittleMediaButton

@end

@interface TJMediaLibraryView()
@property (nonatomic,assign) CGFloat width;

@end

@implementation TJMediaLibraryView
#pragma mark - 排列缩略图
- (void)rangeMediaLittleButton{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LittleMediaButton * btn = obj;
        CGFloat x;
        if (_order) {
            x = idx*50+10;
            btn.frame=CGRectMake(idx*50+10, 0, KMiniMediaButton_Height, KMiniMediaButton_Height);

        }else{
            x = self.width-KMiniMediaButton_Height-idx*50-10;
        }
        btn.frame=CGRectMake(x, 0, KMiniMediaButton_Height, KMiniMediaButton_Height);

        
    }];
}
- (CGFloat) width{
    return self.frame.size.width;
}
- (NSInteger)count{
    NSInteger count=0;
    for(LittleMediaButton * btn in self.subviews){
        if ([btn isKindOfClass:[LittleMediaButton class]]) {
            count++;
        }
    }
    return count;
}
#pragma mark - 添加缩略图

- (void)addLittleMeidaButtonFromEntity:(TJMediaEntity *)entity{
    if (entity.assetType == TJAssetReportMediaTypePhoto ||entity.assetType == TJAssetReportMediaTypeCamera) {
        LittleMediaButton * temBtn =[LittleMediaButton new];
        [temBtn addTarget:self action:@selector(removeLittleMeidaButton:) forControlEvents:UIControlEventTouchUpInside];
        temBtn.entity = entity;
        temBtn.fileType = TJAssetModelMediaTypePhoto;
        [temBtn setImage:entity.assetImage forState:UIControlStateNormal];
        [self addSubview:temBtn];
        
    }else if (entity.assetType == TJAssetReportMediaTypeCameraShot||entity.assetType == TJAssetReportMediaTypeVideo){
        UIImage * temimage=[TJImagePickerManager getVideoImageFromPathUrl:[NSURL fileURLWithPath:entity.assetPath]];
        LittleMediaButton * temBtn =[LittleMediaButton new];
        [temBtn addTarget:self action:@selector(removeLittleMeidaButton:) forControlEvents:UIControlEventTouchUpInside];
        temBtn.entity = entity;
        temBtn.fileType=TJAssetModelMediaTypeVideo;
        [temBtn setImage:temimage forState:UIControlStateNormal];
        [self addSubview:temBtn];
        
    }else{
        LittleMediaButton * temBtn =[LittleMediaButton new];
        [temBtn addTarget:self action:@selector(removeLittleMeidaButton:) forControlEvents:UIControlEventTouchUpInside];
        temBtn.entity = entity;
        temBtn.fileType = TJAssetModelMediaTypeAudio;
        [temBtn setImage:[UIImage imageNamed:@"record_voice"] forState:UIControlStateNormal];
        [self addSubview:temBtn];
    }
    [self rangeMediaLittleButton];

}

#pragma mark - 删除缩略图
-(void)removeLittleMeidaButton:(LittleMediaButton*)btn{
    btn.isTagedDeleted=YES;
    NSString * mess=nil;
    switch (btn.fileType) {
        case TJAssetModelMediaTypePhoto:
            mess=@"该图片";
            break;
        case TJAssetModelMediaTypeAudio:
            mess=@"该音频";
            break;
        case TJAssetModelMediaTypeVideo:
            mess=@"该视频";
            break;
        default:
            break;
    }
    
    NSString * aletMess=[NSString
                         stringWithFormat:@"您确定要删除%@吗?",mess];
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"消息提示" message:aletMess delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}
- (void)removeAllLittleMediaButton{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
        
    }];
    
}
#pragma mark - 提示按钮
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LittleMediaButton *btn = obj;
            btn.isTagedDeleted=NO;

        }];

    }else{
        for ( LittleMediaButton * btn in self.subviews) {
            if (btn.isTagedDeleted) {
                [btn removeFromSuperview];
                [self rangeMediaLittleButton];
                return;
            } }
    }
}

@end
