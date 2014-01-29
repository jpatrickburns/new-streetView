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




//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //hide nav bar
    [self.navigationController setNavigationBarHidden:YES];

    //init location manager
    // _locationManager= [[CLLocationManager alloc]init];
    
    
     //tell location manager to monitor changes
    [_locationManager startUpdatingLocation];


    //set location manager's delegate
    _locationManager.delegate=self;
    
    //show user location
    self.myMapView.showsUserLocation=YES;
   
   //    start with the center of Atlanta
    CLLocationCoordinate2D center=CLLocationCoordinate2DMake(33.748995,-84.387982);
    _region=MKCoordinateRegionMakeWithDistance(center, 50000, 50000);
    
    [_myMapView setRegion:_region animated:YES];
    
    //need to add quirks.plist when complete!
    NSArray *myFiles = [NSArray arrayWithObjects:@"historic",@"attractions",@"neighborhoods", nil];
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
                
                //create instance of MapAnnotations
                MapAnnotations *myAnnotation = [[MapAnnotations alloc]initWithLatitude:[[value objectForKey:@"latitude"] floatValue] longitude:[[value objectForKey:@"longitude"] floatValue]];
                
                myAnnotation.kind = myKind;
                myAnnotation.title = [value objectForKey:@"title"];
                myAnnotation.subtitle = [value objectForKey:@"subtitle"];
                myAnnotation.info =[value objectForKey:@"info"];
                myAnnotation.pic =[value objectForKey:@"pic"];
                myAnnotation.latitude = [value objectForKey:@"latitude"];
                myAnnotation.longitude = [value objectForKey:@"longitude"];
                
                [self.myMapView addAnnotation:myAnnotation ];
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
