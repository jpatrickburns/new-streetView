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
    _myPic.layer.cornerRadius=10;
    _myPic.layer.borderWidth=1;
    //NSLog(@"The image name is:%@",[_locInfo valueForKey:@"pic"]);
    
    float lon = _locInfo.coordinate.longitude;
    float lat = _locInfo.coordinate.latitude;
    _tinyMap.layer.cornerRadius=50;
    _tinyMap.layer.borderWidth=1;
    CLLocationCoordinate2D myCoordinates= CLLocationCoordinate2DMake(lat, lon);
     _tinyMap.region=MKCoordinateRegionMakeWithDistance(myCoordinates, 1000, 1000);
    _myDistance.text=[NSString stringWithFormat:@"%.2f miles from your current location.", _locInfo.distance];
    
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

- (IBAction)getDirections:(id)sender
{
    MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: _locInfo.coordinate addressDictionary: nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
    destination.name = _locInfo.title;
    [MKMapItem openMapsWithItems: @[destination] launchOptions: @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];

}
@end
