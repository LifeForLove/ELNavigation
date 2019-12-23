//
//  UIViewController+ELExtension.m
//  ELNavigation
//
//  Created by ZCGC on 2019/8/1.
//  Copyright © 2019 getElementByYou. All rights reserved.
//

#import "UIViewController+ELExtension.h"
#import <objc/runtime.h>
#import "UINavigationBar+ELExtension.h"

@implementation UIViewController (ELExtension)

- (void)setEl_navigationBarTintColor:(UIColor *)el_navigationBarTintColor {
    objc_setAssociatedObject(self, @selector(el_navigationBarTintColor), el_navigationBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)el_navigationBarTintColor {
    UIColor * navigationBarTintColor = objc_getAssociatedObject(self, @selector(el_navigationBarTintColor));
    return navigationBarTintColor;
}

- (void)setEl_navigationBarBackgroundImage:(UIImage *)el_navigationBarBackgroundImage {
    objc_setAssociatedObject(self, @selector(el_navigationBarBackgroundImage), el_navigationBarBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)el_navigationBarBackgroundImage {
    UIImage * navigationBarBackgroundImage = objc_getAssociatedObject(self, @selector(el_navigationBarBackgroundImage));
    return navigationBarBackgroundImage;
}

- (void)setEl_navHidden:(BOOL)el_navHidden {
    objc_setAssociatedObject(self, @selector(el_navHidden), @(el_navHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)el_navHidden {
    return [objc_getAssociatedObject(self, @selector(el_navHidden)) boolValue];
}

- (void)setEl_prefersLargeTitles:(BOOL)el_prefersLargeTitles {
    objc_setAssociatedObject(self, @selector(el_prefersLargeTitles), @(el_prefersLargeTitles), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)el_prefersLargeTitles {
    return [objc_getAssociatedObject(self, @selector(el_prefersLargeTitles)) boolValue];
}

- (void)setEl_interactivePopGestureEnable:(BOOL)el_interactivePopGestureEnable {
    objc_setAssociatedObject(self, @selector(el_interactivePopGestureEnable), @(el_interactivePopGestureEnable), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)el_interactivePopGestureEnable {
    return [objc_getAssociatedObject(self, @selector(el_interactivePopGestureEnable)) boolValue];
}

- (void)setEl_navBackgroundAlpha:(CGFloat)el_navBackgroundAlpha {
    if (el_navBackgroundAlpha <= 1 && el_navBackgroundAlpha >= 0) {
        self.navigationController.navigationBar.el_navTransitionView.alpha = el_navBackgroundAlpha;
    } else {
        self.navigationController.navigationBar.el_navTransitionView.alpha = 1;
    }
    objc_setAssociatedObject(self, @selector(el_navBackgroundAlpha), @(el_navBackgroundAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)el_navBackgroundAlpha {
    return [objc_getAssociatedObject(self, @selector(el_navBackgroundAlpha)) floatValue];
}

- (void)setEl_navBottomLineColor:(UIColor *)el_navBottomLineColor {
    objc_setAssociatedObject(self, @selector(el_navBottomLineColor), el_navBottomLineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)el_navBottomLineColor {
    return objc_getAssociatedObject(self, @selector(el_navBottomLineColor));
}

@end
