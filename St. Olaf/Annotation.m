//
//  Annotation.m
//  St. Olaf
//
//  Created by Drew Volz on 7/28/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "Annotation.h"

@interface Annotation ()
@end

@implementation Annotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize annotationType;

-init
{
	return self;
}

-initWithCoordinate:(CLLocationCoordinate2D)inCoord
{
	coordinate = inCoord;
	return self;
}

@end

