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






