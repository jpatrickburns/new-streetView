//
//  MapAnnotations.h
//  mapFun
//
//  Created by James Burns on 3/23/12.
//  Copyright (c) 2012 James Burns [design]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MapAnnotations : NSObject <MKAnnotation>

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *info;
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *kind;
//@property (nonatomic) float distance;

// Don't need these if we have coordinate
//@property (nonatomic) float lat;
//@property (nonatomic) float lon;



- (id)initWithLatitude:(float)lat
             longitude:(float)lon
                 title:(NSString *)title;
@end
