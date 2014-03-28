//
//  PanoTableViewController.m
//  panogram
//
//  Created by Joshua Dickens on 3/15/14.
//  Copyright (c) 2014 Joshua Dickens. All rights reserved.
//

#import "PanoTableViewController.h"
#import "Panorama.h"
#import "MainNavController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "PanoDetailViewController.h"
#import "PanoCell.h"
#import "AppDelegate.h"
#import "TransitionAnimator.h"

@interface PanoTableViewController ()

@property (nonatomic, strong) NSMutableArray* panos;
@property (nonatomic, strong) ALAssetsLibrary* library;
@property (nonatomic,strong) TransitionAnimator* transitionAnimator;

@end

@implementation PanoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
            self.title = @"PANORAMAS";
        
        self.selectedFrame = CGRectMake(0, 0, 320, 88);
        self.panos = [[NSMutableArray alloc] init];
        
        self.library = [AppDelegate defaultAssetsLibrary];
        
        [self.library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                ALAssetRepresentation *rep = [result defaultRepresentation];
                CGFloat aspect = rep.dimensions.width / rep.dimensions.height;
                if(aspect >= 2) {
                    [self.panos addObject:result];
                    [self.tableView reloadData];
                }
            }];
            
            
        } failureBlock:^(NSError *error) {
            NSLog(@"encountered an error %@", error);
        }];

        
    }
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"IMPORT" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(handleImport:)];
    
    
    self.transitionAnimator = [[TransitionAnimator alloc] init];
    
    [[self tableView] registerNib:[UINib nibWithNibName:@"PanoCell" bundle:nil] forCellReuseIdentifier:@"PanoCell"];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    /// self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    //clear the tint color
//    [UIView animateWithDuration:.35 animations:^{
//        self.navigationController.navigationBar.tintColor = nil;
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    NSLog(@"Count : %lu", (unsigned long)self.panos.count);
       return self.panos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO use a custom table view cell here.

    static NSString *CellIdentifier = @"PanoCell";
    PanoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        cell = (PanoCell *)[tableView dequeueReusableCellWithIdentifier:@"FeedListCell"];
        
       
    }

    
    ALAsset *asset = [self.panos objectAtIndex:indexPath.row];
    CGImageRef thumb = [asset aspectRatioThumbnail];
    
    [cell.panoImageView setImage:[UIImage imageWithCGImage:thumb]];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 93;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    //TODO: Need to create a custom view transition
    ALAsset *selectedAsset = [self.panos objectAtIndex:indexPath.row];
    
    PanoDetailViewController *detailViewController = [[PanoDetailViewController alloc] initWithPanoImageAsset:selectedAsset];
    
    UINavigationController *modalNav = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    modalNav.modalPresentationStyle = UIModalPresentationCustom;
    modalNav.transitioningDelegate = self.transitionAnimator;
    
    ALAssetRepresentation *rep = [selectedAsset defaultRepresentation];
    self.transitionAnimator.transitionImage = [UIImage imageWithCGImage:[rep fullScreenImage]];
    
    PanoCell *selectedCell = (PanoCell *)[tableView cellForRowAtIndexPath:indexPath];
    CGRect selectedFrame = selectedCell.frame;
    
    selectedFrame = [self.tableView convertRect:selectedFrame toView:[self.view superview]];
    self.selectedFrame = selectedFrame;
//    [self presentViewController:modalNav animated:YES completion:^{
//        //did present view controller
//    }];
    [self performSelectorOnMainThread:@selector(openDetailWithController:) withObject:modalNav waitUntilDone:NO];
    
}

- (void)openDetailWithController:(UINavigationController *)controller
{
    [self presentViewController:controller animated:YES completion:^{
        //did present view controller
    }];
}

@end
