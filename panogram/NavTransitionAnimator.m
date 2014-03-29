//
//  NavTransitionAnimator.m
//  panogram
//
//  Created by Joshua Dickens on 3/28/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import "NavTransitionAnimator.h"

@implementation NavTransitionAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect inFrame = fromViewController.view.frame;
    
    CGRect rightFrame = inFrame;
    rightFrame.origin.x = inFrame.origin.x + inFrame.size.width;
    
    CGRect leftFrame  = inFrame;
    leftFrame.origin.x = inFrame.origin.x - inFrame.size.width;
    
    toViewController.view.frame = (self.operation == UINavigationControllerOperationPush) ? rightFrame:leftFrame;
    
    fromViewController.view.alpha=1;
    toViewController.view.alpha=0;
    
    [containerView addSubview:toViewController.view];
    
    [containerView addSubview:self.panoScrollView];
    self.transitionDuration = .35;
   
    CGRect barFrame = fromViewController.navigationController.navigationBar.frame;
    barFrame.origin.x = barFrame.origin.x - 320;
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        toViewController.view.frame = inFrame;
        fromViewController.view.frame =  (self.operation == UINavigationControllerOperationPush) ? leftFrame:rightFrame;
        fromViewController.view.alpha=0;
        toViewController.view.alpha=1;
//        fromViewController.navigationController.navigationBar.frame = barFrame;
        
    } completion:^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [toViewController.view addSubview:self.panoScrollView];
        [transitionContext completeTransition:YES];
    }];
}


@end

