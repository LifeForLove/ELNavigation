//
//  UINavigationBar+ELExtension.m
//  ELNavigation
//
//  Created by ZCGC on 2019/8/1.
//  Copyright © 2019 getElementByYou. All rights reserved.
//

#import "UINavigationBar+ELExtension.h"
#import <objc/runtime.h>
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((NSInteger)(([[UIScreen mainScreen] currentMode].size.height/[[UIScreen mainScreen] currentMode].size.width)*100) == 216) : NO)
#define SafeAreaNavHeight (iPhoneX ? 88 : 64)
@implementation UINavigationBar (ELExtension)

- (void)setEl_navTransitionView:(UIImageView *)el_navTransitionView {
    objc_setAssociatedObject(self, @selector(el_navTransitionView), el_navTransitionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)el_navTransitionView {
    UIImageView * navTransitionView = objc_getAssociatedObject(self, @selector(el_navTransitionView));
    if (navTransitionView == nil) {
        navTransitionView = [[UIImageView alloc]init];
        navTransitionView.backgroundColor = [UIColor purpleColor];
        navTransitionView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        [self.subviews.firstObject insertSubview:navTransitionView atIndex:0];
        navTransitionView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), SafeAreaNavHeight);
        objc_setAssociatedObject(self, @selector(el_navTransitionView), navTransitionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navTransitionView;
}

@end

