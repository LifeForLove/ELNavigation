//
//  ELNavigationController.m
//  ELNavigation
//
//  Created by ZCGC on 2019/8/1.
//  Copyright © 2019 getElementByYou. All rights reserved.
//

#import "ELNavigationController.h"
#import "UINavigationBar+ELExtension.h"
#import "UIViewController+ELExtension.h"
#import "ELBaseConfig.h"
@interface ELNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) UIImageView * animateView;

@end

@implementation ELNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    __weak typeof(self)weakSelf = self;
    self.delegate = weakSelf;
    [self.interactivePopGestureRecognizer addTarget:self action:@selector(interactivePopGes:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /// 启动的时候不能立即获取到导航栏上的view 所以特殊处理
    [self.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            obj.backgroundColor = UIColor.clearColor;
        }
    }];
    
    if (@available(iOS 13.0, *)) {
        [self.navigationBar.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            self.navigationBar.subviews.firstObject.subviews.firstObject.backgroundColor = self.viewControllers.lastObject.el_navBottomLineColor ?:[UIColor clearColor];
        }];
    }
    [self.navigationBar setShadowImage:[self imageWithColor:self.viewControllers.lastObject.el_navBottomLineColor ?: [UIColor clearColor] ]];
}

- (void)interactivePopGes:(UIGestureRecognizer *)ges {
    CGFloat progress = self.transitionCoordinator.percentComplete;
    UIViewController * fromVc = [self.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [self.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    
    switch (ges.state) {
        case UIGestureRecognizerStateBegan: {
            self.animateView = [[UIImageView alloc]init];
            self.animateView.frame = toVc.navigationController.navigationBar.el_navTransitionView.bounds;
            self.animateView.image = fromVc.navigationController.navigationBar.el_navTransitionView.image;
            [toVc.navigationController.navigationBar.el_navTransitionView addSubview:self.animateView];
            [self el_configNavigationBarStyleWithViewController:toVc];
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            self.animateView.alpha = 1 - progress;
        }
            break;
            
        case UIGestureRecognizerStateEnded: {
            [UIView animateWithDuration:0.25 animations:^{
                if ([self.transitionCoordinator isCancelled]) {
                    self.animateView.alpha = 1;
                } else {
                    self.animateView.alpha = 0;
                }
            } completion:^(BOOL finished) {
                if ([self.transitionCoordinator isCancelled]) {
                    [self el_configNavigationBarStyleWithViewController:fromVc];
                } else {
                    [self el_configNavigationBarStyleWithViewController:toVc];
                }
            }];
            [self.animateView removeFromSuperview];
            self.animateView = nil;
        }
            break;
        default:
            break;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [navigationController setNavigationBarHidden:viewController.el_navHidden animated:animated];
    if (self.interactivePopGestureRecognizer.state == UIGestureRecognizerStatePossible) {
        [self el_configNavigationBarStyleWithViewController:viewController];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES ) {
        self.interactivePopGestureRecognizer.enabled = viewController.el_interactivePopGestureEnable;
    }
}

- (void)el_configNavigationBarStyleWithViewController:(UIViewController *)viewController {
    if (!viewController) {
        return;
    }
    if (viewController.el_navigationBarTintColor) {
        NSMutableDictionary *att = [NSMutableDictionary dictionary];
        att[NSFontAttributeName] = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
        att[NSForegroundColorAttributeName] = viewController.el_navigationBarTintColor;
        [self.navigationBar setTitleTextAttributes:att];
        self.navigationBar.tintColor = viewController.el_navigationBarTintColor;
    }
    self.navigationBar.el_navTransitionView.image = viewController.el_navigationBarBackgroundImage;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.el_navTransitionView.alpha = MAX(0, MIN(1, viewController.el_navBackgroundAlpha));
    
    if (@available(iOS 13.0, *)) {
        [self.navigationBar.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            self.navigationBar.subviews.firstObject.subviews.firstObject.backgroundColor = viewController.el_navBottomLineColor ?:[UIColor clearColor];
        }];
    }
    [self.navigationBar setShadowImage:[self imageWithColor:viewController.el_navBottomLineColor ?: [UIColor clearColor] ]];
    if (@available(iOS 11.0, *)) {
        if (viewController.el_prefersLargeTitles) {
            if (@available(iOS 13.0, *)) {
                
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.navigationBar.el_navTransitionView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), SafeAreaNavHeight);
}

/**
 * 将UIColor变换为UIImage
 **/
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
