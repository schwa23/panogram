//
//  PanoPostingViewController.m
//  panogram
//
//  Created by Joshua Dickens on 3/19/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import "PanoPostingViewController.h"

@interface PanoPostingViewController ()
@property (nonatomic, strong) UIScrollView *previousScrollView;

@end

@implementation PanoPostingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithScrollView:(UIScrollView *)scrollView {
    
    self = [super init];
    
    if(self) {
        
        self.previousScrollView = scrollView;
    }
    
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.panoScrollView = self.previousScrollView;
    self.previousScrollView = nil;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
