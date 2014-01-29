//
//  LoadObjectsFromFile.m
//  mapFun
//
//  Created by James Burns on 3/23/12.
//  Copyright (c) 2012 James Burns [design]. All rights reserved.
//

#import "LoadObjectsFromFile.h"

@implementation LoadObjectsFromFile

+ (id)loadFromFile:(NSString *)name ofType:(NSString *)kind
{
    NSLog(@"In the LoadObjectsFromFile class, with %@ as my filename.",name);
    //make path to plist in bundle
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:kind];
    //fill dictionary object with contents of file
    NSDictionary *contents = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    
if (!contents) {
       NSLog(@"Error reading Plist: %@", name);
   }
    
    return contents;
}

@end
