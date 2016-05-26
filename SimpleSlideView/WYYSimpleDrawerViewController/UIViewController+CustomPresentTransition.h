//
//  UIViewController+CustomPresentTransition.h
//  SimpleSlideView
//
//  Created by Mon on 5/22/16.
//  Copyright © 2016 YYYeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentAnimator.h"

@interface UIViewController (CustomPresentTransition)<UIViewControllerTransitioningDelegate, PresentAnimatorDelegate>

@property (nonatomic, strong) PresentAnimator *animator;

@end
