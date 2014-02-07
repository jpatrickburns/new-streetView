//
//  ColorSets.m
//  StreetView
//
//  Created by James Burns on 2/7/14.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import "ColorSets.h"

@implementation ColorSets


- (id)init
{
    self = [super init];
    if (self) {
        
        // set up colors
        
        _myRed = [UIColor colorWithRed:120/255.0 green:25/255.0 blue:45/255.0 alpha:1];
        _myGreen = [UIColor colorWithRed:12/255.0 green:89/255.0 blue:27/255.0 alpha:1];
        _myGold = [UIColor colorWithRed:129/255.0 green:97/255.0 blue:27/255.0 alpha:1];
        _myteal = [UIColor colorWithRed:12/255.0 green:82/255.0 blue:133/255.0 alpha:1];
    }
    return self;
}

- (UIColor *)tintColor:(UIColor *)color withSaturationFactor:(float)sat withValueFactor:(float)val
{
	// This assumes we're sending it RGBA UIColor
    
    CGFloat colorHSV[4];
    [color getHue:&colorHSV[0] saturation:&colorHSV[1] brightness:&colorHSV[2] alpha:&colorHSV[3]];
    //increase value
    colorHSV[2] = colorHSV[2]*val;
    //decrease saturation
    colorHSV[1]= colorHSV[1]*sat;
    UIColor *colorRGB = [UIColor colorWithHue:colorHSV[0] saturation:colorHSV[1] brightness:colorHSV[2] alpha:colorHSV[3]];
	return colorRGB;
}

@end
