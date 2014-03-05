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
@property NSUserDefaults *myDefaults;

//actions

- (void) doSetUp;

@end


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
    
    self.title = @"Saved Locations";
    
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

-(void) saveFavorites
{
    if (_myFavs.count ==0) {
        [_myDefaults removeObjectForKey:@"savedLocations"];
        //leave page and go back
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:_myFavs];
        [_myDefaults setObject:encodedObject forKey:@"savedLocations"];
        [_myDefaults synchronize];
    }
}

-(void)doSetUp
{
    //load up file, if exists
    NSLog(@"_currLoc contains:%@",_currLoc);
    
    _myDefaults = [NSUserDefaults standardUserDefaults];
    //make a mutable array to hold any locations saved
    
    //if there are saved locations
    if ([_myDefaults objectForKey:@"savedLocations"]) {
        
        NSLog(@"file exists!");
        
        //get saved data and put in a temporary array
        NSData *theData = [_myDefaults dataForKey:@"savedLocations"];
        //this assumes your custom object used NSCode protocol
        NSArray *temp = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:theData];
        NSLog(@"temp contains:%@",temp);
        _myFavs = [temp mutableCopy];
        
    }else{
        NSLog(@"File doesn't exist");
        _myFavs = [[NSMutableArray alloc]init];
    }
    
    //if there's a new passed current location
    if (_currLoc != nil) {
        
        if ([_myFavs containsObject:_currLoc]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry..." message:[NSString stringWithFormat:@"The %@ location has already been saved.",_currLoc.title] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            //add location to end of myFavs array
            [_myFavs addObject:_currLoc];
            
            NSLog(@"There are %lu locations in myFavs.",(unsigned long)_myFavs.count);
            //NSLog(@"myFavs now contains:%@",_myFavs);
            
            //write defaults
            [self saveFavorites];
        }
    }
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
    //NSLog(@"There are %lu locations in myFavs.",(unsigned long)_myFavs.count);
    return _myFavs.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"In cellForRowAtIndexPath");
    
    static NSString *MyIdentifier = @"favCell";
    
    // Try to retrieve from the table view a now-unused cell with the given identifier.
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // If no cell is available, create a new one using the given identifier.
    if (cell == nil) {
        // Use the subtitle cell style.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    
    // Set up the cell.
    
    MapAnnotations *annotation = [_myFavs objectAtIndex:indexPath.row];
    
    //NSLog(@"chunk for cell:%@", annotation);
    
    cell.textLabel.text = annotation.title;
    cell.detailTextLabel.text = annotation.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Hit swiped delete button on row %lD.",(long)indexPath.row);
    //delete selected cell from data source array
    [_myFavs removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self saveFavorites];
}


#pragma mark - Table View Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 NSLog(@"Rearranged an item from row %ld to row %ld.", (long)fromIndexPath.row,(long)toIndexPath.row);
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

#pragma mark - Navigation

// Segue to the detail view on selection

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller
    DetailViewController *dest = [segue destinationViewController];
    //get an index for the selected cell
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    MapAnnotations *passedAnnotation =_myFavs[indexPath.row];
    // Pass the selected object to the new view controller.
    dest.locInfo = passedAnnotation;
}



@end
