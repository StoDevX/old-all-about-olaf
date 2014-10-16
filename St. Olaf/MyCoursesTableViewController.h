//
//  MyCoursesTableViewController.h
//  All About Olaf
//
//  Created by Drew Volz on 8/1/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseLoader.h"
#import "Course.h"

@interface MyCoursesTableViewController : UITableViewController 
@property (nonatomic, retain) UIView *subView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)changeTerm;

@property (strong, nonatomic) NSArray *detailItem;
@property (strong, nonatomic) NSUserDefaults *prefs;

@property (strong, nonatomic) UILabel  *noInterimText;
@property (strong, nonatomic) UILabel  *noSemester2Text;

@property (strong, nonatomic) NSMutableArray *courseNums2;
@property (strong, nonatomic) NSMutableArray *courseNames2;
@property (strong, nonatomic) NSMutableArray *courseTimes2;
@property (strong, nonatomic) NSMutableArray *courseLocs2;
@property (strong, nonatomic) NSMutableArray *courseInstructors2;

@property (strong, nonatomic) NSMutableArray *jsonParsedCourses;

@property (strong, nonatomic) NSArray *paths;
@property (strong, nonatomic) NSString *documentsDirectory;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *path1;
@property (strong, nonatomic) NSString *path2;
@property (strong, nonatomic) NSString *path3;

@property (strong, nonatomic) NSFileManager *fileManager;
@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) NSMutableDictionary *savedInfo;
@end
