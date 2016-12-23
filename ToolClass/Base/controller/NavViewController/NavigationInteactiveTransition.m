//
//  NavigationInteactiveTransition.m
//  ToolClass
//
//  Created by lx on 16/12/22.
//  Copyright © 2016年 lx. All rights reserved.
//

#import "NavigationInteactiveTransition.h"
#import "FuLLPopAnimation.h"


@interface NavigationInteactiveTransition()<UINavigationControllerDelegate>
@property (weak ,nonatomic) UINavigationController *nav;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactivePopTransition;


@end


@implementation NavigationInteactiveTransition

- (instancetype)initWithViewController:(UIViewController *)vc{
    self = [super init];
    if (self) {
        self.nav = (UINavigationController *)vc;
        self.nav.delegate = self;
    }
    return self;
}



/**
 把用户的pan的手势，转化为pop动画执行

 @param ges ges 手势的对象
 */
- (void)popViewControllerPan:(UIPanGestureRecognizer *)ges{
    
    /*
     获取滑动的比例
     */
    CGFloat prograss = [ges translationInView:ges.view].x/ges.view.bounds.size.width;
    prograss = MIN(1.0, MAX(0.0, prograss));
    
    if (ges.state == UIGestureRecognizerStateBegan) {
        //手势开始状态，新建一个监控对象
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.nav popViewControllerAnimated:YES];
    }else if (ges.state == UIGestureRecognizerStateChanged){
        //更新手势的完成的进度
        [self.interactivePopTransition updateInteractiveTransition:prograss];
    }else if (ges.state == UIGestureRecognizerStateEnded|| ges.state == UIGestureRecognizerStateCancelled){
        
        if (prograss > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        }else{
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    //判定是否是自定义的返回的动画
    if ([animationController isKindOfClass:[FuLLPopAnimation class]]) {
        return self.interactivePopTransition;
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    //判断如果执行当前的是pop操作，就返回我们的自定义的pop动画对象
    if (operation == UINavigationControllerOperationPop) {
        return [[FuLLPopAnimation alloc] init];
    }
    return nil;
}


@end
