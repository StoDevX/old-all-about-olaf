//
//  SecondViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "SecondViewController.h"
#import "CalendarLinkViewController.h"
#import "ISO8601DateFormatter.h"
#import "NSString_stripHtml.h"
#import "DetailViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation SecondViewController
@synthesize selectedRow;
@synthesize subView;
@synthesize tableView;

NSString *prevDateHeader = @"";
NSInteger arrIndexCount = 0;
NSMutableArray *arrOfDateArrays;
NSMutableArray *dateOfevents;
NSArray *uniqueDateArray;

#define CELL_CONTENT_MARGIN 10.0f

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Remove line separator
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    if ([self hasConnectivity] == NO)
    {
        CGRect frame = [[UIScreen mainScreen] bounds];
        subView = [[UIView alloc] initWithFrame:frame];
        subView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:subView];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    else if ([self hasConnectivity] == YES)
    {
        // Load the calendar
        [self LoadCalendarData];
    }

    //self.tableView.rowHeight = 100;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    // Clear selection of rows
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

// Auto calculate the height of the cells
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoogCal *eventLcl = (GoogCal *)[arrOfDateArrays[indexPath.section] objectAtIndex:[indexPath row]];
    NSString *text = eventLcl.Title;
    UIFont *systemFont = [UIFont systemFontOfSize:16];

    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    CGSize expectedLabelSize = [text sizeWithFont:systemFont constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeCharacterWrap];

    //adjust the label the the new height.
    return expectedLabelSize.height + 40;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrOfDateArrays count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   return [[arrOfDateArrays objectAtIndex:section] count];
}

// Header Titles Setion Heights
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

// Headers for tableview cells
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *dateStr = [uniqueDateArray objectAtIndex:section];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M/d/yy"];
    
    NSDate *date = [dateFormatter dateFromString: dateStr];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E  MMM d"];
    
    NSString *convertedString = [dateFormatter stringFromDate:date];
    
    return convertedString;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"Cell"];

    // If we have an empty cell, bind it to the identifying cell we setup called "Cell"
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }

    // Handle the duplicate custom labels that appear when scrolling by removing them when the cell disappears
    for (UIView *v in [cell.contentView subviews])
    {
        [v removeFromSuperview];
    }

    // Configure the cell...
    GoogCal *eventLcl = (GoogCal *)[arrOfDateArrays[indexPath.section] objectAtIndex:[indexPath row]];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormat setLocale:locale];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    // Make the calendar look like Apple's... ex: Mon  Nov 5
    [dateFormat setDateFormat:@"E  MMM d"];

    [dateFormat setDateFormat:@"h:mm a"];

    NSString *hourStart = [dateFormat stringFromDate:eventLcl.StartDate];
    NSString *hourEnd = [dateFormat stringFromDate:eventLcl.EndDate];
    

    // Hours label
    // Start hour
    UILabel *hourStartLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, -20, 100, 90)];
    hourStartLabel.textColor = [UIColor blackColor];
    [hourStartLabel setFont:[UIFont systemFontOfSize:13]];
    hourStartLabel.backgroundColor = [UIColor clearColor];
    hourStartLabel.text = hourStart;
    [cell.contentView addSubview:hourStartLabel];
    // End hour
    UILabel *hourEndLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, -5, 100, 90)];
    hourEndLabel.textColor = [UIColor lightGrayColor];
    [hourEndLabel setFont:[UIFont systemFontOfSize:13]];
    hourEndLabel.backgroundColor = [UIColor clearColor];
    hourEndLabel.text = hourEnd;
    [cell.contentView addSubview:hourEndLabel];

    // Event name label
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.numberOfLines = 0;
    // Move the event text over to the side of the time label
    cell.indentationWidth = 70.0;
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    // Assign the text...while hackily moving it down in the cell 2 lines
    cell.textLabel.text = [NSString stringWithFormat:@"%@", eventLcl.Title];

    /* Hide UISelection on table view cells...hackery to hide mysterious duplicate (incorrect) labels on selection.
     * Go ahead. Comment this guy out and see what I mean. Man. Whoever wrote this needs to be yelled at...
     */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (IBAction)ShowEventAddSheet:(id)sender
{
    NSInteger tid = ((UIControl *)sender).tag;
    selectedRow = tid;
    AddEventSheet = [[UIActionSheet alloc] initWithTitle:@"Add this event to your calendar?"
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@"Add To Calendar", nil];
    // Show the sheet
    [AddEventSheet showInView:self.view];
}

