//
//  FirstViewController.m
//  SimpleSlideView
//
//  Created by Mon on 5/22/16.
//  Copyright © 2016 YYYeung. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "UIViewController+CustomPresentTransition.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100.f, 100.f, 200.f, 40.f);
    [btn setTitle:@"Push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    self.title = NSStringFromClass([self class]);
    
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)action{
    CGFloat width = 300.f;
    SecondViewController *ctrl = [[SecondViewController alloc] init];
    ctrl.WYYDrawerWidth = width;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ctrl];
    PresentAnimator *presentAnimator = [[PresentAnimator alloc] initWithAnimationDuration:0.3f modalTransitionAction:ModalTransitionActionNone modalTransitionDirection:ModalTransitionFromDirectionRight toViewControllerWidth:width];
    nc.animator = presentAnimator;
    
    // Make first view controller can be seen
    nc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:nc animated:YES completion:nil];
}

@end
