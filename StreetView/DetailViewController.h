//
//  DetailViewController.h
//  StreetView
//
//  Created by James Burns on 1/30/14.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotations.h"
#import "ColorSets.h"

@interface DetailViewController : UIViewController



//properties

@property (strong, nonatomic) MapAnnotations *locInfo;
@property (weak, nonatomic) IBOutlet UINavigationItem *myNavItem;
@property (weak, nonatomic) IBOutlet UIImageView *myPic;
@property (weak, nonatomic) IBOutlet MKMapView *tinyMap;
@property (weak, nonatomic) IBOutlet UILabel *mySubtitle;
@property (weak, nonatomic) IBOutlet UIButton *directions;
@property (weak, nonatomic) IBOutlet UITextView *info;

//actions
- (IBAction)getDirections:(id)sender;



@end
