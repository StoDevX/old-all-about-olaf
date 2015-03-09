//
//  CourseDetailTableViewController.h
//  All About Olaf
//
//  Created by Drew Volz on 8/1/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import <EventKit/EventKit.h>

@interface CourseDetailTableViewController : UITableViewController<UIActionSheetDelegate>
{
    UIActionSheet *AddEventSheet;
    NSInteger selectedRow;
}

@property (strong, nonatomic) Course * detailCourse;

@property (nonatomic, assign) NSInteger selectedRow;

@end
