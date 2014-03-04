//
//  FavoritesTableView.m
//  StreetView
//
//  Created by James Burns on 2/11/14.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import "FavoritesTableView.h"


@interface FavoritesTableView ()

//properties


//actions

- (void) doSetUp;

@end


NSMutableArray *myFavs;

@implementation FavoritesTableView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self doSetUp];


     // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSLog(@"There are %lu locations in myFavs.",(unsigned long)myFavs.count);
    return myFavs.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"In cellForRowAtIndexPath");
    
    static NSString *MyIdentifier = @"favCell";
    
       // Try to retrieve from the table view a now-unused cell with the given identifier.
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // If no cell is available, create a new one using the given identifier.
    if (cell == nil) {
        // Use the subtitle cell style.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    
    // Set up the cell.
    
   MapAnnotations *annotation = [myFavs objectAtIndex:indexPath.row];
    
    NSLog(@"chunk for cell:%@", annotation);
    
    cell.textLabel.text = annotation.title;
    cell.detailTextLabel.text = annotation.title;
    
    return cell;
}


-(void)doSetUp
{
    //load up file, if exists
    
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    //make a mutable array to hold any locations saved
    
    //if there are saved locations
    if ([myDefaults objectForKey:@"savedLocations"]) {
        
        NSLog(@"file exists!");
        
        //get saved data and put in a temporary array
        NSData *theData = [myDefaults dataForKey:@"savedLocations"];
        //this assumes your custom object used NSCode protocol
        NSArray *temp = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:theData];
        NSLog(@"temp contains:%@",temp);
        myFavs = [temp mutableCopy];
        
    }else{
        
        NSLog(@"File doesn't exist");
        myFavs = [[NSMutableArray alloc]init];
    }
    
    //if there's a new passed current location
    if (_currLoc != nil) {
        //add location to end of myFavs array
        [myFavs addObject:_currLoc];
        
        NSLog(@"myFavs now contains:%@",myFavs);
        
        //write defaults
        
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:myFavs];
        [myDefaults setObject:encodedObject forKey:@"savedLocations"];
        [myDefaults synchronize];
        
    }
    
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

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
