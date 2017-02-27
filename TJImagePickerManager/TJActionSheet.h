//
//  TJActionSheet.h
//  TJActionSheet
//
//  Created by 王朋涛 on 17/2/6.
//  Copyright © 2017年 tao. All rights reserved.
//

// 颜色色值
#define TJ_ACTION_SHEET_COLOR(r, g, b)      TJ_ACTION_SHEET_COLOR_A(r, g, b, 1.0f)
#define TJ_ACTION_SHEET_COLOR_A(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A/1.0]
// 屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

#import <UIKit/UIKit.h>
typedef void(^TJActionSheetClickedHandle)(NSInteger buttonIndex);

@interface TJActionSheet : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger redButtonIndex;

@property (nonatomic, copy) TJActionSheetClickedHandle clickedHandle;

#pragma mark - Block Handle

/**
 *  返回一个 ActionSheet 对象, 类方法
 *
 *  @param title          提示标题
 *  @param items   所有按钮的标题
 *  @param redButtonIndex 红色按钮的index
 *  @param clicked        点击按钮的 block 回调
 *
 *  Tip: 如果没有红色按钮, redButtonIndex 给 `-1` 即可
 */
+ (instancetype)sheetWithTitle:(NSString *)title
                  buttonTitles:(NSArray *)items
                redButtonIndex:(NSInteger)redButtonIndex
                       clicked:(TJActionSheetClickedHandle)clicked;
#pragma mark - Show

/**
 *  显示 ActionSheet
 */
- (void)show;

@end
#pragma mark - 样式修改

@interface TJActionSheetConfig : NSObject

/**
 *  localized cancel text. Default is "取消"
 */
@property (nonatomic, copy) NSString *cancelText;

/**
 *  Title's color. Default is RGB(111, 111, 111).
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 *  All buttons' color, without destructive buttons. Default is `[UIColor blackColor]`.
 */
@property (nonatomic, strong) UIColor *buttonLabelColor;

/**
 *  All buttons' Highlighted color, without destructive buttons. Default is RGB(222, 222, 222).
 */
@property (nonatomic, strong) UIColor *buttonHighlightedColor;

/**
 *  All buttons' Highlighted color, without destructive buttons. Default is RGB(222, 222, 222).
 */
@property (nonatomic, strong) UIImage *buttonHighlightedImage;

/**
 *  Title's font. Default is `[UIFont systemFontOfSize:13.0f]`.
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 *  All buttons' font. Default is `[UIFont systemFontOfSize:18.0f]`.
 */
@property (nonatomic, strong) UIFont *buttonLabelFont;

/**
 *  All buttons' height. Default is 49.0f;
 */
@property (nonatomic, assign) CGFloat buttonHeight;

/**
 *  UIColor -> UIImage;
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  TJActionSheetConfig instance.
 */
+ (instancetype)shared;


@end

