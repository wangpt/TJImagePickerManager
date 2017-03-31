//
//  TJProgressHUD.h
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/3/30.
//  Copyright © 2017年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJProgressHUD : UIView
+ (instancetype)showHUDAddedTo:(UIView *)view;
- (void)hideProgressHUD;
- (void)hideProgressHUDAfterDelay:(NSTimeInterval)delay;

@end
