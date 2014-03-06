//
//  MyMapViewController.h
//  StreetView
//
//  Originally created by James Burns on 12/16/13.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotations.h"


@interface MyMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic,readonly)CLLocationCoordinate2D location;
@property (nonatomic) MKCoordinateRegion region;
@property (strong, nonatomic) MapAnnotations *currentAnnotation;
@property (nonatomic) BOOL showPin;

@end
