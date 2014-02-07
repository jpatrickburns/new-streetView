//
//  MyTableViewController.m
//  StreetView
//
//  Created by James Burns on 2/4/14.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import "MyTableViewController.h"
#import "LoadObjectsFromFile.h"
#import "DetailViewController.h"
#import "MapAnnotations.h"
#import "ColorSets.h"

@interface MyTableViewController ()

@property (strong, nonatomic) NSDictionary *myLocations;
@property (strong, nonatomic) NSArray *locationsIndex;


@end

ColorSets *myColorSet;

@implementation MyTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//hide status bar
- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set delegate and data source
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    //Load up from the passed kind of file
    // NSLog(@"Received %@ from segue.",_myKind);
    
    // set up colors
    
    myColorSet = [[ColorSets alloc]init];
    
    //special case
    
    if ([_myKind isEqualToString:@"Only in the ATL"]) {
        _myLocations = [LoadObjectsFromFile loadFromFile:@"quirk" ofType:@"plist"];
        [self.navigationController.navigationBar setBarTintColor:myColorSet.myteal];
        myColorSet.currentColor = myColorSet.myteal;
    }else{
        _myLocations = [LoadObjectsFromFile loadFromFile:[_myKind lowercaseString] ofType:@"plist"];
    }
    
    //set up colors to color the navBar
    
    if ([_myKind isEqualToString:@"Historical"]){
        [self.navigationController.navigationBar setBarTintColor:myColorSet.myRed];
        myColorSet.currentColor = myColorSet.myRed;
    }
    else if ([_myKind isEqualToString:@"Attractions"]){
        [self.navigationController.navigationBar setBarTintColor:myColorSet.myGold];
        myColorSet.currentColor = myColorSet.myGold;
    }
    else if ([_myKind isEqualToString:@"Neighborhoods"]){
        [self.navigationController.navigationBar setBarTintColor:myColorSet.myGreen];
        myColorSet.currentColor = myColorSet.myGreen;
    }
    
    _myTableView.backgroundColor=[myColorSet tintColor:myColorSet.currentColor withSaturationFactor:.8 withValueFactor:.8];
    
    //make a tint
    myColorSet.currentColor = [myColorSet tintColor:myColorSet.currentColor withSaturationFactor:.8 withValueFactor:1.5];
    
    
    //change the title to the current section
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = _myKind;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [_myLocations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get a sorted array of all the keys in myLocation
    
    NSArray *temp= [_myLocations allKeys];
    
    // this makes an array of sorted keys
    _locationsIndex = [temp sortedArrayUsingSelector:
                     @selector(localizedCaseInsensitiveCompare:)];
    
    //NSLog(@"my locationsIndex is: %@",locationsIndex);

    static NSString *MyIdentifier = @"myCell";
    
    // Try to retrieve from the table view a now-unused cell with the given identifier.
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // If no cell is available, create a new one using the given identifier.
    if (cell == nil) {
        // Use the subtitle cell style.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    
    // Set up the cell.
    
    id value = _myLocations[[_locationsIndex objectAtIndex:indexPath.row]];
    
    cell.textLabel.text= value[@"title"];
    cell.detailTextLabel.text = value[@"subtitle"];
    
    return cell;
}

#pragma mark - Table View Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = myColorSet.currentColor;
    cell.contentView.backgroundColor = myColorSet.currentColor;
    cell.accessoryView.tintColor=[UIColor whiteColor];
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller
    DetailViewController *dest = [segue destinationViewController];
    //get an index for the selected cell
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSDictionary *myDict = [_myLocations objectForKey:[_locationsIndex objectAtIndex:indexPath.row]];
    MapAnnotations *myInfo = [[MapAnnotations alloc] initWithLatitude:[myDict[@"latitude"] floatValue] longitude:[myDict[@"longitude"] floatValue] title:myDict[@"title"]];
    //add additional properties
    myInfo.subtitle=myDict[@"subtitle"];
    myInfo.kind = _myKind;
    myInfo.info = myDict[@"info"];
    myInfo.pic = myDict[@"pic"];
    NSLog(@"myInfo contains:%@",myInfo);
    
        // Pass the selected object to the new view controller.
    dest.locInfo = myInfo;
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



@end
