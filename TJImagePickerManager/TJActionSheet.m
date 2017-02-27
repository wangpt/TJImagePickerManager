//
//  TJActionSheet.m
//  TJActionSheet
//
//  Created by 王朋涛 on 17/2/6.
//  Copyright © 2017年 tao. All rights reserved.
//

#import "TJActionSheet.h"
@interface TJActionSheet ()

//按钮标题
@property (nonatomic, copy) NSArray *actionItems;

//暗黑色的view
@property (nonatomic, strong) UIView *darkView;

//所有按钮的底部view
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation TJActionSheet

#pragma mark - methods

+ (instancetype)sheetWithTitle:(NSString *)title buttonTitles:(NSArray *)items redButtonIndex:(NSInteger)redButtonIndex clicked:(TJActionSheetClickedHandle)clicked {
    
    return [[self alloc] initWithTitle:title buttonTitles:items redButtonIndex:redButtonIndex clicked:clicked];
}

- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)items
               redButtonIndex:(NSInteger)redButtonIndex
                      clicked:(TJActionSheetClickedHandle)clicked {
    
    if (self = [super init]) {
        NSAssert(items.count>0, @"Could not find any items.");
        self.title = title;
        self.actionItems =items;
        self.redButtonIndex = redButtonIndex;
        self.clickedHandle = clicked;
    }
    
    return self;
}


- (void)setupMainView {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    // 暗黑色的view
    UIView *darkView = [[UIView alloc] init];
    [darkView setAlpha:0];
    [darkView setUserInteractionEnabled:NO];
    [darkView setFrame:(CGRect){0, 0, SCREEN_SIZE}];
    [darkView setBackgroundColor:TJ_ACTION_SHEET_COLOR(46, 49, 50)];
    _darkView = darkView;
    [self addSubview:_darkView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [darkView addGestureRecognizer:tap];
    
    // 所有按钮的底部view
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView = bottomView;
    [self addSubview:_bottomView];
    TJActionSheetConfig *config = [TJActionSheetConfig shared];
    if (self.title) {
        
        CGFloat vSpace = 0;
        CGSize titleSize = [self.title sizeWithAttributes:@{NSFontAttributeName : config.titleFont}];
        if (titleSize.width > SCREEN_SIZE.width - 30.0f) {
            vSpace = 15.0f;
        }
        
        UIView *titleBgView = [[UIView alloc] init];
        titleBgView.backgroundColor = [UIColor whiteColor];
        titleBgView.frame = CGRectMake(0, -vSpace, SCREEN_SIZE.width, config.buttonHeight + vSpace);
        [bottomView addSubview:titleBgView];
        
        // 标题
        UILabel *label = [[UILabel alloc] init];
        [label setText:self.title];
        [label setNumberOfLines:2.0f];
        [label setTextColor:config.titleColor];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:13.0f]];
        [label setBackgroundColor:[UIColor whiteColor]];
        [label setFrame:CGRectMake(15.0f, 0, SCREEN_SIZE.width - 30.0f, titleBgView.frame.size.height)];
        [titleBgView addSubview:label];
    }
    

    
        for (int i = 0; i < self.actionItems.count; i++) {
            
            // 所有按钮
            UIButton *btn = [[UIButton alloc] init];
            [btn setTag:i];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitle:self.actionItems[i] forState:UIControlStateNormal];
            [[btn titleLabel] setFont:config.buttonLabelFont];
            UIColor *titleColor = nil;
            if (i == self.redButtonIndex) {
                
                titleColor = TJ_ACTION_SHEET_COLOR(255, 10, 10);
                
            } else {
                
                titleColor = config.buttonLabelColor ;
            }
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
            [btn setBackgroundImage:config.buttonHighlightedImage forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            CGFloat btnY = config.buttonHeight * (i + (self.title ? 1 : 0));
            [btn setFrame:CGRectMake(0, btnY, SCREEN_SIZE.width, config.buttonHeight)];
            [bottomView addSubview:btn];
        }
        
        for (int i = 0; i < self.actionItems.count; i++) {
            // 所有线条
            UIView *lineView = [UIView new];
            lineView.backgroundColor = config.buttonHighlightedColor;
            CGFloat lineY = (i + (self.title ? 1 : 0)) * config.buttonHeight;
            [bottomView addSubview:lineView];
            [lineView setFrame:CGRectMake(0, lineY, SCREEN_SIZE.width, 0.5)];


        }
