//
//  Panorama.h
//  panogram
//
//  Created by Joshua Dickens on 3/15/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface Panorama : NSObject

@property (nonatomic, strong) NSMutableArray* panoramasInLibrary;

+(NSArray *)arrayOfPanoramasInLibrary;

@end
