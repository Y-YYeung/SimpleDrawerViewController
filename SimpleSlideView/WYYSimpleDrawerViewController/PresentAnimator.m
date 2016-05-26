//
//  PresentAnimator.m
//  test
//
//  Created by Mon on 5/21/16.
//  Copyright © 2016 YYYeung. All rights reserved.
//

#import "PresentAnimator.h"

@interface PresentAnimator ()

@end

@implementation PresentAnimator

- (instancetype)initWithAnimationDuration:(NSTimeInterval)duration modalTransitionAction:(ModalTransitionAction)transitionAction modalTransitionDirection:(ModalTransitionFromDirection)fromDirection toViewControllerWidth:(CGFloat)width{
    self = [super init];
    
    if (self) {
        _animationDuration = duration;
        _transitionAction = transitionAction;
        _toViewControllerWidth = width;
        _transitionFromDirection = fromDirection;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.animationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (self.transitionAction) {
        case ModalTransitionActionNone:
        case ModalTransitionActionPresent:
            [self presentWithTransitionContext:transitionContext];
            break;
        case ModalTransitionActionDismiss:
            [self dismissWithTransitionContext:transitionContext];
            break;
    }
}

- (void)presentWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    // Get the view controller to be presented
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Limit the size and the initial position of the view controller to be presented
    CGFloat startOriginX = 0.f;
    
    // 1 if from the left, -1 if from the right
    int direction = 0;
    switch (self.transitionFromDirection) {
        case ModalTransitionFromDirectionNone:
        case ModalTransitionFromDirectionLeft:
            startOriginX = CGRectGetMinX([UIScreen mainScreen].bounds) - self.toViewControllerWidth;
            direction = 1;
            break;
        case ModalTransitionFromDirectionRight:
            startOriginX = CGRectGetMaxX([UIScreen mainScreen].bounds);
            direction = -1;
            break;
    }
    
    toVC.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    
    // Change the origin position of toVC
    CGRect frame = toVC.view.frame;
    frame.origin.x = startOriginX;
    frame.size.width = self.toViewControllerWidth;
    toVC.view.frame = frame;
//    toVC.view.transform = CGAffineTransformMakeScale(self.toViewControllerWidth / CGRectGetWidth([UIScreen mainScreen].bounds), 1);
    UIView *containerView = [transitionContext containerView];
    
    // Put a mask on containter view to dismiss
    UIView *maskView = [[UIView alloc] initWithFrame:containerView.bounds];
    maskView.backgroundColor = [UIColor colorWithWhite:0.6f alpha:0.6f];
    [containerView addSubview:maskView];
    
    // Make the container to be gray and transparent
    [containerView addSubview:toVC.view];
    
//    CGAffineTransform translate = CGAffineTransformMakeTranslation(direction * self.toViewControllerWidth, 0);
//    CGAffineTransform scale = CGAffineTransformMakeScale(self.toViewControllerWidth / CGRectGetWidth([UIScreen mainScreen].bounds), 1);
    
    // Present animation
    [UIView animateWithDuration:self.animationDuration animations:^{
        toVC.view.transform = CGAffineTransformMakeTranslation(direction * self.toViewControllerWidth, 0);
//        toVC.view.transform = CGAffineTransformConcat(scale, translate);
    } completion:^(BOOL finished) {
        if (finished) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
            UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:toVC action:@selector(WYYDismissController)];
#pragma clang diagnostic pop
            [maskView addGestureRecognizer:dismissTap];
        }
        [transitionContext completeTransition:YES];
    }];
}

- (void)dismissWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    // Get the view controller to dismiss
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
//    CGFloat startOriginX = 0.f;
//    CGFloat endOriginX = 0.f;
//    switch (self.transitionFromDirection) {
//        case ModalTransitionFromDirectionNone:
//        case ModalTransitionFromDirectionLeft:
//            endOriginX = CGRectGetMinX([UIScreen mainScreen].bounds) - self.toViewControllerWidth;
//            break;
//        case ModalTransitionFromDirectionRight:
//            endOriginX = CGRectGetMaxX([UIScreen mainScreen].bounds) + self.toViewControllerWidth;
//            break;
//    }
//    
//    CGFloat y = 0;
//    CGFloat width = self.toViewControllerWidth;
//    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    // Dismiss animation
    [UIView animateWithDuration:self.animationDuration animations:^{
        fromVC.view.transform = CGAffineTransformIdentity;
//        fromVC.view.frame = CGRectMake(endOriginX, y, width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}

@end
