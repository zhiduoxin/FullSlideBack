//
//  FuLLPopAnimation.m
//  ToolClass
//
//  Created by lx on 16/12/22.
//  Copyright © 2016年 lx. All rights reserved.
//

#import "FuLLPopAnimation.h"


@interface FuLLPopAnimation ()

@property (strong, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation FuLLPopAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    
    //动画执行的时间
    return 0.3;
}

/*
    transitionContext你可以看作是一个工具，用来获取一系列动画执行相关的对象，并且通知系统动画是否完成等功能。
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    
    //获取动画来自哪个控制器
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //获取转场动画到哪个控制器
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 转场动画是两个控制器视图时间的动画，需要一个containerView来作为一个“舞台”，让动画执行。
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    //动画执行的时间
    NSTimeInterval timeInterVal = [self transitionDuration:transitionContext];
    
    //动画执行的使fromVC移动的屏幕的右侧
    [UIView animateWithDuration:timeInterVal animations:^{
        fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
    } completion:^(BOOL finished) {
        //当你的动画执行完成，这个方法必须要调用，否则系统会认为你的其余任何操作都在动画执行过程中。
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

}

@end
