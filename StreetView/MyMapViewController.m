//
//  MyMapViewController.m
//  StreetView
//
//  Originally created by James Burns on 12/16/13.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import "MyMapViewController.h"
#import "LoadObjectsFromFile.h"
#import "MapAnnotations.h"
#import "DetailViewController.h"


@interface MyMapViewController ()

//actions
- (IBAction)centerOnUser:(id)sender;
- (IBAction)segChanged:(id)sender;
- (IBAction)goHome:(id)sender;
- (void)loadUpAnnotationsWithFiles:(NSArray *)fileNames;
- (float)updatePinDistance:(CLLocationCoordinate2D)pinLoc;

//properties
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSDictionary *myLocations;
@property (nonatomic) BOOL firstRun;

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
    _firstRun=YES;
    
    [super viewDidLoad];
   
    //init location manager
    // _locationManager= [[CLLocationManager alloc]init];
    
        //set location manager's delegate
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _firstRun=YES;
}

//Load up a buncha locations

- (void)loadUpAnnotationsWithFiles:(NSArray *)fileNames{
    
    NSLog(@"In loadUpAnnotationsWithFiles");
    
        for (NSString *myKind in fileNames) {
            
            NSLog(@"loading %@",myKind);
            
              _myLocations = [LoadObjectsFromFile loadFromFile:myKind ofType:@"plist"];
    
            //loop through and make annotations
            
            for (NSString *loc in _myLocations) {
                NSDictionary *myDict =[_myLocations objectForKey:loc];
                
                //create instance of custom class MapAnnotations
                MapAnnotations *myAnnotation = [[MapAnnotations alloc]
                                                initWithLatitude:[[myDict objectForKey:@"latitude"] floatValue]
                                                longitude:[[myDict objectForKey:@"longitude"] floatValue]
                                                title:[myDict objectForKey:@"title"]];
                //add additional properties
                
                myAnnotation.kind = myKind;
                myAnnotation.info = [myDict objectForKey:@"info"];
                myAnnotation.pic = [myDict objectForKey:@"pic"];
                myAnnotation.distance=[self updatePinDistance:myAnnotation.coordinate];
                myAnnotation.subtitle=[NSString stringWithFormat:@"%.2f miles away",myAnnotation.distance];
                //NSLog(@"Annotation pic contains: %@",myAnnotation.pic);
                [self.myMapView addAnnotation:myAnnotation];
                //NSLog(@"Annotation contains: %@",myAnnotation.kind);
            }
        }

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


#pragma mark mapview delegate methods
// mapview delegate methods

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    MKPointAnnotation *selectedAnnotation = view.annotation;
        NSLog(@"Selected mapView annotation %@", selectedAnnotation.title);
    
    // figure out distance to user
    [self updatePinDistance:selectedAnnotation.coordinate];
    
    
    //Center on selected annotation
    [self.myMapView setCenterCoordinate:selectedAnnotation.coordinate animated:YES];

}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{

}

#pragma mark - user location stuff

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"In didUpdateUserLocation");
    _location = userLocation.coordinate;
    NSLog(@"Our new location is:%f,%f",_location.latitude,_location.longitude);
    
    if (_firstRun) {
        //need to add quirks.plist when complete!
        NSArray *myFiles = @[@"historic",@"attractions",@"neighborhoods"];
        [self loadUpAnnotationsWithFiles:myFiles];
        _firstRun=NO;
        [self centerOnUser:self];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
     NSLog(@"In didUpdateLocations");
 
}

#pragma mark - annotation stuff

// This gets called every time an annotation appears in the map view

- (MKAnnotationView *)mapView:(MKMapView *)theView
            viewForAnnotation:(id < MKAnnotation >)annotation
{
    //NSLog(@"Map view can see annotation %@.",annotation.title);
    
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
            
            //NSLog(@"My annotation kind is: %@",theAnnotation.kind);
            
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

// custom animation of pins

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
    MKAnnotationView *aV;
    
    for (aV in views) {
        
        // Don't pin drop if annotation is user location
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        // Check if current annotation is inside visible map rect, else go to next one
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(self.myMapView.visibleMapRect, point)) {
            continue;
        }
        
        CGRect endFrame = aV.frame;
        
        // Move annotation out of view
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
        
        // Animate drop
        [UIView animateWithDuration:1 delay:0.04*[views indexOfObject:aV] options:UIViewAnimationOptionCurveLinear animations:^{
            
            aV.frame = endFrame;
            
            // Animate squash
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
                    
                }completion:^(BOOL finished){
                    if (finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            aV.transform = CGAffineTransformIdentity;
                        }];
                    }
                }];
            }
        }];
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"%@",(MapAnnotations *)view.annotation);
    
    //trigger segue and send object with data
    [self performSegueWithIdentifier:@"showDetailFromMap" sender:view.annotation];
    
}

// for segue to detail view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetailFromMap"])
    {
        DetailViewController *dest =[segue destinationViewController];
        
        //pass values
        dest.locInfo = sender;
    }
}

#pragma mark - Other methods

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


    [_myMapView setRegion:_region animated:YES];
    [_myMapView deselectAnnotation:[_myMapView.selectedAnnotations objectAtIndex:0] animated:YES];
    
}

- (IBAction)goHome:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (float)updatePinDistance:(CLLocationCoordinate2D)pinLoc
{
    CLLocation *here = [[CLLocation alloc]initWithLatitude:pinLoc.latitude longitude:pinLoc.longitude];
    CLLocation *userPos = [[CLLocation alloc]initWithLatitude:_location.latitude longitude:_location.longitude];
    const float MILE_RATIO = 1609.34;
    float distance = [here distanceFromLocation:userPos]/MILE_RATIO;
    return distance;
}



@end
