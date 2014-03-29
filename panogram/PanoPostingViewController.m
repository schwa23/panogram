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
    NSLog(@"Panoscrollview = %@", self.panoScrollView);

    
    [self showDefaultNavItems];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewDidAppear:(BOOL)animated {
    [self.view addSubview:self.panoScrollView];
    self.previousScrollView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showDefaultNavItems {
    
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow" ] style:UIBarButtonItemStylePlain target:self action:@selector(handleBack:)] animated: YES];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftItemsSupplementBackButton = NO;
    
    self.title = @"POST TO INSTAGRAM";

    
}

-(void) handleBack: (id)sender {

    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
