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


- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
	// Load up text from passed MapAnnotation.
    
    [_myNavItem setTitle:_locInfo.title];
    _info.text = _locInfo.info;
    _myPic.image=[UIImage imageNamed:_locInfo.pic];
    
    //NSLog(@"The image name is:%@",[_locInfo valueForKey:@"pic"]);
    
    float lon = _locInfo.coordinate.longitude;
    float lat = _locInfo.coordinate.latitude;

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
