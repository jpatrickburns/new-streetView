//
//  DetailViewController.m
//  StreetView
//
//  Created by James Burns on 1/30/14.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"

@interface DetailViewController ()

- (IBAction)share:(id)sender;
- (IBAction)goHome:(id)sender;

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
    
    NSLog(@"locInfo contains:%@",_locInfo);
    
    _myNavItem.title=_locInfo.title;
    _info.text = _locInfo.info;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
        // set up image
    _myPic.image = [UIImage imageNamed:_locInfo.pic];
    _myPic.layer.cornerRadius = 10;
    _myPic.layer.borderWidth = 1;
    
    //set up map
    float lon = _locInfo.coordinate.longitude;
    float lat = _locInfo.coordinate.latitude;
    _tinyMap.layer.cornerRadius = 50;
    _tinyMap.layer.borderWidth = 1;
    
    CLLocationCoordinate2D myCoordinates= CLLocationCoordinate2DMake(lat, lon);
    _tinyMap.region = MKCoordinateRegionMakeWithDistance(myCoordinates, 1000, 1000);
    _mySubtitle.text = _locInfo.subtitle;
    
}
//
//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

- (IBAction)share:(id)sender
{
    
    NSArray *activityItems = @[_locInfo.title, _locInfo.subtitle, [NSString stringWithFormat:@"%f",_locInfo.coordinate.longitude]];
    UIActivityViewController *sharingView = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    sharingView.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard, UIActivityTypePostToFlickr];
    
    [self presentViewController:sharingView animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goHome:(id)sender {
   
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)getDirections:(id)sender
{
    if ([CLLocationManager locationServicesEnabled]) {
        MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: _locInfo.coordinate addressDictionary: nil];
        MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
        destination.name = _locInfo.title;
        [MKMapItem openMapsWithItems: @[destination]
                       launchOptions: @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry..." message:@"Location Services aren’t enabled. Please change in settings." delegate:nil cancelButtonTitle:@"O.K." otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
