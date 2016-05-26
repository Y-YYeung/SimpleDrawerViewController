//
//  UIViewController+Drawer.m
//  SimpleSlideView
//
//  Created by Mon on 5/25/16.
//  Copyright © 2016 YYYeung. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+Drawer.h"

@implementation UIViewController (Drawer)

@dynamic WYYDrawerWidth;

- (void)setWYYDrawerWidth:(CGFloat)WYYDrawerWidth{
    objc_setAssociatedObject(self, @selector(WYYDrawerWidth), @(WYYDrawerWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)WYYDrawerWidth{
    NSNumber *width =  objc_getAssociatedObject(self, @selector(WYYDrawerWidth));
    return [width floatValue];
}

@end
