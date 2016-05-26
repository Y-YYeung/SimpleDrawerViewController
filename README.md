# README

## A simple drawer view controller implementation

### What's in there

This drawer view controller implementation implements a side slipping effect of a view controller.

This side splipping effect is based on view controller's modal presentation, with custom view controller transition.

In the folder of WYYSimpleDrawerViewController, there are the files that support this side slipping effect.

`PresentAnimator` class, implements the `UIViewControllerAnimatedTransitioning` protocol.

`UIViewController+CustomPresentTransition`, implements the `UIViewControllerTransitioningDelegate` protocol and a custom protocol `PresentAnimatorDelegate`.

`UIViewController+Drawer`, associates an additional property called `WYYDrawerWidth`, which will controls the width of the drawer view controller. 

### How to use

Let's assume that, we will present a drawer view controller called B on the view controller called A, it's fine no matter B is a simple view controller or a navigation view controller.
Then:

1. In A.m file, besides `#import` the B.h file, please `#import` the `UIViewController+CustomPresentTransition.h` file too, which includes the `PresentAnimator.h` file.
2. In B.h file, `#import` the `UIViewController+Drawer.h` file, in which, we associates a `WYYDrawerWidth` property to configure the width of our drawer view controller's view.
3. Get back to A.m file, 
	- Here, in the method which you will create B and present B as a drawer, as you want, create an instance of B, and configure the associated property `WYYDrawerWidth` to whatever proper value you want. 
	- Then, create an instance of `PresentAnimator`, using the initializer `initWithAnimationDuration:modalTransitionAction:modalTransitionDirection: toViewControllerWidth:`.
	- Pass the instance of `PresentAnimator` to the property `animator` of A, or `animator` of a navigation controller if you would like to embed A in a navigation controller.
	- To make sure the effect covers the whole screen, set the property `modalPresentationStyle` of A or navigation controller to `UIModalPresentationOverFullScreen`.

```objc
CGFloat width = 300.f;
SecondViewController *ctrl = [[SecondViewController alloc] init];
ctrl.WYYDrawerWidth = width;
UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:ctrl];
PresentAnimator *presentAnimator = [[PresentAnimator alloc] initWithAnimationDuration:0.3f modalTransitionAction:ModalTransitionActionNone modalTransitionDirection:ModalTransitionFromDirectionRight toViewControllerWidth:width];
nc.animator = presentAnimator;
    
// Make first view controller can be seen
nc.modalPresentationStyle = UIModalPresentationOverFullScreen;
[self presentViewController:nc animated:YES completion:nil];
```

4. Back to B.h, to make sure the width of the view of B equals to `WYYDrawerWidth` we just set, we need to override the method `- (void)loadView` like:

```objc
- (void)loadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.WYYDrawerWidth, CGRectGetHeight([UIScreen mainScreen].bounds))];
    self.view = view;
}
```

P.S The reason to override `- (void)loadView` is: we may setup some views based on the frame of the view of view controller. Actually, maybe we do not need to override the method. For example, if we have a table view in B, we can set the property `autoresizingMask` of table view to match the frame, such as `self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;`.


