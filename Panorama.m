//
//  Panorama.m
//  panogram
//
//  Created by Joshua Dickens on 3/15/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import "Panorama.h"

@interface Panorama ()


@end


@implementation Panorama

+(NSMutableArray *)arrayOfPanoramasInLibrary {
    NSMutableArray *panosTemp = [[NSMutableArray alloc] init];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            ALAssetRepresentation *rep = [result defaultRepresentation];
            CGFloat aspect = rep.dimensions.width / rep.dimensions.height;
            if(aspect >= 2) {
                [panosTemp addObject:result];
                NSLog(@"Adding: %@", result);

                
            }
        }];
        
     
    } failureBlock:^(NSError *error) {
        NSLog(@"encountered an error %@", error);
    }];
    
   
    return panosTemp;
}

@end
