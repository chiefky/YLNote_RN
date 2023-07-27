//
//  YLVCLifeCycleController.m
//  
//
//  Created by tangh on 2023/7/21.
//

#import "YLVCLifeCycleController.h"

@interface YLVCLifeCycleController ()

@end

@implementation YLVCLifeCycleController

/// 通过纯代码实例化Vc会调用，其最终会调用initWithNibName:bundle:方法
- (instancetype)init {
    NSLog(@"%s",__FUNCTION__);
    self = [super init];
    return self;
}

/// 通过xib文件或者init方法实例化的vc，这个方法都会被调用，其实init方法最终都会走该方法
/// - Parameters:
///   - nibNameOrNil:
///   - nibBundleOrNil:
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"%s",__FUNCTION__);
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

/// 通过storyBoard方式实例化的vc，需要经过反序列化，这个方法会被调用
/// - Parameter coder: <#coder description#>
- (instancetype)initWithCoder:(NSCoder *)coder {
    
    NSLog(@"%s",__FUNCTION__);
    self = [super initWithCoder:coder];
    return self;
}

/// 加载视图控制器的视图层次结构。
/// 可以手动创建视图并将其分配给视图控制器的view属性。
- (void)loadView {
    [super loadView];
    NSLog(@"%s",__FUNCTION__);
}

/// 视图控制器的视图已经加载到内存中，并完成了初始设置。
/// 这是进行进一步的视图初始化、数据加载或其他一次性设置的好时机。
/// 注意，该方法只会在第一次加载视图时调用，之后再次显示时不会再次调用。
- (void)viewDidLoad {
    NSLog(@"%s",__FUNCTION__);
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemPinkColor];
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:butn];
    butn.frame = CGRectMake(100, 100, 100, 50);
    [butn setTitle:@"下一页" forState:UIControlStateNormal];
    [butn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAction {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor systemCyanColor];
    [self.navigationController pushViewController:vc animated:YES];
}

/// 视图即将显示在屏幕上，但尚未完全可见。
/// 此时可以执行一些准备工作，如数据更新或界面调整等。
/// - Parameter animated:
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__FUNCTION__);
}

- (void)loadViewIfNeeded {
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewLayoutMarginsDidChange {
    [super viewLayoutMarginsDidChange];
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    NSLog(@"%s",__FUNCTION__);
}

/// 根视图将要布局其子视图时调用的方法，可以在其中更新布局属性、样式，或者进行数据刷新等操作。
/// 当应用程序的界面发生变化时，例如设备方向改变、屏幕大小调整等，系统会触发布局过程，这时会调用该方法。
/// 在该方法中，你可以执行一些准备工作，或者更新视图的约束和布局属性。
/// 它通常被用来在视图发生变化前做一些预处理操作。
/// 以下是一些常见的使用场景：
/// 更新视图布局：当视图控制器的根视图需要重新布局其子视图时，你可以在 viewWillLayoutSubviews() 方法中更新相关的布局属性，例如修改子视图的约束、计算视图的位置和大小等。
/// 调整子视图的样式：如果你希望在每次布局之前对子视图进行样式调整，可以在这个方法中进行相应的操作，例如更改字体、颜色、背景等。
/// 更新数据源：有时候，在视图布局之前可能需要更新数据源，以确保布局所依赖的数据是最新的。你可以在 viewWillLayoutSubviews() 方法中进行数据的刷新或重载。
/// 需要注意的是，由于该方法可能会多次调用（例如在动画过程中），所以在实现时要注意避免执行耗时的操作或引起性能问题的代码。较为复杂的布局计算可以转移到 viewDidLayoutSubviews() 方法中完成。
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"%s",__FUNCTION__);
}
/// 根视图完成布局其子视图后被调用的方法，可以在其中执行与布局相关的操作。
/// 例如更新视图的约束、计算视图的位置和大小等。它通常被用来处理那些需要在布局完成后才能进行的任务。
/// 以下是一些常见的使用场景：
/// 更新视图布局：当视图控制器的根视图完成了布局操作，你可以在 viewDidLayoutSubviews() 方法中对子视图的位置、大小或布局属性进行最终的调整。
/// 处理视图动画：如果你希望在视图布局完成后执行一些动画效果，例如改变视图的透明度、移动或缩放视图等，可以在这个方法中添加相应的代码。
/// 调整视图层次结构：有时候，在视图布局完成后，你可能需要重新调整视图层次结构，例如将某个视图移到最前面或最后面。你可以在 viewDidLayoutSubviews() 方法中执行相关的操作。
/// 需要注意的是，由于该方法会在每次布局完成后被调用，所以在实现时要注意避免执行耗时的操作或引起性能问题的代码。
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%s",__FUNCTION__);
}


/// 视图已经完全显示在屏幕上，并且用户可以与之交互。
/// 通常在此处执行启动动画、网络请求或其他耗时操作。
/// - Parameter animated:
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s",__FUNCTION__);
}

/// 视图即将从屏幕上消失。
/// 可以在此处执行一些清理工作，如取消网络请求、保存数据等。
/// - Parameter animated:
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%s",__FUNCTION__);
}

/// 视图已经完全从屏幕上消失。
/// 可以在此处执行一些额外的清理工作
/// - Parameter animated:
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"%s",__FUNCTION__);
}

/// 加载视图时，内存消耗太大，出现内存警告，会调用
- (void)didReceiveMemoryWarning {
    
}

/// 当视图控制器对象被释放时调用的析构函数。
/// 可以在此处执行一些最后的清理操作。
- (void)dealloc {
    
    NSLog(@"%s",__FUNCTION__);
}
@end
