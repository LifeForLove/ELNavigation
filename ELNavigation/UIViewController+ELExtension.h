//
//  UIViewController+ELExtension.h
//  ELNavigation
//
//  Created by ZCGC on 2019/8/1.
//  Copyright © 2019 getElementByYou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ELExtension)

/// 是否隐藏导航栏 default  = NO
@property (nonatomic, assign) BOOL el_navHidden;

/// 导航栏文字颜色 default  = blackColor
@property (nonatomic, strong) UIColor * el_navigationBarTintColor;

/// 导航栏背景颜色/图片 default  = whiteColor
@property (nonatomic, strong) UIImage * el_navigationBarBackgroundImage;

/// 是否开启largeTitle default  = NO
@property (nonatomic, assign) BOOL el_prefersLargeTitles;

/// 导航栏背景颜色透明度 default = 1
@property (nonatomic, assign) CGFloat el_navBackgroundAlpha;

/// 手势返回是否禁用  default  = YES
@property (nonatomic, assign) BOOL el_interactivePopGestureEnable;

/// 导航栏底部线条颜色 default = nil
@property (nonatomic,strong,nullable) UIColor *el_navBottomLineColor;

@end

NS_ASSUME_NONNULL_END
