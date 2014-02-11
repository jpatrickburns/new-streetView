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

{
    self = [super init];
    if (self) {
        _coordinate = CLLocationCoordinate2DMake(lat, lon);
        _title = title;
    }
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"Annotation containing:\r lat:%f\r lon:%f\r title:%@\r subtitle:%@ and Kind:%@",self.coordinate.latitude, self.coordinate.longitude,self.title,self.subtitle, self.kind];
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
[encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_subtitle forKey:@"subtitle"];
    [encoder encodeObject:_info forKey:@"info"];
    [encoder encodeObject:_pic forKey:@"pic"];
    [encoder encodeObject:_kind forKey:@"kind"];
    [encoder encodeDouble:_coordinate.latitude forKey:@"lat"];
    [encoder encodeDouble:_coordinate.longitude forKey:@"lon"];


}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self)
    {
        self.title = [decoder decodeObjectForKey:@"title"];
        self.subtitle = [decoder decodeObjectForKey:@"subtitle"];
        self.info = [decoder decodeObjectForKey:@"info"];
        self.pic = [decoder decodeObjectForKey:@"pic"];
        self.kind = [decoder decodeObjectForKey:@"kind"];
        self.coordinate= CLLocationCoordinate2DMake([decoder decodeDoubleForKey:@"lat"],
                                                    [decoder decodeDoubleForKey:@"lon"]);
    }
    
    return self;
}

@end
