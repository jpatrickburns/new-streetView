//
//  ViewController.m
//  StreetView
//
//  Created by James Burns on 12/14/13.
//  Copyright (c) 2013 James Burns. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewController.h"
#import "MyMapViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"In home viewDidAppear");
    [super viewDidAppear:YES];
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

- (IBAction)done:(UIStoryboardSegue *)segue {
    NSLog(@"Popping back to this view controller!");
    // reset UI elements etc here
}

- (IBAction)changeScene:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSString *which = btn.currentTitle;
    
    if ([which isEqualToString:@"What’s Near Me?"]){
        [self performSegueWithIdentifier:@"map" sender:self];
        
    }else if ([which isEqualToString:@"Special Offers"]){
        [self performSegueWithIdentifier:@"special" sender:self];
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

// for segue - passing values
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([[segue identifier] isEqualToString:@"table"])
    {
        MyTableViewController *dest =[segue destinationViewController];
        dest.myKind = sender;
    }
    if ([[segue identifier] isEqualToString:@"map"])
    {
        MyMapViewController *dest =[segue destinationViewController];
        dest.firstRun = YES;
        NSLog(@"Sent stuff to Map");
    }
    
}

@end
