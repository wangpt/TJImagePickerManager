//
//  TJProgressHUD.m
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/3/30.
//  Copyright © 2017年 tao. All rights reserved.
//

#import "TJProgressHUD.h"
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface TJProgressHUD()
@property (nonatomic,strong)UIActivityIndicatorView* activityIndicatorView;

@end
@implementation TJProgressHUD

+ (instancetype)showHUDAddedTo:(UIView *)view{
    TJProgressHUD *hud = [[self alloc] initWithView:view];
    [view addSubview:hud];
    return hud;
}

- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}
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
        
        
    }
    return _activityIndicatorView;
    
}
#pragma mark - Lifecycle

- (void)commonInit {
    [self addSubview:self.activityIndicatorView];
}





@end