- (void)LoadCalendarData
{
    dispatch_sync(kBgQueue, ^{
        // We must construct a datetime stamp with a T in the middle
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateIs = [DateFormatter stringFromDate:[NSDate date]];
        [DateFormatter setDateFormat:@"HH:mm:ss"];
        NSString *timeIs = [DateFormatter stringFromDate:[NSDate date]];

        NSString *dateAndTimeIs = [NSString stringWithFormat:@"%@%@%@%@", dateIs, @"T", timeIs, @".03Z"];
        
        // URL to fetch 25 events
        NSString *kGoogleCalendarStr = [NSString stringWithFormat:
                             @"https://www.googleapis.com/calendar/v3/calendars/le6tdd9i38vgb7fcmha0hu66u9gjus2e@import.calendar.google.com/events?key=%@&orderBy=startTime&timeMin=%@&maxResults=25&singleEvents=true",
                             key,
                             dateAndTimeIs];
        
        NSURL *kGoogleCalendarURL = [NSURL URLWithString: kGoogleCalendarStr];
        
        
        NSData* data = [NSData dataWithContentsOfURL: kGoogleCalendarURL];
        
        if ( !( data == NULL)) {
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"A Problem Occurred" message:@"Please try again later." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            // optional - add more buttons:
            [alert show];
        }
    });
}

