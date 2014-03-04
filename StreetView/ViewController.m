//
//  ViewController.m
//  StreetView
//
//  Created by James Burns on 12/14/13.
//  Copyright (c) 2013 James Burns. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(void)viewDidAppear:(BOOL)animated{
    //see if there are any favorites
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    //if there are saved locations, enable button

    _favButton.enabled = (bool)[myDefaults objectForKey:@"savedLocations"];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (IBAction)changeScene:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSString *which = btn.currentTitle;
    
    if ([which isEqualToString:@"What’s Near Me?"]){
        [self performSegueWithIdentifier:@"map" sender:nil];
        
    }else if ([which isEqualToString:@"Special Offers"]){
        [self performSegueWithIdentifier:@"special" sender:nil];
        NSLog(@"Pushed Special Offers");
    }else{

        [self performSegueWithIdentifier:@"table" sender:which];
    }
    NSLog(@"Pushed %@.",which);
}

- (IBAction)showFavs:(id)sender
{
   [self performSegueWithIdentifier:@"toFav" sender:nil]; 
}

// for segue to table view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MyTableViewController *dest =[segue destinationViewController];

    if ([[segue identifier] isEqualToString:@"table"])
    {
            dest.myKind = sender;
        }
}

@end
