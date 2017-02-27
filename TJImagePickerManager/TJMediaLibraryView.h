//
//  TJMediaLibraryView.h
//  Zhilv
//
//  Created by 王朋涛 on 17/2/22.
//  Copyright © 2017年 wangpt. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KMiniMediaButton_Height 40
//#import "BLFile.h"

@interface MiniMediaButton : UIButton
@property BOOL isTagedDeleted;//是否标记 为 要删除
//@property(nonatomic,retain) BLFile * file;
@property(nonatomic,retain) NSString * downString;//判断下载附件地址
//-(FileRequestType)temType:(UPLOADFILETYPE)type;

@end


@interface TJMediaLibraryView : UIView
@property (nonatomic,assign) float height;
@end
