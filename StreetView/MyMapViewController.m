//
//  MyMapViewController.m
//  StreetView
//
//  Created by James Burns on 12/16/13.
//  Copyright (c) 2013 James Burns. All rights reserved.
//

#import "MyMapViewController.h"

@interface MyMapViewController ()

@end

@implementation MyMapViewController

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
    
    //make a location manager
    _locationManager.delegate=self;
    //show user location
   self.myMapView.showsUserLocation=YES;
    //tell location manager to monitor changes
    [_locationManager startMonitoringSignificantLocationChanges];

//    start with the center of Atlanta
    CLLocationCoordinate2D center=CLLocationCoordinate2DMake(33.748995,-84.387982);
    _region=MKCoordinateRegionMakeWithDistance(center, 50000, 50000);
    
    [_myMapView setRegion:_region animated:YES];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarningloc
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{

    _region=MKCoordinateRegionMakeWithDistance(mapView.userLocation.location.coordinate, 1000, 1000);

    [_myMapView setRegion:_region animated:YES];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
     NSLog(@"In didUpdateLocations");
    
 
}

@end
