//
//  InfoTableViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/21/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "InfoTableViewController.h"
#import "RSSItem3.h"

@interface InfoTableViewController ()

@end

@implementation InfoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIEdgeInsets inset = UIEdgeInsetsMake(-19, 0, 0, 0);
    self.tableView.contentInset = inset;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// How many sections in the table? Hard coded to 1 here
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

// How many rows in the table? Hard coded to 2 here
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSSItem3 *item = (RSSItem3 *)self.detailItem;

    NSString *one = item.department;
    NSString *two = item.courseNumber;
    NSString *three = item.courseSection;
    NSString *four = item.title;
    NSString *five = item.teacher;
    NSString *six = item.meetingTimes;
    NSString *seven = item.meetingLocs;
    NSString *eight = item.geReqs;
    NSString *nine = item.credits;
    NSString *ten = item.notes;

    NSString *theRealDeal = [NSString stringWithFormat:@"%@%@%@%@", one, @" ", two, three];

    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];

    // Dequeue a cell using a common ID string of your choosing
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    // Return cells with data/labels
    if (row == 0 && section == 0)
    {
        cell.textLabel.text = four;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 1)
    {
        cell.textLabel.text = theRealDeal;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 2)
    {
        cell.textLabel.text = six;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 3)
    {
        cell.textLabel.text = seven;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 4)
    {
        cell.textLabel.text = five;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 5)
    {
        cell.textLabel.text = nine;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 6)
    {
        cell.textLabel.text = eight;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 7)
    {
        cell.textLabel.text = ten;
        cell.textLabel.numberOfLines = 0;
    }

    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 0)
    {
        return 54.0;
    }
    if (indexPath.section == 7 && indexPath.row == 0)
    {
        return 86.0;
    }

    else
    {
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
    case 5:
        sectionName = NSLocalizedString(@"Credits", @"Credits");
        break;
    case 6:
        sectionName = NSLocalizedString(@"GE Requirements", @"GE Requirements");
        break;
    case 7:
        sectionName = NSLocalizedString(@"Notes", @"Notes");
        break;
    }
    return sectionName;
}

@end
