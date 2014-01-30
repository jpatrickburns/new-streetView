//
//  LoadObjectsFromFile.m
//  mapFun
//
//  Originally created by James Burns on 3/23/12.
//  Copyright (c) 2014 James Burns [design]. All rights reserved.
//

#import "LoadObjectsFromFile.h"

@implementation LoadObjectsFromFile

+ (id)loadFromFile:(NSString *)name ofType:(NSString *)kind
{
    //NSLog(@"In the LoadObjectsFromFile class, with %@ as my filename.",name);
    
    NSPropertyListFormat format;
    NSString *errorDesc=nil;
    
    //make path to plist in bundle
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:kind];
    //fill data object with contents of file
    NSData *myData = [[NSData alloc] initWithContentsOfFile:plistPath];
    NSDictionary *contents = [NSPropertyListSerialization propertyListFromData:myData 
                                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                                                                        format:&format
                                                              errorDescription:&errorDesc];
    if (!contents) {
        NSLog(@"Error reading Plist: %@ format: %u", errorDesc,format);
    }
    return contents;
}

@end
