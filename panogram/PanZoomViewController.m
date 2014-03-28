//
//  PanZoomViewController.m
//  panogram
//
//  Created by Joshua Dickens on 3/25/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import "PanZoomViewController.h"


@interface PanZoomViewController ()


@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resetButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *swapButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (weak, nonatomic) IBOutlet UIView *startIndicator;
@property (weak, nonatomic) IBOutlet UIView *endIndicator;

-(CGSize)imageSizeAfterAspectFit:(UIImageView*)imgview;

- (IBAction)handleDoneButton:(id)sender;

@end

@implementation PanZoomViewController

@synthesize delegate;

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
    [self.view setClipsToBounds:YES];
    CGRect tbFrame = self.toolbar.frame;
    tbFrame.origin = CGPointMake(tbFrame.origin.x, tbFrame.origin.y-.5);
    self.toolbar.frame = tbFrame;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edit-background-pattern"]];
   
    [self.doneButton setTintColor: [UIColor colorWithRed:55.0/255.0 green:143.0/255.0 blue:234.0/255.0 alpha:1.0]];
}

-(void) viewDidAppear:(BOOL)animated {
    CGSize newSize = [self imageSizeAfterAspectFit:self.panoImage];
    CGFloat newWidth = newSize.height;
    
    CGRect newFrame = CGRectMake(0,self.startIndicator.frame.origin.y, newWidth, newWidth);
    
    
    
    self.startIndicator.frame = newFrame;
    self.endIndicator.frame = CGRectMake(320-newWidth, self.endIndicator.frame.origin.y, newWidth, newWidth);
    
    
    self.startIndicator.center = CGPointMake(self.startIndicator.center.x, self.panoImage.center.y);
    self.endIndicator.center = CGPointMake(self.endIndicator.center.x, self.panoImage.center.y);
    
    NSLog(@"pano image frame: %@", NSStringFromCGRect(self.panoImage.frame) );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleDoneButton:(id)sender {
    [self didCompleteEditing];

}


-(CGSize)imageSizeAfterAspectFit:(UIImageView*)imgview{
    
    
    float newwidth;
    float newheight;
    
    UIImage *image=imgview.image;
    
    if (image.size.height>=image.size.width){
        newheight=imgview.frame.size.height;
        newwidth=(image.size.width/image.size.height)*newheight;
        
        if(newwidth>imgview.frame.size.width){
            float diff=imgview.frame.size.width-newwidth;
            newheight=newheight+diff/newheight*newheight;
            newwidth=imgview.frame.size.width;
        }
        
    }
    else{
        newwidth=imgview.frame.size.width;
        newheight=(image.size.height/image.size.width)*newwidth;
        
        if(newheight>imgview.frame.size.height){
            float diff=imgview.frame.size.height-newheight;
            newwidth=newwidth+diff/newwidth*newwidth;
            newheight=imgview.frame.size.height;
        }
    }
    
    NSLog(@"image after aspect fit: width=%f height=%f",newwidth,newheight);
    
    
    //adapt UIImageView size to image size
    //imgview.frame=CGRectMake(imgview.frame.origin.x+(imgview.frame.size.width-newwidth)/2,imgview.frame.origin.y+(imgview.frame.size.height-newheight)/2,newwidth,newheight);
    
    return CGSizeMake(newwidth, newheight);
    
}


#pragma mark Delegate Methods

- (void) didCompleteEditing {
    [[self delegate] didCompleteEditing];
}

- (void) updateStartPosition:(CGPoint)point withScale:(CGFloat)scale {
    [[self delegate] updateStartPosition:point withScale:scale];
    
}
- (void) updateEndPosition:(CGPoint)point withScale:(CGFloat)scale {
    [[self delegate] updateEndPosition:point withScale:scale];
}
- (void) resetStartAndEndPositions{
    [[self delegate] resetStartAndEndPositions];
}
- (void) swapStartAndEndPositions{
    [[self delegate] swapStartAndEndPositions];
    
}
@end
