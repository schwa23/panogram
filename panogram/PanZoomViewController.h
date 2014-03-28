//
//  PanZoomViewController.h
//  panogram
//
//  Created by Joshua Dickens on 3/25/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PanZoomEditorDelegate <NSObject>

@required
- (void) didCompleteEditing;
- (void) updateStartPosition:(CGPoint)point withScale:(CGFloat)scale;
- (void) updateEndPosition:(CGPoint)point withScale:(CGFloat)scale;
- (void) resetStartAndEndPositions;
- (void) swapStartAndEndPositions;
@end

@interface PanZoomViewController : UIViewController
//{
//  id  <PanZoomEditorDelegate>  delegate;
//}

@property (nonatomic, unsafe_unretained) id <PanZoomEditorDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *panoImage;

@end
