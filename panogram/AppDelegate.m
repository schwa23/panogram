//
//  AppDelegate.m
//  panogram
//
//  Created by Joshua Dickens on 3/15/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import "AppDelegate.h"
#import "MainNavController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    //    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    
    UIColor *barTintColor = [UIColor colorWithRed:22.0/255.0 green:25.0/255.0 blue:27.0/255.0 alpha:1.0];
    UIColor *tintColor = [UIColor colorWithRed:55.0/255.0 green:143.0/255.0 blue:234.0/255.0 alpha:1.0];
    
    
    UIColor *whiteTitleColor = [UIColor colorWithWhite:.98 alpha:1.0];
    UIFont *titleFont = [UIFont fontWithName:@"FreightSansProSemibold-Regular" size:18];

    
    UIFont *buttonFont = [UIFont fontWithName:@"FreightSansProMedium-Regular" size:18];
        
    [[UINavigationBar appearance] setBarTintColor:barTintColor];
//    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName : titleFont, NSForegroundColorAttributeName: whiteTitleColor }];

    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: buttonFont } forState:UIControlStateNormal];
    [[UIWindow appearance] setTintColor:tintColor];
    
    
    self.window.rootViewController = [[MainNavController alloc] init];
    self.window.backgroundColor = [UIColor blackColor];
    


    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
