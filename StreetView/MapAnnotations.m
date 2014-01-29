//
//  MapAnnotations.m
//  mapFun
//
//  Created by James Burns on 3/23/12.
//  Copyright (c) 2012 James Burns [design]. All rights reserved.
//

#import "MapAnnotations.h"

@implementation MapAnnotations


- (id)initWithLatitude:(float)lat
             longitude:(float)lon
                 title:(NSString *)title
              subtitle:(NSString *)subtitle
                  kind:(NSString *)kind
                  info:(NSString *)info
                   pic:(NSString *)pic;

{
    self = [super init];
    if (self) {
        _coordinate = CLLocationCoordinate2DMake(lat, lon);
        _title = title;
        _subtitle = subtitle;
        _kind = kind;
    }
    return self;
}


@end
