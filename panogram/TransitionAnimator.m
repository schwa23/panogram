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
    
    
    UINavigationController *detailViewController = self.presenting ?  (UINavigationController *) toViewController :(UINavigationController *) fromViewController;
    UINavigationController *mainNavController = self.presenting ?     (UINavigationController *) fromViewController : (UINavigationController *) toViewController;

   
    PanoTableViewController *tableViewController = mainNavController.viewControllers[0];
    PanoDetailViewController *panoVC = detailViewController.viewControllers[0];

    
    NSLog(@"image? %@", self.transitionImage);
    
    if (self.presenting)
    {
        
        detailViewController.view.alpha = 0;
        
        [containerView addSubview:detailViewController.view];

        CGRect tableCellFrame = tableViewController.selectedFrame;
        tableCellFrame.size.height = 88; //force the height on the image view, since the cell actually has padding
        
        CGFloat width = self.transitionImage.size.width / self.transitionImage.size.height * 320;
        CGRect fullImageFrame = CGRectMake(0, 64, width, 320);
        
        
        
        UIImageView *transitionImage = [[UIImageView alloc] initWithFrame:tableCellFrame];
        transitionImage.image = self.transitionImage;
        transitionImage.clipsToBounds = YES;
        transitionImage.contentMode = UIViewContentModeScaleAspectFill;
        [containerView addSubview:transitionImage];
        
        
        [UIView animateWithDuration:.4 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:1.5 options:0  animations:^{
            transitionImage.frame = fullImageFrame;
            detailViewController.view.alpha = 1;
            mainNavController.view.alpha = 0;
            mainNavController.view.transform = CGAffineTransformMakeScale(.9, .9);

            
        } completion:^(BOOL finished) {
            [transitionImage removeFromSuperview];
            [mainNavController.view removeFromSuperview];
            
            [transitionContext completeTransition:YES];
            
        }];
        
        
    } else {
        
        detailViewController = (UINavigationController *) fromViewController;
        mainNavController = (UINavigationController *) toViewController;
        
        tableViewController = mainNavController.viewControllers[0];
        panoVC = detailViewController.viewControllers[0];
        
        
        [containerView insertSubview:mainNavController.view atIndex:0];

        
        CGFloat width = self.transitionImage.size.width / self.transitionImage.size.height * 320;
        NSLog(@"width: %f", width);
        CGRect sourceFrame = CGRectMake(-panoVC.currentOffset.x, 64, width, 320);
        
        CGRect destinationFrame = tableViewController.selectedFrame;
        destinationFrame.size.height = 88; //force the height on the image view, since the cell actually has padding
        
       
        
        UIImageView *transitionImage = [[UIImageView alloc] initWithFrame:sourceFrame];
        transitionImage.image = self.transitionImage;
        transitionImage.clipsToBounds = YES;
        transitionImage.contentMode = UIViewContentModeScaleAspectFill;
        
        [containerView addSubview:transitionImage];
        
        mainNavController.view.transform = CGAffineTransformMakeScale(.9, .9);

        
        [UIView animateWithDuration:.35 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:1.5 options:0 animations:^{
            mainNavController.view.alpha = 1;
            detailViewController.view.alpha = 0;
            toViewController.view.transform = CGAffineTransformMakeScale(1, 1);
            transitionImage.frame = destinationFrame;
            panoVC.panoScrollView.hidden=YES;

            
        } completion:^(BOOL finished) {
            [detailViewController.view removeFromSuperview];
         
//            [mainNavController viewWillAppear:YES];
            
            [transitionImage removeFromSuperview];
            
            [transitionContext completeTransition:YES];
        }];
       
        


    }
}

@end
