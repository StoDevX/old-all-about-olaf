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
@synthesize EventArray = _EventArray;
@synthesize selectedRow;
@synthesize subView;
@synthesize tableView;

#define CELL_CONTENT_MARGIN 10.0f

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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
    
    if([self hasConnectivity] == NO) {
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        subView = [[UIView alloc] initWithFrame:frame];
        subView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:subView];
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    else if([self hasConnectivity] == YES)
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

-(IBAction)cancel:(id)sender{
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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    /*
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     
     // If we are pushing the menu webview, make it full screen
     if( indexPath.row == 0) {
     self.hidesBottomBarWhenPushed = NO;
     }
     */
    
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

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


// Auto calculate the height of the cells
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoogCal *eventLcl = (GoogCal *)[_EventArray objectAtIndex:[indexPath row]];
    NSString *text = eventLcl.Title;
    UIFont *systemFont = [UIFont systemFontOfSize:16];
    
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    CGSize expectedLabelSize = [text sizeWithFont:systemFont constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeCharacterWrap];
    
    //adjust the label the the new height.
    return expectedLabelSize.height + 80;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_EventArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // If we have an empty cell, bind it to the identifying cell we setup called "Cell"
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    // Handle the duplicate custom labels that appear when scrolling by removing them when the cell disappears
    for (UIView *v in [cell.contentView subviews])
    {
        [v removeFromSuperview];
    }
    
    
    // Configure the cell...
    GoogCal *eventLcl = (GoogCal *)[_EventArray objectAtIndex:[indexPath row]];
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormat setLocale:locale];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    // Make the calendar look like Apple's... ex: Mon  Nov 5
    [dateFormat setDateFormat:@"E  MMM d"];

    NSString *startDateStr = [dateFormat stringFromDate:eventLcl.StartDate];
    NSString *endDateStr = [dateFormat stringFromDate:eventLcl.EndDate];
    
    [dateFormat setDateFormat:@"h:mm a"];
    
    NSString *hourStart = [dateFormat stringFromDate:eventLcl.StartDate];
    NSString *hourEnd = [dateFormat stringFromDate:eventLcl.EndDate];
    
    
    // The header view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 23)];
    // Create custom view to display section header
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 25)];
    [label setFont:[UIFont boldSystemFontOfSize:16]];
    label.textColor = [UIColor blackColor];
    // Section header
    
    // If this event lasts more than one day...
    if( [startDateStr isEqualToString: endDateStr] ) {
        [label setText: startDateStr];
    }
    // If this event lasts one or less days...
    else {
        [label setText: [NSString  stringWithFormat:@"%@%@%@", startDateStr, @"  -  ", endDateStr]];
    }

    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.0]];
    [cell addSubview:view];
    
    
    // Hours label
    // Start hour
    UILabel *hourStartLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 10, 100, 90)];
    hourStartLabel.textColor = [UIColor blackColor];
    [hourStartLabel setFont:[UIFont systemFontOfSize:13]];
    hourStartLabel.backgroundColor=[UIColor clearColor];
    hourStartLabel.text= hourStart;
    [cell.contentView addSubview:hourStartLabel];
    // End hour
    UILabel *hourEndLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 25, 100, 90)];
    hourEndLabel.textColor = [UIColor lightGrayColor];
    [hourEndLabel setFont:[UIFont systemFontOfSize:13]];
    hourEndLabel.backgroundColor=[UIColor clearColor];
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@", @"\n", eventLcl.Title];
    
    
    /* Hide UISelection on table view cells...hackery to hide mysterious duplicate (incorrect) labels on selection.
     * Go ahead. Comment this guy out and see what I mean. Man. Whoever wrote this needs to be yelled at...
     */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(IBAction)ShowEventAddSheet:(id)sender
{
    NSInteger tid = ((UIControl*)sender).tag;
    selectedRow = tid;
    AddEventSheet = [[UIActionSheet alloc] initWithTitle:@"Add this event to your calendar?"
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@"Add To Calendar", nil];
    // Show the sheet
    [AddEventSheet showInView:self.view];
    
}

-(void)LoadCalendarData
{
    dispatch_sync(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: kGoogleCalendarURL];

        
        if ( !( data == NULL)) {
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            // optional - add more buttons:
            [alert show];
        }
    });
    
}


- (void)fetchedData:(NSData *)responseData {
    _EventArray = [[NSMutableArray alloc]init];
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          options:kNilOptions
                          error:&error];

    
    NSDictionary* latestEvents = [json objectForKey:@"feed"];

    NSArray* arrEvent = [latestEvents objectForKey:@"entry"];
    
    for (NSDictionary *event in arrEvent)
    {
        GoogCal *googCalObj = [[GoogCal alloc]init];
        
        NSDictionary *title = [event objectForKey:@"title"];
        googCalObj.Title = [title objectForKey:@"$t"];
        // Clean up the HTML (if any) in the title
        googCalObj.Title = [googCalObj.Title stripHtml];

        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale;
        enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormat setLocale:enUSPOSIXLocale];
        [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        
        //dates are stored in an array
        NSArray *dateArr = [event objectForKey:@"gd$when"];
        
        for(NSDictionary *dateDict in dateArr)
        {
            NSLocale *enUSPOSIXLocale;
            enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
            
            NSDate *endDate = [formatter dateFromString:[dateDict objectForKey:@"endTime"]];
            NSDate *startDate = [formatter dateFromString:[dateDict objectForKey:@"startTime"]];
            
            formatter = nil;
            
            googCalObj.EndDate = endDate; //[endDate addTimeInterval:-3600*6];
            googCalObj.StartDate = startDate; //[startDate addTimeInterval:-3600*6];
        }
        
        
        //locations are stored in a dictionary
        NSDictionary *locs = [event objectForKey:@"gd$where"][0];
        googCalObj.Location = [locs objectForKey:@"valueString"];
        
        //content is stored in a dictionary
        NSDictionary *content = [event objectForKey:@"content"];
        googCalObj.Description = [content objectForKey:@"$t"];

        
        [_EventArray addObject:googCalObj];
    }
}


#pragma mark - Action Sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self AddEventToCalendar];
    }
}

-(void)AddEventToCalendar
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    GoogCal *calEvent = [[GoogCal alloc]init];
    
    calEvent = [_EventArray objectAtIndex:selectedRow];
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    event.title     = calEvent.Title;
    
    event.startDate = calEvent.StartDate;
    event.endDate   = calEvent.EndDate;
    [event setLocation:calEvent.Location];
    [event setNotes:calEvent.Description];

    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
}


// Pass the calendar data collected to the detail view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    GoogCal *object = self.EventArray[indexPath.row];
        
    if ([[segue identifier] isEqualToString:@"showMore"]) {
        [[segue destinationViewController] setDetailItem: object];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
}


/*
 Connectivity testing code pulled from Apple's Reachability Example: http://developer.apple.com/library/ios/#samplecode/Reachability
 */
-(BOOL)hasConnectivity {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
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
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
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
