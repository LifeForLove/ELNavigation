# ELNavigation

#### 效果图


#### 介绍
导航栏转场方案

#### 软件架构
软件架构说明

#### 代码说明

1. 在 - (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated 方法中，设置控制器的导航栏状态。
2. 为返回手势添加事件，获取返回手势进度，增加过渡效果 [self.interactivePopGestureRecognizer addTarget:self action:@selector(interactivePopGes:)]; 

#### 使用说明

1 需继承 ELNavigationController 导航控制器
2 继承 ELBaseVC 控制器
3 在控制器中设置对应属性即可

```
/// 是否隐藏导航栏 
@property (nonatomic, assign) BOOL el_navHidden;

/// 导航栏文字颜色 
@property (nonatomic, strong) UIColor * el_navigationBarTintColor;

/// 导航栏背景颜色/图片 
@property (nonatomic, strong) UIImage * el_navigationBarBackgroundImage;

/// 是否开启largeTitle
@property (nonatomic, assign) BOOL el_prefersLargeTitles;

/// 导航栏背景颜色透明度
@property (nonatomic, assign) CGFloat el_navBackgroundAlpha;

/// 手势返回是否禁用 
@property (nonatomic, assign) BOOL el_interactivePopGestureEnable;

/// 导航栏底部线条颜色 
@property (nonatomic,strong,nullable) UIColor *el_navBottomLineColor;
```



