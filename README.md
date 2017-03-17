# TJImagePickerManager

base on UIImagePickerView

![image](https://github.com/wangpt/TJImagePickerManager/blob/master/Untitled.gif)
# 上传图片
[[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypePhoto];

# 上传视频
[[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypeCameraShot];

# 上传音频
[[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypeAudio];

# 回调方法
[TJPickerViewModel viewModel].delegate = self;

tj_imagePickerViewModelStyle:(TJAssetReportMediaType)type didFinishPickingAssets:(NSArray *)assets;

# 视图页面显示
self.libraryView =[[TJMediaLibraryView alloc]initWithFrame:CGRectMake(0, 400, width, 44)];

[self.view addSubview:self.libraryView];

[self.libraryView addLittleMeidaButtonFromEntity:entity];


# TJImagePickerManager

base on UIImagePickerView

![image](https://github.com/wangpt/TJImagePickerManager/blob/master/Untitled.gif)
# 上传图片
[[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypePhoto];

# 上传视频
[[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypeCameraShot];

# 上传音频
[[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypeAudio];

# 回调方法
[TJPickerViewModel viewModel].delegate = self;

tj_imagePickerViewModelStyle:(TJAssetReportMediaType)type didFinishPickingAssets:(NSArray *)assets;

# 视图页面初始化
self.libraryView =[[TJMediaLibraryView alloc]initWithFrame:CGRectMake(0, 400, width, 44)];

[self.view addSubview:self.libraryView];

# 获取视图资源
    if (type == TJAssetReportMediaTypePhoto||type ==TJAssetReportMediaTypeCamera) {//照片
        [assets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PHAsset *asset = obj;
            [[TJImagePickerManager manager]getOriginalPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info) {
                TJMediaEntity *entity =[[TJMediaEntity alloc]init];
                entity.asset = asset;
                entity.assetImage = photo;
                entity.assetType = type;
                [self.libraryView addLittleMeidaButtonFromEntity:entity];

            }];
        }];
        
    }else if (type ==TJAssetReportMediaTypeCameraShot){//录像
        PHAsset *asset = assets.firstObject;
        [[TJImagePickerManager manager]getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
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
    
    


