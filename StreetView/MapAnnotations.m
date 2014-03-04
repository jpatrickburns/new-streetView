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
    return [NSString stringWithFormat:@"MapAnnotation containing:\r lat:%f\r lon:%f\r title:%@\r subtitle:%@\r  kind:%@",_coordinate.latitude, _coordinate.longitude,_title,_subtitle, _kind];
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
    NSString *title = [decoder decodeObjectForKey:@"title"];
    NSString *subtitle = [decoder decodeObjectForKey:@"subtitle"];
    NSString *info = [decoder decodeObjectForKey:@"info"];
    NSString *pic = [decoder decodeObjectForKey:@"pic"];
    NSString *kind = [decoder decodeObjectForKey:@"kind"];
    float lat= [decoder decodeDoubleForKey:@"lat"];
    float lon= [decoder decodeDoubleForKey:@"lon"];
    
    self = [self initWithLatitude:lat longitude:lon title:title];
    self.subtitle = subtitle;
    self.info = info;
    self.pic = pic;
    self.kind = kind;
    return self;
}

- (NSUInteger)hash
{
    return [self.title hash];
}

-(BOOL)isEqual:(id)other
{
    return [[self title] isEqualToString:[other title]];
}
@end
