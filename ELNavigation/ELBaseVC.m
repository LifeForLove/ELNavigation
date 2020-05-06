//
//  ELBaseVC.m
//  ELNavigation
//
//  Created by ZCGC on 2019/8/1.
//  Copyright © 2019 getElementByYou. All rights reserved.
//

#import "ELBaseVC.h"
#import "UINavigationBar+ELExtension.h"
#import "UIViewController+ELExtension.h"

@interface ELBaseVC ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) id navTransitionTempDelegate;

@end

@implementation ELBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.el_navigationBarBackgroundImage = [self imageWithColor:[UIColor colorWithRed:203/255.f green:43/255.f blue:41/255.f alpha:1]];
    self.el_navBackgroundAlpha = 1;
    self.el_navigationBarTintColor = [UIColor blackColor];
    self.el_interactivePopGestureEnable = YES;
    self.el_navBottomLineColor = nil;
    [self el_configNavigationStyle];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (self.el_navHidden) {
        self.navTransitionTempDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    if (@available(iOS 11.0, *)) {
        if (self.el_prefersLargeTitles) {
//            self.navigationController.navigationBar.prefersLargeTitles = YES;
        }
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.el_navHidden) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self.navTransitionTempDelegate;
    }
    
    if (@available(iOS 11.0, *)) {
        if (self.el_prefersLargeTitles) {
            self.navigationController.navigationBar.prefersLargeTitles = NO;
        }
    }
}

- (void)el_configNavigationStyle {}

/**
 * 将UIColor变换为UIImage
 *
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
