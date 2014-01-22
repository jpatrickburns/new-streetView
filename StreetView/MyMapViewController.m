//
//  MyMapViewController.m
//  StreetView
//
//  Created by James Burns on 12/16/13.
//  Copyright (c) 2013 James Burns. All rights reserved.
//

#import "MyMapViewController.h"

@interface MyMapViewController ()

//actions
- (IBAction)centerOnUser:(id)sender;
- (IBAction)segChanged:(id)sender;
- (IBAction)goHome:(id)sender;


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
    //hide nav bar
    [self.navigationController setNavigationBarHidden:YES];
    
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

- (IBAction)segChanged:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            [self.myMapView setMapType:MKMapTypeStandard];
            break;
        case 1:
            [self.myMapView setMapType:MKMapTypeSatellite];
            break;
        case 2:
            [self.myMapView setMapType:MKMapTypeHybrid];
            break;
            
        default:
            break;
    }
}

- (IBAction)centerOnUser:(id)sender
{
    
    MKCoordinateSpan span;
    span.latitudeDelta = .025;
    span.longitudeDelta = .025;
    _region.span=span;
    _region.center = _locationManager.location.coordinate;
    [self.myMapView setRegion:_region animated:YES];
    
}

- (IBAction)goHome:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
