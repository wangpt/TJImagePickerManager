//
//  TJProgressClient.m
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/3/29.
//  Copyright © 2017年 tao. All rights reserved.
//

#import "TJProgressClient.h"
@interface TJProgressClient()
@property (nonatomic,strong)UIActivityIndicatorView* activityIndicatorView;

@end
@implementation TJProgressClient

+ (TJProgressClient *)sharedProgress{

    static TJProgressClient * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;


}
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

- (UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        _activityIndicatorView= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        //设置显示样式,见UIActivityIndicatorViewStyle的定义
        _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        //设置显示位置
        [_activityIndicatorView setCenter:CGPointMake(SCREEN_SIZE.width / 2, SCREEN_SIZE.height / 2)];
        //设置背景色
        _activityIndicatorView.backgroundColor = [UIColor grayColor];
        //设置背景透明
        _activityIndicatorView.alpha = 0.7;
        //设置背景为圆角矩形
        _activityIndicatorView.layer.cornerRadius = 6;
        _activityIndicatorView.layer.masksToBounds = YES;
        //开始显示Loading动画
        [_activityIndicatorView startAnimating];

        
    }
    return _activityIndicatorView;

}

+ (instancetype)showHUDAddedTo:(UIView *)view{
    UIView *hud = [[self alloc] initWithView:view];
//    MBProgressHUD *hud = [[self alloc] initWithView:view];
//    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
//    [hud showAnimated:animated];
    return hud;
}


- (void)show:(UIView *)view{
    if (!_activityIndicatorView) {
        [view addSubview:self.activityIndicatorView];
    }
    [self.activityIndicatorView startAnimating];


}
- (void)stop{
    [self.activityIndicatorView stopAnimating];
}
@end
