//
//  DetailViewController.m
//  StreetView
//
//  Created by James Burns on 1/30/14.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@end


@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
	// Load up text from passed dictionary.
    [_myNavItem setTitle:[_locInfo valueForKey:@"title"]];
    _info.text = [_locInfo valueForKey:@"info"];
    _myPic.image=[UIImage imageNamed:[_locInfo valueForKey:@"pic"]];
    NSLog(@"The image name is:%@",[_locInfo valueForKey:@"pic"]);
    float lon = [[_locInfo valueForKey:@"lon"] floatValue];
    float lat = [[_locInfo valueForKey:@"lat"] floatValue];

    CLLocationCoordinate2D myCoordinates= CLLocationCoordinate2DMake(lat, lon);
     _tinyMap.region=MKCoordinateRegionMakeWithDistance(myCoordinates, 1000, 1000);
    
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
