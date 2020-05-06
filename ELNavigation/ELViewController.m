//
//  ELViewController.m
//  ELNavigation
//
//  Created by ZCGC on 2019/8/1.
//  Copyright © 2019 getElementByYou. All rights reserved.
//

#import "ELViewController.h"
#import "UIViewController+ELExtension.h"
#import "UINavigationBar+ELExtension.h"
#import "ELNanStateConfigCell.h"
@interface ELViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray * infoArr;

@property (nonatomic,strong) UIView *footView;

@property (nonatomic,weak) UITableView *tableView;

@end

@implementation ELViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导航栏";
    
    self.infoArr = @[@"导航栏颜色",
                     @"导航栏图片",
                     @"largeTitle",
                     @"导航栏渐变",
                     @"隐藏导航栏",
                     @"返回手势是否禁用",
                     @"导航栏底部线条颜色",
                     @"导航栏标题颜色修改"
                     ];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.contentInset = UIEdgeInsetsMake(0, 0, self.view.bounds.size.height/2, 0);
    [tableView registerNib:[UINib nibWithNibName:@"ELNanStateConfigCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    tableView.backgroundColor = self.view.backgroundColor;
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:tableView];
    tableView.tableFooterView = self.footView;
}

- (void)el_configNavigationStyle {
    
    ///导航栏背景颜色或者图片 设置
    if (self.configModel.navImgSelect) {
        self.el_navigationBarBackgroundImage = [UIImage imageNamed:@"imageNav"];
    } else {
        self.el_navigationBarBackgroundImage = [self imageWithColor:self.configModel.navColor ? : [UIColor colorWithRed:203/255.f green:43/255.f blue:41/255.f alpha:1]];
    }
    
    /// largeTitle
    self.el_prefersLargeTitles = self.configModel.largeTitleSelect;
    
    ///导航栏渐变
    if (self.configModel.gradualChangeColorSelect) {
        self.el_navBackgroundAlpha = 0;
    }
    
    /// 导航栏文字颜色修改
    if (self.configModel.navTintColor) {
        self.el_navigationBarTintColor = self.configModel.navTintColor;
    } else {
        self.el_navigationBarTintColor = [UIColor blackColor];
    }
    
    /// 导航栏文字颜色修改
    if (self.configModel.navBottomLineColor) {
        self.el_navBottomLineColor = self.configModel.navBottomLineColor;
    } else {
        self.el_navBottomLineColor = [UIColor clearColor];
    }
    
    /// 导航栏隐藏状态
    self.el_navHidden = self.configModel.hiddenNav;
    
    /// 返回手势是否禁用
    self.el_interactivePopGestureEnable = !self.configModel.popGesEnable;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * title = self.infoArr[indexPath.section];
    ELNanStateConfigCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ([title isEqualToString:@"导航栏颜色"]) {
        cell.switchBtn.on = self.configModel.navColor ? YES : NO;
        __weak typeof(self)weakSelf = self;
        cell.SwitchSelectBlock = ^(BOOL select) {
            if (select) {
                [self selectColorWithBlock:^(UIColor *color) {
                    weakSelf.configModel.navColor = color;
                    [tableView reloadData];
                }];
            }
        };
    } else if ([title isEqualToString:@"largeTitle"]) {
        cell.switchBtn.on = self.configModel.largeTitleSelect;
        cell.SwitchSelectBlock = ^(BOOL select) {
            self.configModel.largeTitleSelect = select;
        };
    } else if ([title isEqualToString:@"导航栏渐变"]) {
        cell.switchBtn.on = self.configModel.gradualChangeColorSelect;
        cell.SwitchSelectBlock = ^(BOOL select) {
            self.configModel.gradualChangeColorSelect = select;
        };
    } else if ([title isEqualToString:@"导航栏图片"]) {
        cell.switchBtn.on = self.configModel.navImgSelect;
        cell.SwitchSelectBlock = ^(BOOL select) {
            self.configModel.navImgSelect = select;
        };
    } else if ([title isEqualToString:@"隐藏导航栏"]) {
        cell.switchBtn.on = self.configModel.hiddenNav;
        cell.SwitchSelectBlock = ^(BOOL select) {
            self.configModel.hiddenNav = select;
        };
    } else if ([title isEqualToString:@"返回手势是否禁用"]) {
        cell.switchBtn.on = self.configModel.popGesEnable;
        cell.SwitchSelectBlock = ^(BOOL select) {
            self.configModel.popGesEnable = select;
        };
    } else if ([title isEqualToString:@"导航栏标题颜色修改"]) {
        cell.switchBtn.on = self.configModel.navTintColor ? YES : NO;
        __weak typeof(self)weakSelf = self;
        cell.SwitchSelectBlock = ^(BOOL select) {
            if (select) {
                [self selectColorWithBlock:^(UIColor *color) {
                    weakSelf.configModel.navTintColor = color;
                    [tableView reloadData];
                }];
            }
        };
    } else if ([title isEqualToString:@"导航栏底部线条颜色"]) {
        cell.switchBtn.on = self.configModel.navBottomLineColor ? YES : NO;
        __weak typeof(self)weakSelf = self;
        cell.SwitchSelectBlock = ^(BOOL select) {
            if (select) {
                [self selectColorWithBlock:^(UIColor *color) {
                    weakSelf.configModel.navBottomLineColor = color;
                    [tableView reloadData];
                }];
            }
        };
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.infoArr[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.infoArr.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.configModel.gradualChangeColorSelect) {
        CGFloat alpha = 1 - (100 - scrollView.contentOffset.y)/100;
        alpha = fmax(0, alpha);
        alpha = fmin(1, alpha);
        self.el_navBackgroundAlpha = alpha;
    }
}

- (UIView *)footView {
    if (_footView == nil) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
        
        UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextBtn setTitle:@"下一个" forState:UIControlStateNormal];
        [nextBtn setBackgroundColor:[UIColor colorWithRed:203/255.f green:43/255.f blue:41/255.f alpha:1]];
        [_footView addSubview:nextBtn];
        nextBtn.frame = CGRectMake(0, 0, 200, 44);
        nextBtn.center = _footView.center;
        [nextBtn addTarget:self action:@selector(nextPush) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}

- (void)selectColorWithBlock:(void (^) (UIColor * color))selectBlock {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"选择颜色" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
    __block UIColor * selectColor;
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        selectBlock(selectColor);
    }];
    
    //红色
    UIAlertAction *redBtn = [UIAlertAction actionWithTitle:@"红色" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
        selectBlock([UIColor redColor]);
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //黄色
    UIAlertAction *yellowBtn = [UIAlertAction actionWithTitle:@"黄色" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
        selectBlock([UIColor yellowColor]);
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //蓝色
    UIAlertAction *blueBtn = [UIAlertAction actionWithTitle:@"蓝色" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
        selectBlock([UIColor blueColor]);
        [alertVc dismissViewControllerAnimated:YES completion:nil];
    }];
   
    //将action添加到控制器
    [alertVc addAction:cancelBtn];
    [alertVc addAction :redBtn];
    [alertVc addAction :yellowBtn];
    [alertVc addAction :blueBtn];
    //展示
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)nextPush {
    ELViewController * vc = [[ELViewController alloc]init];
    vc.configModel = self.configModel;
    [self.navigationController pushViewController:vc animated:YES];
}

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

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (ELNavConfigModel *)configModel {
    if (_configModel == nil) {
        _configModel = [[ELNavConfigModel alloc]init];
    }
    return _configModel;
}

@end

@implementation  ELNavConfigModel

@end
