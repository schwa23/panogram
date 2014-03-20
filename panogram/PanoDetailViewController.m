//
//  PanoDetailViewController.m
//  panogram
//
//  Created by Joshua Dickens on 3/15/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import "PanoDetailViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "AppDelegate.h"
#import "PanoPostingViewController.h"

@interface PanoDetailViewController ()

@property (strong, nonatomic) ALAssetsLibrary* library;
@property (strong, nonatomic) ALAsset* asset;
@property (strong, nonatomic) UIPanGestureRecognizer* scrollGestureRecognizer;
@property (assign, nonatomic) CGFloat xOffset;
@property (weak, nonatomic) IBOutlet UIButton *panZoomButton;



@property (weak, nonatomic) IBOutlet UIView *positionIndicator;

-(id)initWithPanoImageAsset:(ALAsset*)asset;

-(void)handleBack:(id)sender;
-(void)handleNext:(id)sender;

- (IBAction)handlePanZoomButton:(id)sender;


@end

@implementation PanoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"EDIT";
        

    }
    return self;
}

-(id)initWithPanoImageAsset:(ALAsset*)asset{
    self= [super init];
    if(self) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.library = appDelegate.library;
        
        self.asset = asset;
        self.currentOffset = CGPointMake(0,0);

    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow" ] style:UIBarButtonItemStylePlain target:self action:@selector(handleBack:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftItemsSupplementBackButton = NO;
    
    [UIView animateWithDuration:.35 animations:^{
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }];


}



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //create an image view with the asset from the library and set it up in the scroll view
    UIImage *image;
    
    ALAssetRepresentation *rep = [self.asset defaultRepresentation];
    image = [UIImage imageWithCGImage:[rep fullScreenImage]];
    
    CGFloat width = rep.dimensions.width / rep.dimensions.height * 320;
    CGRect newFrame = CGRectMake(0,0, width ,320);
    
    self.panoImageView.frame = newFrame;
    self.panoImageView.image = image;
    self.panoScrollView.contentSize = newFrame.size;
    
    CGRect indicatorSize = self.positionIndicator.frame;
    indicatorSize.size.width = (320 / width * 320);
    self.positionIndicator.frame = indicatorSize;
    
    self.panoScrollView.hidden=YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"NEXT" style:UIBarButtonItemStylePlain target:self action:@selector(handleNext:)];
}

- (void) viewDidAppear:(BOOL)animated {
    
    self.panoScrollView.hidden = NO;
    
    [UIView animateWithDuration:10 delay:1 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse |UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.panoScrollView setContentOffset:CGPointMake(self.panoScrollView.contentSize.width-320, 0) animated:NO];
        
    } completion:^(BOOL finished) {

        NSLog(@"Content offset = %f", self.panoScrollView.contentOffset.x);
        //finished
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewDidDisappear:(BOOL)animated {
//    [self removeObserver:self forKeyPath:@"panoScrollView.contentOffset"];

}

-(void) viewWillDisappear:(BOOL)animated {
    
    CALayer *currentLayer = self.panoScrollView.layer.presentationLayer;
    
    NSLog(@"x offset: %f", currentLayer.bounds.origin.x);
    
    //remove the animations from the layer of the scroll view & indicator bar
    [self.panoScrollView.layer removeAllAnimations];
    [self.positionIndicator.layer removeAllAnimations];
    
    [self.panoScrollView setContentOffset:currentLayer.bounds.origin animated:NO];

    
    self.currentOffset = currentLayer.bounds.origin;
    
    
}

#pragma mark -- Custom actions

-(void) handleBack: (id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
//        did dismiss
    }];
//    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)handlePanZoomButton:(id)sender {
}

- (void)handleNext:(id) sender {
    PanoPo
    self.navigationController pushViewController:<#(UIViewController *)#> animated:<#(BOOL)#>
}

#pragma mark -- SCroll view delegate methods


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGFloat offsetPct = offset.x / scrollView.contentSize.width;
    
    CGRect newFrame = self.positionIndicator.frame;
    newFrame.origin.x = offsetPct * 320;
    self.positionIndicator.frame = newFrame;
    
    self.currentOffset = scrollView.contentOffset;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.panoImageView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    CGPoint offset = self.panoScrollView.contentOffset;
    
    //get the ca presentation layer to find the scroll view's current position
    CALayer *currentLayer = self.panoScrollView.layer.presentationLayer;
    
    NSLog(@"x offset: %f", currentLayer.bounds.origin.x);
    
    //remove the animations from the layer of the scroll view & indicator bar
    [self.panoScrollView.layer removeAllAnimations];
    [self.positionIndicator.layer removeAllAnimations];
    
    //set the content offset manually so that it picks up where it left off.
    
    [self.panoScrollView setContentOffset:currentLayer.bounds.origin animated:NO];
}



@end
