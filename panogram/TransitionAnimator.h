//
//  TransitionAnimator.h
//  transitions
//
//  Created by Timothy Lee on 3/13/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransitionAnimator : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) float transitionDuration;
@property (nonatomic, assign) BOOL interactive;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;
@property (nonatomic, strong) UIImage* transitionImage;

@end
