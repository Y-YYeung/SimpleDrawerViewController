//
//  UIViewController+CustomPresentTransition.m
//  SimpleSlideView
//
//  Created by Mon on 5/22/16.
//  Copyright © 2016 YYYeung. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+CustomPresentTransition.h"

@implementation UIViewController (CustomPresentTransition)

@dynamic animator;

#pragma mark - Accessors

- (void)setAnimator:(id<UIViewControllerAnimatedTransitioning>)animator{
    self.transitioningDelegate = self;
    objc_setAssociatedObject(self, @selector(animator), animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UIViewControllerAnimatedTransitioning>)animator{
    return objc_getAssociatedObject(self, @selector(animator));
}

#pragma mark - Delagate Methods
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.animator.transitionAction = ModalTransitionActionPresent;
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.animator.transitionAction = ModalTransitionActionDismiss;
    return self.animator;
}

- (void)WYYDismissController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