- (void)fetchedData:(NSData *)responseData
{
    // Initialize
    arrOfDateArrays = [[NSMutableArray alloc] init];
    [arrOfDateArrays removeAllObjects];
    
    arrIndexCount = 0;
    
    //parse out the json data
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
        JSONObjectWithData:responseData //1
                   options:kNilOptions
                     error:&error];

    dateOfevents = [[NSMutableArray alloc] init];
    NSDictionary *latestEvents = [json objectForKey:@"items"];

    for (NSDictionary *event in latestEvents)
    {
        // Calendar object
        GoogCal *googCalObj = [[GoogCal alloc] init];

        // Event title
        googCalObj.Title = [event objectForKey:@"summary"];

        // Clean up the HTML (if any) in the title
        googCalObj.Title = [googCalObj.Title stripHtml];
        // Clean up whitespace (if any) in the title
        googCalObj.Title = [googCalObj.Title stringByTrimmingCharactersInSet:
                                                 [NSCharacterSet whitespaceCharacterSet]];

        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale;
        enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormat setLocale:enUSPOSIXLocale];
        [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

        // Dictionary to hold a start date
        NSMutableDictionary *dateArrStart2 = [event objectForKey:@"start"];
        // Start date
        NSString *dateStart;

        // If it does not contain a time (aka multiple day-spanning event...)
        if ([dateArrStart2 objectForKey:@"dateTime"] == NULL)
        {
            dateStart = [dateArrStart2 objectForKey:@"date"];
        }
        // If it does contain a time...
        else
        {
            dateStart = [dateArrStart2 objectForKey:@"dateTime"];
        }
        // Convert back to a date
        enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];

        NSDate *startDate = [formatter dateFromString:dateStart];

        // Dictionary to hold an end date
        NSMutableDictionary *dateArrEnd = [event objectForKey:@"end"];
        // Start date
        NSString *dateEnd;

        // If it does not contain a time (aka multiple day-spanning event...)
        if ([dateArrEnd objectForKey:@"dateTime"] == NULL)
        {
            dateEnd = [dateArrEnd objectForKey:@"date"];
        }
        // If it does contain a time...
        else
        {
            dateEnd = [dateArrEnd objectForKey:@"dateTime"];
        }
        // Convert back to a date
        enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter = [[ISO8601DateFormatter alloc] init];

        NSDate *endDate = [formatter dateFromString:dateEnd];
        dateFormat = nil;

        googCalObj.StartDate = startDate; //[startDate addTimeInterval:-3600*6];
        googCalObj.EndDate = endDate;     //[endDate addTimeInterval:-3600*6];
        
        //locations are stored in a dictionary
        NSString *loc = [event objectForKey:@"location"];
        googCalObj.Location = loc;
        
        
        //extract the start date and convert to string
        NSString *theEventDateStr = [NSDateFormatter localizedStringFromDate:startDate
                                                                   dateStyle:NSDateFormatterShortStyle
                                                                   timeStyle:NSDateFormatterFullStyle];
        //split string up at commas
        NSArray *arrayWithStrings = [theEventDateStr componentsSeparatedByString:@","];
        
        //add event titles to separate array (substring of just date)
        [dateOfevents addObject: arrayWithStrings[0]];
    }
    
    //get unique number of dates
    uniqueDateArray = [[NSOrderedSet orderedSetWithArray: dateOfevents] array];

    
    //get count of unique dates
    long numOfUniqueDates = [uniqueDateArray count];
    
    //create unique date number of arrays to store dates by day
    for (int i = 0; i <= numOfUniqueDates; ++i) {
        NSMutableArray *myUniqueArr$i = [[NSMutableArray alloc] init];
        [arrOfDateArrays addObject: myUniqueArr$i];
    }
    
    for (NSDictionary *event in latestEvents)
    {
        // Calendar object
        GoogCal *googCalObj = [[GoogCal alloc] init];
        
        // Event title
        googCalObj.Title = [event objectForKey:@"summary"];
        
        // Clean up the HTML (if any) in the title
        googCalObj.Title = [googCalObj.Title stripHtml];
        // Clean up whitespace (if any) in the title
        googCalObj.Title = [googCalObj.Title stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
        
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale;
        enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormat setLocale:enUSPOSIXLocale];
        [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        // Dictionary to hold a start date
        NSMutableDictionary *dateArrStart2 = [event objectForKey:@"start"];
        // Start date
        NSString *dateStart;
        
        // If it does not contain a time (aka multiple day-spanning event...)
        if ([dateArrStart2 objectForKey:@"dateTime"] == NULL)
        {
            dateStart = [dateArrStart2 objectForKey:@"date"];
        }
        // If it does contain a time...
        else
        {
            dateStart = [dateArrStart2 objectForKey:@"dateTime"];
        }
        // Convert back to a date
        enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
        
        NSDate *startDate = [formatter dateFromString:dateStart];
        
        // Dictionary to hold an end date
        NSMutableDictionary *dateArrEnd = [event objectForKey:@"end"];
        // Start date
        NSString *dateEnd;
        
        // If it does not contain a time (aka multiple day-spanning event...)
        if ([dateArrEnd objectForKey:@"dateTime"] == NULL)
        {
            dateEnd = [dateArrEnd objectForKey:@"date"];
        }
        // If it does contain a time...
        else
        {
            dateEnd = [dateArrEnd objectForKey:@"dateTime"];
        }
        // Convert back to a date
        enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter = [[ISO8601DateFormatter alloc] init];
        
        NSDate *endDate = [formatter dateFromString:dateEnd];
        dateFormat = nil;
        
        googCalObj.StartDate = startDate; //[startDate addTimeInterval:-3600*6];
        googCalObj.EndDate = endDate;     //[endDate addTimeInterval:-3600*6];
        
        //locations are stored in a dictionary
        NSString *loc = [event objectForKey:@"location"];
        googCalObj.Location = loc;
        
        
        //split string up at the timestamp to get only the date
        NSArray *arrayWithStrings = [dateStart componentsSeparatedByString:@"T"];
        
        //add the items to separated date arrays
        if (![arrayWithStrings[0] isEqualToString: prevDateHeader]) {
            arrIndexCount++;
            [arrOfDateArrays[arrIndexCount] addObject:googCalObj];
        }
        else {
            [arrOfDateArrays[arrIndexCount] addObject: googCalObj];
        }
        
        //assign the previous date header for comparison later
        prevDateHeader = arrayWithStrings[0];
    }
    //hack...fix me... remove first empty array from larger array
    [arrOfDateArrays removeObjectAtIndex:0];
}

#pragma mark - Action Sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self AddEventToCalendar];
    }
}

- (void)AddEventToCalendar
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    GoogCal *calEvent = [[GoogCal alloc] init];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

    calEvent = [arrOfDateArrays[indexPath.section] objectAtIndex:[indexPath row]];
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.title = calEvent.Title;
    event.startDate = calEvent.StartDate;
    event.endDate = calEvent.EndDate;
    [event setLocation:calEvent.Location];

    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
}

// Pass the calendar data collected to the detail view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    GoogCal *object = arrOfDateArrays[indexPath.section][indexPath.row];

    if ([[segue identifier] isEqualToString:@"showMore"])
    {
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*
 Connectivity testing code pulled from Apple's Reachability Example: http://developer.apple.com/library/ios/#samplecode/Reachability
 */
- (BOOL)hasConnectivity
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;

    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&zeroAddress);
    if (reachability != NULL)
    {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags))
        {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                return NO;
            }

            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }

            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs

                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }

            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }

    return NO;
}

@end
