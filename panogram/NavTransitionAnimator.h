//
//  NavTransitionAnimator.h
//  panogram
//
//  Created by Joshua Dickens on 3/28/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import "TransitionAnimator.h"

@interface NavTransitionAnimator : TransitionAnimator

@property (nonatomic, strong) UIScrollView* panoScrollView;
@property (nonatomic, assign) UINavigationControllerOperation operation;

@end
