# TJImagePickerManager

base on UIImagePickerView

![image](https://github.com/wangpt/TJImagePickerManager/blob/master/Untitled.gif)
# 上传图片
[[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypePhoto];

# 上传视频
[[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypeCameraShot];

# 上传音频
[[TJPickerViewModel viewModel] takeAssetWithStyle:TJAssetReportMediaTypeAudio];
＃ 回调方法
[TJPickerViewModel viewModel].delegate = self;
- (void)tj_imagePickerViewModelStyle:(TJAssetReportMediaType)type didFinishPickingAssets:(NSArray *)assets;



