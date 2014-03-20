//
//  PanoPostingViewController.h
//  panogram
//
//  Created by Joshua Dickens on 3/19/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanoPostingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *panoScrollView;

-(id)initWithScrollView:(UIScrollView *)scrollView;

@end
