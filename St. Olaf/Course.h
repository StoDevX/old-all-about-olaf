//
//  Course.h
//  All About Olaf
//
//  Created by Drew Volz on 8/2/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (strong, nonatomic) NSString *courseNum;
@property (strong, nonatomic) NSString *courseName;
@property (strong, nonatomic) NSString *courseTime;
@property (strong, nonatomic) NSString *courseLoc;
@property (strong, nonatomic) NSString *courseInstructor;

@property (strong, nonatomic) NSAttributedString *cellMessage;

@end

