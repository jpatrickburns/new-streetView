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

    _region.center=CLLocationCoordinate2DMake(
                                             //center of atlanta
                                             33.748995,-84.387982);

    _region.span.latitudeDelta=.5;
    _region.span.longitudeDelta=.5;
    
    [_myMapView setRegion:_region animated:YES];

    // make region to check that user is in region
//    CLRegion *myRegion = [[CLRegion alloc] initCircularRegionWithCenter:region.center
//                                                       radius:25000
//                                                   identifier:@"homeRegion"];
//    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarningloc
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startSignificantChangeUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    [_locationManager startMonitoringSignificantLocationChanges];
}

@end
