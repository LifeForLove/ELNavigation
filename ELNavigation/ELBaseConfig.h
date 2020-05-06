//
//  ELBaseConfig.h
//  ELBase
//
//  Created by ZCGC on 2019/8/30.
//

#ifndef ELBaseConfig_h
#define ELBaseConfig_h

/// iPhoneX  iPhoneXS  iPhoneXS Max  iPhoneXR 机型判断
#define iPhoneX IsIphoneX()

//导航高度
#define SafeAreaNavHeight NavHeight()

#define SafeAreaStateHeight StateBarHeight()

//UITabBar高度由49pt变成了83pt,增加了34
#define SafeAreaTabbarHeight tabbarHeight()

//iPhone X底部高度
#define SafeAreaBarIncreaseHeight tabbarIncreaseHeight()

static inline BOOL Screen_Orientation_V() {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return YES;
    }else {
        return NO;
    }
}

static inline CGSize ELScreenSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}

static inline BOOL IsIphoneX() {
    NSInteger scale = ELScreenSize().height / ELScreenSize().width * 100;
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (scale == 216) : NO);
}


static inline CGFloat NavHeight() {
    if (Screen_Orientation_V()) {
        return (iPhoneX ? 88 : 64);
    } else {
        CGFloat stateBarHeight = (iPhoneX ? 0 : 20);
        CGFloat navBarHeight = ELScreenSize().width < 400 ? 32 : 44;
        return stateBarHeight + navBarHeight;
    }
}

static inline CGFloat StateBarHeight() {
    if (Screen_Orientation_V()) {
        return (iPhoneX ? 44 : 20);
    } else {
        CGFloat stateBarHeight = (iPhoneX ? 0 : 20);
        CGFloat navBarHeight = ELScreenSize().width < 400 ? 32 : 44;
        return stateBarHeight + navBarHeight;
    }
}

static inline CGFloat tabbarIncreaseHeight() {
    if (Screen_Orientation_V()) {
        return (iPhoneX ? 34 : 0);
    } else {
        return (iPhoneX ? 21 : 0);
    }
}


static inline CGFloat tabbarHeight() {
    if (Screen_Orientation_V()) {
        return (iPhoneX ? 83 : 49);
    } else {
        CGFloat height = 70;
        if (@available(iOS 11.0, *)) {
            if (ELScreenSize().width < 400) {
                height = 53;
            }
        }
        return height;
    }
}

#endif /* ELBaseConfig_h */