//    }
    CGFloat divisionViewY = config.buttonHeight * (self.actionItems.count + (self.title ? 1 : 0));
    UIView *divisionView  = [[UIView alloc] initWithFrame:CGRectMake(0, divisionViewY, SCREEN_SIZE.width, 5)];
    divisionView.backgroundColor = config.buttonHighlightedColor;
    divisionView.alpha = 0.3;
    [bottomView addSubview:divisionView];
    
    // 取消按钮
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTag:self.actionItems.count];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setTitle:config.cancelText forState:UIControlStateNormal];
    [[cancelBtn titleLabel] setFont:config.buttonLabelFont];
    [cancelBtn setTitleColor:config.buttonLabelColor forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:config.buttonHighlightedImage forState:UIControlStateHighlighted];
    [cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat btnY = config.buttonHeight * (self.actionItems.count + (self.title ? 1 : 0)) + 5.0f;
    [cancelBtn setFrame:CGRectMake(0, btnY, SCREEN_SIZE.width, config.buttonHeight)];
    [bottomView addSubview:cancelBtn];
    
    CGFloat bottomH = (self.title ? config.buttonHeight : 0) + config.buttonHeight * self.actionItems.count + config.buttonHeight + 5.0f;
    [bottomView setFrame:CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, bottomH)];
    [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
}

#pragma mark - 点击

- (void)didClickBtn:(UIButton *)btn {
    
    [self dismiss:nil];
    
    if (self.clickedHandle) {
        self.clickedHandle(btn.tag);
    }
}
#pragma mark - 取消

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_darkView setAlpha:0];
        [_darkView setUserInteractionEnabled:NO];
        CGRect frame = _bottomView.frame;
        frame.origin.y += frame.size.height;
        [_bottomView setFrame:frame];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}

- (void)didClickCancelBtn {
    [self dismiss:nil];
}

#pragma mark - 显示
- (void)show {
    [self setupMainView];
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [_darkView setAlpha:0.3f];
        [_darkView setUserInteractionEnabled:YES];
        
        CGRect frame = _bottomView.frame;
        frame.origin.y -= frame.size.height;
        [_bottomView setFrame:frame];
        
    } completion:nil];
}

@end
#define TJ_ACTION_SHEET_BUTTON_HEIGHT       49.0f
#define TJ_ACTION_SHEET_BUTTON_FONT       [UIFont systemFontOfSize:18.0f]
#define TJ_ACTION_SHEET_TITLE_FONT       [UIFont systemFontOfSize:13.0f]

#pragma mark - 默认的样式

@interface TJActionSheetConfig()

@end

@implementation TJActionSheetConfig
+ (instancetype)shared {
    static id _shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}
- (instancetype)init {
    if (self = [super init]) {
        self.cancelText             = @"取消";
        self.titleFont              = TJ_ACTION_SHEET_TITLE_FONT;
        self.buttonLabelFont        = TJ_ACTION_SHEET_BUTTON_FONT;
        self.titleColor             = TJ_ACTION_SHEET_COLOR(111, 111, 111);
        self.buttonLabelColor       = [UIColor blackColor];
        self.buttonHeight           = TJ_ACTION_SHEET_BUTTON_HEIGHT;
        self.buttonHighlightedColor = TJ_ACTION_SHEET_COLOR(222, 222, 222);
        self.buttonHighlightedImage  = [TJActionSheetConfig imageWithColor:self.buttonHighlightedColor];
    }
    return self;
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end



