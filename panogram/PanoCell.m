//
//  PanoCell.m
//  panogram
//
//  Created by Joshua Dickens on 3/17/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import "PanoCell.h"

@implementation PanoCell

- (void)awakeFromNib
{
    // Initialization code
    self.badgeView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
//    CGFloat alpha = 1.0;
//    
//    if(selected){
//        alpha = .5;
//    }
//    
//    if(animated){
//        NSLog(@"animated: %d", animated);
//    [UIView animateWithDuration:.2 animations:^{
//        self.panoImageView.alpha = alpha;
//
//    }];
//    
//    }
//    
//    else {
//        self.panoImageView.alpha = alpha;
//    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    CGFloat alpha = 1.0;
    
    if(highlighted){
        alpha = .5;
    }
    
    if(animated){
        NSLog(@"animated: %d", animated);
        [UIView animateWithDuration:.2 animations:^{
            self.panoImageView.alpha = alpha;
            
        }];
        
    }
    
    else {
        self.panoImageView.alpha = alpha;
    }

}

@end
