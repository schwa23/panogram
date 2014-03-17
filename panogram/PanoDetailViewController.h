//
//  PanoDetailViewController.h
//  panogram
//
//  Created by Joshua Dickens on 3/15/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAssetsLibrary.h>

@interface PanoDetailViewController : UIViewController <UIScrollViewDelegate>

-(id)initWithPanoImageAsset:(ALAsset*)asset assetsLibrary:(ALAssetsLibrary* ) library;

@end
