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

@interface PanoDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *panoImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *panoScrollView;

@property (strong, nonatomic) ALAssetsLibrary* library;
@property (strong, nonatomic) ALAsset* asset;
@property (strong, nonatomic) UIPanGestureRecognizer* scrollGestureRecognizer;
@property (assign, nonatomic) CGFloat xOffset;

@property (weak, nonatomic) IBOutlet UIView *positionIndicator;

-(id)initWithPanoImageAsset:(ALAsset*)asset assetsLibrary:(ALAssetsLibrary* ) library;

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

-(id)initWithPanoImageAsset:(ALAsset*)asset assetsLibrary:(ALAssetsLibrary* ) library{
    self= [super init];
    if(self) {
        self.library  = library;
        self.asset = asset;
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated {

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
    

}

- (void) viewDidAppear:(BOOL)animated {
    
    UIScrollView *scrollView = self.panoScrollView;
//    
//    CGRect bounds = scrollView.bounds;
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    animation.duration = 1.0;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    
//    animation.fromValue = [NSValue valueWithCGRect:bounds];
//    
//    bounds.origin.x += 200;
//    
//    animation.toValue = [NSValue valueWithCGRect:bounds];
//    
//    [scrollView.layer addAnimation:animation forKey:@"bounds"];
//    
//    scrollView.bounds = bounds;
//    
//
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



#pragma mark -- SCroll view delegate methods


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGFloat offsetPct = offset.x / scrollView.contentSize.width;
    
    CGRect newFrame = self.positionIndicator.frame;
    newFrame.origin.x = offsetPct * 320;
    self.positionIndicator.frame = newFrame;
    
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
