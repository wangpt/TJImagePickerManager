//
//  TJProgressClient.h
//  TJImagePickerManager
//
//  Created by 王朋涛 on 17/3/29.
//  Copyright © 2017年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TJProgressClient : NSObject
+ (instancetype)showHUDAddedTo:(UIView *)view;
+ (TJProgressClient *)sharedProgress;
- (void)show:(UIView *)view;
- (void)stop;
@end
