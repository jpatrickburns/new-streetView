//
//  LoadObjectsFromFile.h
//  mapFun
//
//  Created by James Burns on 3/23/12.
//  Copyright (c) 2012 James Burns [design]. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadObjectsFromFile : NSObject

+ (id)loadFromFile:(NSString *)name ofType:(NSString *)kind;

@end
