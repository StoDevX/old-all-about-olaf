//
//  MyCoursesTableViewController.m
//  All About Olaf
//
//  Created by Drew Volz on 8/1/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "MyCoursesTableViewController.h"
#import "CourseDetailTableViewController.h"
#import "CourseLoader.h"
#import "Course.h"
#import "SISTableViewController.h"

@interface MyCoursesTableViewController ()
@end

@implementation MyCoursesTableViewController
@synthesize subView;
@synthesize detailItem;
@synthesize segmentedControl;
@synthesize noInterimText;
@synthesize noSemester2Text;

// schedule
@synthesize courseNums2;
@synthesize courseNames2;
@synthesize courseTimes2;
@synthesize courseLocs2;
@synthesize courseInstructors2;
// json course array
@synthesize jsonParsedCourses;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitle:@"My Classes"];

    // Select the tab you'd like to see based on the time of year
    // Get the current date
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, yyy"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger month = [components month];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEE,"];
    NSDateFormatter *calMonth = [[NSDateFormatter alloc] init];
    [calMonth setDateFormat:@"MMM"];

    // Adjust the selected segment based on the month
    // Check Jan
    if (month == 1)
    {
        // Load Interim
        segmentedControl.selectedSegmentIndex = 1;
        [self loadCourses:@"2"];
    }
    // Check Feb - May
    else if (month >= 2 && month < 6)
    {
        // Load Semester 2
        segmentedControl.selectedSegmentIndex = 2;
        [self loadCourses:@"3"];
    }
    // Check Jun - Dec
    else if (month >= 6 && month <= 12)
    {
        // Load Semester 1
        segmentedControl.selectedSegmentIndex = 0;
        [self loadCourses:@"1"];
    }
}

