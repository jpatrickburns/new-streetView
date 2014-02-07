//
//  ColorSets.h
//  StreetView
//
//  Created by James Burns on 2/7/14.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorSets : NSObject

@property  UIColor *myRed;
@property UIColor *myGreen;
@property UIColor *myGold;
@property  UIColor *myteal;
@property UIColor *currentColor;

- (UIColor *)tintColor:(UIColor *)color withSaturationFactor:(float)sat withValueFactor:(float)val
;



@end




