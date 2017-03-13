//
//  TJMediaLibraryView.h
//  Zhilv
//
//  Created by 王朋涛 on 17/2/22.
//  Copyright © 2017年 wangpt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJPickerViewModel.h"
#define KMiniMediaButton_Height 40


@interface TJMediaEntity : NSObject
@property (nonatomic,strong) id asset;
@property (nonatomic,strong) NSString * assetPath;
@property (nonatomic,strong) UIImage * assetImage;
@property (nonatomic,assign) TJAssetReportMediaType assetType;
@end


@interface LittleMediaButton : UIButton
@property BOOL isTagedDeleted;//是否标记 为 要删除
@property(nonatomic,retain) NSString * downString;//判断下载附件地址
@property(nonatomic,strong) TJMediaEntity * entity;
@property(nonatomic,assign) TJAssetModelMediaType fileType;//类型
@end

@interface TJMediaLibraryView : UIView
@property(nonatomic,assign) NSInteger count;//总附件个数
@property(nonatomic,assign) BOOL order;//排列条件

- (void)addLittleMeidaButtonFromEntity:(TJMediaEntity *)entity;
- (void)removeAllLittleMediaButton;
@end
