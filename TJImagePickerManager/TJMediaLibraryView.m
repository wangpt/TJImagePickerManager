//
//  TJMediaLibraryView.m
//  Zhilv
//
//  Created by 王朋涛 on 17/2/22.
//  Copyright © 2017年 wangpt. All rights reserved.
//

#import "TJMediaLibraryView.h"
//#import "TJImageReportManager.h"
@implementation MiniMediaButton

//-(FileRequestType)temType:(UPLOADFILETYPE)type{
//    if (type==PICTYPE) {
//        return FileRequestTypePic;
//    }else if (type==VIDEOTYPE){
//        return FileRequestTypeVideo;
//    }else{
//        return FileRequestTypeVoice;
//    }
//}

@end
@implementation TJMediaLibraryView
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//- (id)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        [self setup];
//    }
//    return self;
//}
#pragma mark -
-(void)rangeMediaLittleBtn{
    int i =0;
    for ( MiniMediaButton * btn in self.subviews) {
        btn.frame=CGRectMake(SCREEN_WIDTH-40-30-i*50, 0, KMiniMediaButton_Height, KMiniMediaButton_Height);
        i++;
    }

}
//-(void)addMediaBtnMediaUrl:(NSString *)mediaUrl andBlFileType:(UPLOADFILETYPE)type{
//    
//    UIImage * temimage;
//    if (type==PICTYPE) {
//        temimage=[UIImage imageWithContentsOfFile:mediaUrl];
//    }else if(type==VIDEOTYPE){
//        temimage=[[TJImageReportManager manager] getVideoFrame:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",mediaUrl]]];
//    }else{
//        temimage=[UIImage imageNamed:@"laba"];
//    }
//    
//    MiniMediaButton * temBtn =[[MiniMediaButton alloc]initWithFrame:CGRectZero];
//    BLFile * file =[[BLFile alloc]init];
//    file.fileType=type;
//    file.fileUrl=mediaUrl;
//    
//    file.fileName=[[mediaUrl componentsSeparatedByString:@"/"] lastObject ];
//    NSData *data =[NSData dataWithContentsOfFile:mediaUrl];
//    file.fileCurrentSize=0;
//    file.fileTotalSize=[data length];
//    //    NSLog(@"文件大小 %d",file.fileTotalSize);
//    temBtn.file=file;
//    [temBtn setImage:temimage forState:UIControlStateNormal];
//    [self addSubview:temBtn];
//    [temBtn addTarget:self action:@selector(removeMiniMediaButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self rangeMediaLittleBtn];
//}


#pragma mark  删除 缩微图   按钮
-(void)removeMiniMediaButton:(MiniMediaButton*)btn{
//    btn.isTagedDeleted=YES;
//    NSString * mess=nil;
//    switch (btn.file.fileType) {
//        case PICTYPE:
//            mess=@"该图片";
//            break;
//        case VOICETYPE:
//            mess=@"该音频";
//            break;
//        case VIDEOTYPE:
//            mess=@"该视频";
//            break;
//        default:
//            break;
//    }
//    
//    NSString * aletMess=[NSString
//                         stringWithFormat:@"您确定要删除%@吗?",mess];
//    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"消息提示" message:aletMess delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        for ( MiniMediaButton * btn in self.subviews) {
            btn.isTagedDeleted=NO;
        }
        
    }else if (buttonIndex==1){
        
        for ( MiniMediaButton * btn in self.subviews) {
            if (btn.isTagedDeleted) {
                [btn removeFromSuperview];
                [self rangeMediaLittleBtn];
                return;
            } }
    }
}

@end
