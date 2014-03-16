//
//  MainNavController.m
//  panogram
//
//  Created by Joshua Dickens on 3/15/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import "MainNavController.h"
#import "PanoTableViewController.h"

@interface MainNavController ()

-(void)handleImport:(id) sender;

@end

@implementation MainNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    PanoTableViewController *panotv = [[PanoTableViewController alloc] init];
    [self setViewControllers:@[panotv]];
    
//    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    self.navigationBar.translucent = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark -- Custom methods

-(void)handleImport:(id) sender {
    //doo some stuff here
}

@end