- (void)loadCourses:(NSString *)term
{
    jsonParsedCourses = [[NSMutableArray alloc] init];

    // file path change to course plists
    _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory = [_paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@", @"courseInfo", term, @".json"];
    _path = [_documentsDirectory stringByAppendingPathComponent:fileName];

    NSString *jsonData = [NSString stringWithContentsOfFile:_path encoding:NSUTF8StringEncoding error:nil];

    // If the file read was unsuccessful, don't let the user continue through becasue of error. Otherwise, parse that thing.
    if (!jsonData)
    {
        // file path change to special plist
        _path = [_documentsDirectory stringByAppendingPathComponent:@"special.plist"];
        _fileManager = [NSFileManager defaultManager];
        // call up what is stored within the special plist
        if ([_fileManager fileExistsAtPath:_path])
        {
            _savedInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:_path];
        }

        // If we haven't logged-in yet, let the user know and exit
        if ([[_savedInfo objectForKey:@"loggedIn"] intValue] == 0)
        {
            CGRect frame = [[UIScreen mainScreen] bounds];
            subView = [[UIView alloc] initWithFrame:frame];
            subView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:subView];
            [self.view bringSubviewToFront:subView];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Logged-In" message:@"Please login to view your classes." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            // optional - add more buttons:
            [alert show];
        }
        // If we have logged-in, show the user something else that is not courses as there are none yet!
        else if ([[_savedInfo objectForKey:@"loggedIn"] intValue] == 1)
        {
        }
    }
    else
    {
        [subView removeFromSuperview];
        [noInterimText removeFromSuperview];
        [noSemester2Text removeFromSuperview];

        // We must check that we have the courses we want to display... so see if the contents are the same.
        // If they are the same, that means that we do not have that term yet. So display something else!

        // file path change to course plists
        _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentsDirectory = [_paths objectAtIndex:0];

        NSString *fileName1 = [NSString stringWithFormat:@"%@%@%@", @"courseInfo", @"1", @".json"];
        _path1 = [_documentsDirectory stringByAppendingPathComponent:fileName1];
        NSString *checkFile1 = [NSString stringWithContentsOfFile:_path1 encoding:NSUTF8StringEncoding error:nil];

        NSString *fileName2 = [NSString stringWithFormat:@"%@%@%@", @"courseInfo", @"2", @".json"];
        _path2 = [_documentsDirectory stringByAppendingPathComponent:fileName2];
        NSString *checkFile2 = [NSString stringWithContentsOfFile:_path2 encoding:NSUTF8StringEncoding error:nil];

        NSString *fileName3 = [NSString stringWithFormat:@"%@%@%@", @"courseInfo", @"3", @".json"];
        _path3 = [_documentsDirectory stringByAppendingPathComponent:fileName3];
        NSString *checkFile3 = [NSString stringWithContentsOfFile:_path3 encoding:NSUTF8StringEncoding error:nil];

        // Check if we do not have that term registered for (same file twice will be downloaded)

        // Interim
        if (([checkFile1 isEqual:checkFile2]) && segmentedControl.selectedSegmentIndex == 1)
        {
            // Hide other labels
            [noSemester2Text removeFromSuperview];

            // Hide what should display (it is a duplicated plist)
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = [UIScreen mainScreen].bounds.size.height;

            // Disable scrolling
            [self.tableView setScrollEnabled:NO];

            // White subview
            CGRect frame = CGRectMake(0, 30, width, height);
            subView = [[UIView alloc] initWithFrame:frame];
            subView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:subView];
            [self.view bringSubviewToFront:subView];

            // No Interim Courses found text
            noInterimText = [[UILabel alloc] initWithFrame:CGRectMake(65, 150, 300, 100)];
            noInterimText.text = @"No Classes Found";
            noInterimText.numberOfLines = 0;
            noInterimText.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
            noInterimText.textColor = [UIColor blackColor];
            [self.view addSubview:noInterimText];
            [self.view bringSubviewToFront:noInterimText];
        }
        // Semester II
        else if (([checkFile1 isEqual:checkFile3] || [checkFile2 isEqual:checkFile3]) && segmentedControl.selectedSegmentIndex == 2)
        {
            // Hide other labels
            [noInterimText removeFromSuperview];

            // Hide what should display (it is a duplicated plist)
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = [UIScreen mainScreen].bounds.size.height;

            // Disable scrolling
            [self.tableView setScrollEnabled:NO];

            CGRect frame = CGRectMake(0, 30, width, height);
            subView = [[UIView alloc] initWithFrame:frame];
            subView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:subView];
            [self.view bringSubviewToFront:subView];

            // No Semester II Courses found text
            noSemester2Text = [[UILabel alloc] initWithFrame:CGRectMake(65, 150, 300, 100)];
            noSemester2Text.text = @"No Classes Found";
            noSemester2Text.numberOfLines = 0;
            noSemester2Text.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
            noSemester2Text.textColor = [UIColor blackColor];
            [self.view addSubview:noSemester2Text];
            [self.view bringSubviewToFront:noSemester2Text];
        }

        // file path change to course plists
        _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentsDirectory = [_paths objectAtIndex:0];
        NSString *fileName = [NSString stringWithFormat:@"%@%@%@", @"courseInfo", term, @".json"];
        _path = [_documentsDirectory stringByAppendingPathComponent:fileName];

        // saved json file from CourseLoader
        NSData *jsonData2 = [[NSData alloc] init];
        jsonData2 = [[NSData alloc] initWithContentsOfFile:_path];

        // throw that puppy into an array and parse it
        NSArray *arr = [[NSArray alloc] init];
        arr = [NSJSONSerialization JSONObjectWithData:jsonData2 options:NSJSONReadingMutableContainers error:nil];

        // Pull out each entry from our json array and assign it into an array
        for (int i = 0; i < arr.count; ++i)
        {
            courseNames2 = [arr valueForKey:@"name"];
            courseNums2 = [arr valueForKey:@"course"];
            courseLocs2 = [arr valueForKey:@"location"];
            courseTimes2 = [arr valueForKey:@"time"];
            courseInstructors2 = [arr valueForKey:@"instructor"];
        }

        // Recombine each entry from our arrays into Course objects into a course array
        for (int i = 0; i < courseNames2.count; i++)
        {
            // We will create courseNames.count Course objects
            Course *item = [[Course alloc] init];

            item.courseName = courseNames2[i];             // name
            item.courseNum = courseNums2[i];               // number
            item.courseTime = courseTimes2[i];             // time
            item.courseLoc = courseLocs2[i];               // location
            item.courseInstructor = courseInstructors2[i]; // instructor

            [jsonParsedCourses addObject:item];
        }
    }

    if (segmentedControl.selectedSegmentIndex == 0)
    {
        // Hide other labels
        [noInterimText removeFromSuperview];
        [noSemester2Text removeFromSuperview];

        // Enable scrolling
        [self.tableView setScrollEnabled:YES];
    }

    [self.tableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)changeTerm
{
    // Now check which one of the buttons has been pressed
    // Semester 1
    if (segmentedControl.selectedSegmentIndex == 0)
    {
        // Load Semester 1 plist
        [self loadCourses:@"1"];
    }

    // Interim
    if (segmentedControl.selectedSegmentIndex == 1)
    {
        // Load Interim plist
        [self loadCourses:@"2"];
    }

    // Semester 2
    if (segmentedControl.selectedSegmentIndex == 2)
    {
        // Load Semester 2 plist
        [self loadCourses:@"3"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return jsonParsedCourses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Course *item2 = self.jsonParsedCourses[indexPath.row];

    // Our paseed-over Course objects from the other view
    item2 = self.jsonParsedCourses[indexPath.row];
    // Label: course name
    cell.textLabel.text = item2.courseName;

    // Label: course time, course location,
    NSString *theRealDeal = [NSString stringWithFormat:@"%@%@%@", item2.courseLoc, @"\n", item2.courseTime];
    cell.detailTextLabel.text = theRealDeal;

    cell.textLabel.numberOfLines = 0;       // allows text-wrapping
    cell.detailTextLabel.numberOfLines = 0; // allows text-wrapping
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showClass"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Course *theObject = self.jsonParsedCourses[indexPath.row];
        [[segue destinationViewController] setDetailCourse:theObject];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94.0;
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

@end
