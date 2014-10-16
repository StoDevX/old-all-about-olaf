//
//  Annotation.h
//  St. Olaf
//
//  Created by Drew Volz on 7/28/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
	iCodeBlogAnnotationTypeApple = 0,
	iCodeBlogAnnotationTypeEDU = 1,
	iCodeBlogAnnotationTypeTaco = 2
} iCodeMapAnnotationType;

@interface Annotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
	iCodeMapAnnotationType annotationType;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic) iCodeMapAnnotationType annotationType;

@end
