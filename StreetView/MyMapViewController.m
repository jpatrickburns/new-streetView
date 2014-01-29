//
//  MyMapViewController.m
//  StreetView
//
//  Created by James Burns on 12/16/13.
//  Copyright (c) 2013 James Burns. All rights reserved.
//

#import "MyMapViewController.h"
#import "LoadObjectsFromFile.h"
#import "MapAnnotations.h"



@interface MyMapViewController ()

//actions
- (IBAction)centerOnUser:(id)sender;
- (IBAction)segChanged:(id)sender;
- (IBAction)goHome:(id)sender;
- (void)loadUpAnnotationsWithFiles:(NSArray *)fileNames;

//properties
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSDictionary *myLocations;


@end



@implementation MyMapViewController



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
    //hide nav bar
    [self.navigationController setNavigationBarHidden:YES];

    //init location manager
    // _locationManager= [[CLLocationManager alloc]init];
    
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
    
    //need to add quirks.plist when complete!
    NSArray *myFiles = @[@"historic",@"attractions",@"neighborhoods"];
    [self loadUpAnnotationsWithFiles:myFiles];
    
	// Do any additional setup after loading the view.
}

//Load up a buncha locations

- (void)loadUpAnnotationsWithFiles:(NSArray *)fileNames{
    
    NSLog(@"In loadUpAnnotationsWithFiles");
    
//    if (_locationManager) {
//        
//        NSLog(@"_locationManager exists");
    
        for (NSString *myKind in fileNames) {
            
            NSLog(@"loading %@",myKind);
            
            _myLocations = [LoadObjectsFromFile loadFromFile:myKind ofType:@"plist"];
            
            //loop through and make annotations
            
            for (NSString *loc in _myLocations) {
                NSDictionary *value =[_myLocations objectForKey:loc];
                
                //create instance of custom class MapAnnotations
                MapAnnotations *myAnnotation = [[MapAnnotations alloc]
                                                initWithLatitude:[[value objectForKey:@"latitude"] floatValue]
                                                longitude:[[value objectForKey:@"longitude"] floatValue]
                                                title:[value objectForKey:@"title"]
                                                subtitle:[value objectForKey:@"subtitle"]];
                //add additional properties
                
                myAnnotation.kind= myKind;
                myAnnotation.info=[value objectForKey:@"info"];
                myAnnotation.pic=[value objectForKey:@"pic"];
                
                [self.myMapView addAnnotation:myAnnotation];
                NSLog(@"Annotation contains: %@",myAnnotation.kind);
            }
        }
        //[self updatePinsDistance];
//    }
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

// mapview delegate methods

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    MKPointAnnotation *selectedAnnotation = view.annotation;
        NSLog(@"Selected mapView annotation %@", selectedAnnotation.title);

    //for sending info to detail
    // myPinTitle = selectedAnnotation.title;
    
    //Center on selected annotation
    [self.myMapView setCenterCoordinate:selectedAnnotation.coordinate animated:YES];

}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{

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

// This gets called every time an annotation appears in the map view

- (MKAnnotationView *)mapView:(MKMapView *)theView
            viewForAnnotation:(id < MKAnnotation >)annotation
{
    // NSLog(@"Map view can see annotation %@.",annotation.title);
    
    //if the annotation is a user location
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    //uses my custom class
    if ([annotation isKindOfClass:[MapAnnotations class]]) {
        
        //recast annotation so we can access kind property
        MapAnnotations *theAnnotation = annotation;
        
        // try for reuse of pins
        
        MKAnnotationView *myPins = (MKAnnotationView *) [theView dequeueReusableAnnotationViewWithIdentifier:@"myPins"];
        
        if (!myPins) {
            myPins= [[MKAnnotationView alloc]initWithAnnotation:theAnnotation reuseIdentifier:@"myPins"];
            myPins.canShowCallout = YES;
            myPins.centerOffset= CGPointMake(0, -myPins.frame.size.height/ 2);
            myPins.rightCalloutAccessoryView =
            [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            NSLog(@"My annotation kind is: %@",theAnnotation.kind);
            
            if ([theAnnotation.kind isEqualToString:@"historic"]) {
                myPins.image = [UIImage imageNamed:@"pushPinRed"];
            }
            
            if ([theAnnotation.kind isEqualToString:@"attractions"]) {
                myPins.image = [UIImage imageNamed:@"pushPinGold"];
            }
            
            if ([theAnnotation.kind isEqualToString:@"neighborhoods"]) {
                myPins.image = [UIImage imageNamed:@"pushPinGreen"];
            }
            
            if ([theAnnotation.kind isEqualToString:@"quirk"]) {
                myPins.image = [UIImage imageNamed:@"pushPinCyan"];
            }
            
        }else
            myPins.annotation = annotation;
        return myPins;
    }
    return nil;
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
    _region = MKCoordinateRegionMakeWithDistance(_location, 2000, 2000);
        
    NSLog(@"Our new location is:%f,%f",_location.latitude,_location.longitude);

    [self.myMapView setRegion:_region animated:YES];
    
}

- (IBAction)goHome:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
