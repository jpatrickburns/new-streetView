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

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic,copy) NSString *kind;
@property (nonatomic,copy) NSNumber *latitude;
@property (nonatomic,copy) NSNumber *longitude;

- (id)initWithLatitude:(float)lat longitude:(float)lon;

@end
