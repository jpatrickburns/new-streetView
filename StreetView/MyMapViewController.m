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

//outlets
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

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

    //set location manager's delegate
    
    _locationManager.delegate=self;
    
    //show user location
    self.myMapView.showsUserLocation=YES;
   
    //tell location manager to monitor changes
    [_locationManager startUpdatingLocation];

//    start with the center of Atlanta
    CLLocationCoordinate2D center=CLLocationCoordinate2DMake(33.748995,-84.387982);
    _region=MKCoordinateRegionMakeWithDistance(center, 50000, 50000);
    
    [_myMapView setRegion:_region animated:YES];
    
	// Do any additional setup after loading the view.
}

//hide status bar
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarningloc
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"In didUpdateUserLocation");
    _location = userLocation.coordinate;
    [self centerOnUser:self];
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
    
    _region = MKCoordinateRegionMakeWithDistance(_location, 1000, 1000);
        
    NSLog(@"Our new location is:%f,%f",_location.latitude,_location.longitude);

    [self.myMapView setRegion:_region animated:YES];
    
}

- (IBAction)goHome:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
