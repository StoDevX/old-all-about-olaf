//
//  CourseDetailTableViewController.m
//  All About Olaf
//
//  Created by Drew Volz on 8/1/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "CourseDetailTableViewController.h"
#import "MyCoursesTableViewController.h"
#import "Course.h"
@interface CourseDetailTableViewController ()

@end

@implementation CourseDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Detail";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    Course* item = self.detailCourse;
    
    // Return cells with data/labels
    if (row == 0 && section == 0)
    {
        cell.textLabel.text = item.courseName;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 1)
    {
        cell.textLabel.text = item.courseNum;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 2)
    {
        cell.textLabel.text = item.courseTime;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
        
    }
    else if (row == 0 && section == 3)
    {
        cell.textLabel.text = item.courseLoc;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 4)
    {
        cell.textLabel.text = item.courseInstructor;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }

    cell.textLabel.font=[UIFont systemFontOfSize:13.0];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 2 && indexPath.row == 0) {
        return 54.0;
    }
    else{
        return 44;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Course Name", @"Course Name");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Department/Number/Section", @"Department/Number/Section");
            break;
        case 2:
            sectionName = NSLocalizedString(@"Meeting Times", @"Meeting Times");
            break;
        case 3:
            sectionName = NSLocalizedString(@"Meeting Locations", @"Meeting Locations");
            break;
        case 4:
            sectionName = NSLocalizedString(@"Instructors", @"Instructors");
            break;
    }
    return sectionName;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
