//
//  CourseLoader.h
//  All About Olaf
//
//  Created by Drew Volz on 8/2/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CourseLoaderCompleteBlock)(NSArray *results);

@interface CourseLoader : NSObject

@property (strong, nonatomic) NSData *scheduleData;

@property (strong, nonatomic) NSMutableArray *courseNums;
@property (strong, nonatomic) NSMutableArray *courseNames;
@property (strong, nonatomic) NSMutableArray *courseTimes;
@property (strong, nonatomic) NSMutableArray *courseLocs;
@property (strong, nonatomic) NSMutableArray *courseInstructors;

@property (strong, nonatomic) NSString *jsonFinalString;

@property (strong, nonatomic) NSMutableDictionary *courseDict;
@property (strong, nonatomic) NSString *courseNum;
@property (strong, nonatomic) NSString *courseName;
@property (strong, nonatomic) NSString *courseTime;
@property (strong, nonatomic) NSString *courseLoc;
@property (strong, nonatomic) NSString *courseInstructor;

@property (strong, nonatomic) NSMutableArray *dictArray;

@property (strong, nonatomic) NSArray *paths;
@property (strong, nonatomic) NSString *documentsDirectory;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSFileManager *fileManager;
@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) NSMutableDictionary *savedInfo;

- (void)fetchCourses:(NSString *)foo complete:(CourseLoaderCompleteBlock)c;

@end
