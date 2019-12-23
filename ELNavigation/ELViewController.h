//
//  ELViewController.h
//  ELNavigation
//
//  Created by ZCGC on 2019/8/1.
//  Copyright © 2019 getElementByYou. All rights reserved.
//

#import "ELBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELNavConfigModel : NSObject

/// 导航栏颜色
@property (nonatomic,strong) UIColor *navColor;

/// 是否使用导航栏图片
@property (nonatomic,assign) BOOL navImgSelect;

/// largeTitle
@property (nonatomic,assign) BOOL largeTitleSelect;

/// 导航栏渐变
@property (nonatomic,assign) BOOL gradualChangeColorSelect;

/// 隐藏导航栏
@property (nonatomic,assign) BOOL hiddenNav;

/// 手势返回禁用
@property (nonatomic,assign) BOOL popGesEnable;

/// 导航栏底部横线颜色
@property (nonatomic,strong) UIColor * navBottomLineColor;

/// 是否修改导航栏颜色
@property (nonatomic,strong) UIColor * navTintColor;


@end


@interface ELViewController : ELBaseVC


@property (nonatomic,strong) ELNavConfigModel *configModel;

@end

NS_ASSUME_NONNULL_END
