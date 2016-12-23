//
//  NavigationInteactiveTransition.h
//  ToolClass
//
//  Created by lx on 16/12/22.
//  Copyright © 2016年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NavigationInteactiveTransition : NSObject<UINavigationControllerDelegate>

- (instancetype)initWithViewController:(UIViewController *)vc;
- (void)popViewControllerPan:(UIGestureRecognizer *)ges;

@end
