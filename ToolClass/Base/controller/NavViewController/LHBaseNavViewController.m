//
//  LHBaseNavViewController.m
//  ToolClass
//
//  Created by lx on 16/12/22.
//  Copyright © 2016年 lx. All rights reserved.
//

#import "LHBaseNavViewController.h"
#import "NavigationInteactiveTransition.h"

@interface LHBaseNavViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) NavigationInteactiveTransition *navTransition;

@end

@implementation LHBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *panPopGes = [[UIPanGestureRecognizer alloc] init];
    panPopGes.delegate = self;
    panPopGes.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:panPopGes];
    

    
/*
    方案一
 */
    _navTransition = [[NavigationInteactiveTransition alloc] initWithViewController:self];
    [panPopGes addTarget:_navTransition action:@selector(popViewControllerPan:)];
    
    /*
     方案二
     */
//    //获取系统手势的target数组
//    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
//    
//    //获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
//    id gestureTarget = [_targets firstObject];
//    
//    //获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
//    
//    id navigationInteractiveTransition = [gestureTarget valueForKey:@"_target"];
//    
//    
//    //通过前面的打印，我们从控制台获取出来它的方法签名。
//    
//    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
//    
//    //创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
//    
//    [panPopGes addTarget:navigationInteractiveTransition action:handleTransition];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
    return self.viewControllers.count != 1&& ![[self valueForKey:@"_isTransitioning"] boolValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
