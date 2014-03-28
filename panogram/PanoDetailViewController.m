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
#import "PanZoomViewController.h"

@interface PanoDetailViewController ()

@property (strong, nonatomic) ALAssetsLibrary* library;
@property (strong, nonatomic) ALAsset* asset;
@property (strong, nonatomic) UIPanGestureRecognizer* scrollGestureRecognizer;
@property (assign, nonatomic) CGFloat xOffset;
@property (weak, nonatomic) IBOutlet UIButton *panZoomButton;

@property (strong, nonatomic) PanZoomViewController *panZoomController;

@property (weak, nonatomic) IBOutlet UIView *positionIndicator;

-(id)initWithPanoImageAsset:(ALAsset*)asset;

-(void)handleBack:(id)sender;
-(void)handleNext:(id)sender;

-(void)showDefaultNavItems ;

- (IBAction)handlePanZoomButton:(id)sender;
-(void)dismissChildModalViewController:(id)sender ;

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
        self.library = [AppDelegate defaultAssetsLibrary];
        
        self.asset = asset;
        self.currentOffset = CGPointMake(0,0);

    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated {
    
    [UIView animateWithDuration:.35 animations:^{
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }];
    
    CGRect frame = self.panoScrollView.frame;
    frame.origin = CGPointMake(0, 0);
    [self.view addSubview:self.panoScrollView];
    
    [self showDefaultNavItems];

}


-(void)showDefaultNavItems {

    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow" ] style:UIBarButtonItemStylePlain target:self action:@selector(handleBack:)] animated: YES];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    self.navigationItem.leftItemsSupplementBackButton = NO;
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"NEXT" style:UIBarButtonItemStylePlain target:self action:@selector(handleNext:)] animated:YES];
    
    self.title = @"EDIT";
    
  

    
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
    
    PanZoomViewController *panZoomController = [[PanZoomViewController alloc] init];
    
    
    [self addChildViewController:panZoomController];
    
    CGPoint finalPoint = CGPointMake(panZoomController.view.frame.size.width /2, self.view.frame.size.height - panZoomController.view.frame.size.height /2);
    CGPoint startPoint = CGPointMake(finalPoint.x,self.view.frame.size.height + panZoomController.view.frame.size.height /2);
    
    panZoomController.view.center = startPoint;
    
    [self.view addSubview:panZoomController.view];
    
    UIImage *image;
    
//    ALAssetRepresentation *rep = [self.asset defaultRepresentation];
    
    CGImageRef thumb = [self.asset aspectRatioThumbnail]; //[rep CGImageWithOptions:nil]
    image = [[UIImage alloc] initWithCGImage:thumb];
    panZoomController.panoImage.image = image;
   

    
    panZoomController.delegate=self;
    self.panZoomController=panZoomController;
    

   
    [self.navigationItem setTitle:@"PAN & ZOOM"];
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    [self.navigationItem setRightBarButtonItem:nil animated:YES];



    
    
    
        
    [UIView animateWithDuration:.35 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:10 options:0 animations:^{
        panZoomController.view.center =finalPoint;
    } completion:nil];
    
    [self _stopAnimationsAndUpdateScrollView];
    [self.panoScrollView setContentOffset:CGPointMake(0, 0) animated:YES];

}

-(void)hidePanZoomView:(void (^)(BOOL finished))completion {
    PanZoomViewController *panZoomController = self.panZoomController;
    
    CGPoint finalPoint = CGPointMake(panZoomController.view.frame.size.width /2, self.view.frame.size.height - panZoomController.view.frame.size.height /2);
    CGPoint startPoint = CGPointMake(finalPoint.x,self.view.frame.size.height + panZoomController.view.frame.size.height /2);
    
//    panZoomController.view.center = startPoint;
    
    
    
    
    [UIView animateWithDuration:.35 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:10 options:0 animations:^{
        panZoomController.view.center =startPoint;
    } completion:completion];

    
}


-(void)dismissChildModalViewController:(id)sender ; {
    if([sender isEqual:self.panZoomController]) {
        
        [self hidePanZoomView:^(BOOL finished) {
            [self.panZoomController removeFromParentViewController];
            [self.panZoomController.view removeFromSuperview];
        }];
      

        
        [self.navigationItem setTitle:@"EDIT"];
        [self showDefaultNavItems];
    }
    
}

- (void)handleNext:(id) sender {
//    PanoPostingViewController *postingVC = [[PanoPostingViewController alloc] initWithScrollView:self.panoScrollView];
//    [self.navigationController pushViewController:postingVC animated:YES];
}

#pragma mark -- Scroll view delegate methods


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

    [self _stopAnimationsAndUpdateScrollView];
}

-(void) _stopAnimationsAndUpdateScrollView {
    CALayer *currentLayer = self.panoScrollView.layer.presentationLayer;
    
    NSLog(@"x offset: %f", currentLayer.bounds.origin.x);
    
    //remove the animations from the layer of the scroll view & indicator bar
    [self.panoScrollView.layer removeAllAnimations];
    [self.positionIndicator.layer removeAllAnimations];
    
    //set the content offset manually so that it picks up where it left off.
    
    [self.panoScrollView setContentOffset:currentLayer.bounds.origin animated:NO];
}

#pragma mark -- PanZoomEditorDelegate methods



- (void) didCompleteEditing {
    [self dismissChildModalViewController:self.panZoomController];
}

- (void) updateStartPosition:(CGPoint)point withScale:(CGFloat)scale {
    
}
- (void) updateEndPosition:(CGPoint)point withScale:(CGFloat)scale {

}
- (void) resetStartAndEndPositions{

}
- (void) swapStartAndEndPositions{

    
}


@end
