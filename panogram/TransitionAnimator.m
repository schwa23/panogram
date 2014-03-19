//
//  TransitionAnimator.m
//  transitions
//
//  Created by Timothy Lee on 3/13/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "TransitionAnimator.h"
#import "PanoCell.h"
#import "PanoTableViewController.h"
#import "PanoDetailViewController.h"

@interface TransitionAnimator ()

@property (nonatomic, assign) BOOL presenting;


@end

@implementation TransitionAnimator

- (id)init {
    self = [super init];
    if (self) {
        self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        self.interactive = NO;
        self.transitionDuration = 2;
    }
    return self;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.presenting = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presenting = NO;
    return self;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (self.interactive && self.presenting) {
        return self.interactiveTransition;
    } else {
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (self.interactive && self.presenting) {
        return self.interactiveTransition;
    } else {
        return nil;
    }
}

#pragma mark - UIViewControllerAnimatedTransitioning methods

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    UINavigationController *detailViewController;
    UINavigationController *mainNavController;
   
    PanoTableViewController *tableViewController;
    PanoDetailViewController *panoVC;
    
    if (self.presenting)
    {
        detailViewController = (UINavigationController *) toViewController;
        mainNavController = (UINavigationController *) fromViewController;
        
        tableViewController = mainNavController.viewControllers[0];
        panoVC = detailViewController.viewControllers[0];


        
//        [detailViewController setNavigationBarHidden:YES animated:NO];
        detailViewController.view.alpha = 0;
        
        [containerView addSubview:detailViewController.view];

        CGRect sourceFrame = tableViewController.selectedFrame;
        
        sourceFrame.size.height = 88; //force the height on the image view, since the cell actually has padding
        
        CGFloat width = self.transitionImage.size.width / self.transitionImage.size.height * 320;
      
        CGRect destinationFrame = CGRectMake(0, 64, width, 320);
        
        
        
        UIImageView *transitionImage = [[UIImageView alloc] initWithFrame:sourceFrame];
        transitionImage.image = self.transitionImage;
        transitionImage.clipsToBounds = YES;
        transitionImage.contentMode = UIViewContentModeScaleAspectFill;
        [containerView addSubview:transitionImage];
        
        
        
        
        
        
        [UIView animateWithDuration:.35 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:1.5 options:0  animations:^{
            transitionImage.frame = destinationFrame;
            detailViewController.view.alpha = 1;
            mainNavController.view.alpha = 0;

            
        } completion:^(BOOL finished) {
            [transitionImage removeFromSuperview];
            
            [transitionContext completeTransition:YES];
            [mainNavController.view removeFromSuperview];
            
        }];
        
        
    } else {
        toViewController.view.alpha = 1;
        [fromViewController.view removeFromSuperview];
        [containerView addSubview:toViewController.view];
        [toViewController viewWillAppear:YES];

        [transitionContext completeTransition:YES];
        [containerView removeFromSuperview];


    }
}

@end
