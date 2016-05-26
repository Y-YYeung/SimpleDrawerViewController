//
//  PresentAnimator.h
//  test
//
//  Created by Mon on 5/21/16.
//  Copyright © 2016 YYYeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ModalTransitionActionNone,
    ModalTransitionActionPresent,
    ModalTransitionActionDismiss,
} ModalTransitionAction;

typedef enum : NSUInteger {
    ModalTransitionFromDirectionNone,
    ModalTransitionFromDirectionLeft,
    ModalTransitionFromDirectionRight,
} ModalTransitionFromDirection;

@protocol PresentAnimatorDelegate <NSObject>

@required
- (void)WYYDismissController;

@end

@interface PresentAnimator : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  @author YYYeung
 *
 *  @brief The animation duration of the transition
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 *  @author YYYeung
 *
 *  @brief Transition action, which is present or dismiss
 */
@property (nonatomic, assign) ModalTransitionAction transitionAction;

/**
 *  @author YYYeung
 *
 *  @brief Transition direction, which is left or right
 */
@property (nonatomic, assign) ModalTransitionFromDirection transitionFromDirection;

/**
 *  @author YYYeung
 *
 *  @brief The width of the view controller to be presented
 */
@property (nonatomic, assign) CGFloat toViewControllerWidth;

@property (nonatomic, weak) id<PresentAnimatorDelegate> delegate;

/**
 *  @author YYYeung
 *
 *  @brief Initializer
 *
 *  @param duration         The animation of the transition
 *  @param transitionAction Transition action, which is present or dismiss
 *  @param direction        Transition direction, which is left or right
 *  @param width            The width of the view controller to be presented
 *
 *  @return An animator used to transit
 */
- (instancetype)initWithAnimationDuration:(NSTimeInterval)duration modalTransitionAction:(ModalTransitionAction)transitionAction modalTransitionDirection:(ModalTransitionFromDirection)fromDirection toViewControllerWidth:(CGFloat)width;

@end
