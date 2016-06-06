//
//  CalendarLinkViewContoller.m
//  St. Olaf
//
//  Created by Drew Volz on 8/21/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "CalendarLinkViewController.h"
#import "SecondViewController.h"
#import "GoogCal.h"
#import "ISO8601DateFormatter.h"

@interface CalendarLinkViewController ()
@end

@implementation CalendarLinkViewController
@synthesize selectedRow;

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
    return 5;
}

// How many rows in the table? Hard coded to 2 here
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormat setLocale:locale];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];

    GoogCal *theEvent = (GoogCal *)self.detailItem;

    NSString *startDateStr = [dateFormat stringFromDate:theEvent.StartDate];
    NSString *endDateStr = [dateFormat stringFromDate:theEvent.EndDate];

    NSString *hoursOpen;
    [dateFormat setDateFormat:@"h:mm a"];
    hoursOpen = [NSString stringWithFormat:@"%@ - %@",
                                           [dateFormat stringFromDate:theEvent.StartDate], [dateFormat stringFromDate:theEvent.EndDate]];
    [dateFormat setDateFormat:@"MMM d h:mm a"];

    NSString *title = theEvent.Title;
    NSString *location = theEvent.Location;

    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];

    // Dequeue a cell using a common ID string of your choosing
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    // Hide seperators
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Move table down from top of screen
    self.tableView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);

    // Return cells with data/labels
    if (row == 0 && section == 0)
    {
        cell.textLabel.text = title;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 1)
    {
        // If this event lasts more than one day...
        if (!([startDateStr isEqualToString:endDateStr]))
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@%@", startDateStr, @" to ", endDateStr];
            cell.textLabel.numberOfLines = 0;
            CGSizeMake(380.0f, MAXFLOAT);
        }
        // If this event lasts one or less days...
        else
        {
            cell.textLabel.text = startDateStr;
            cell.textLabel.numberOfLines = 0;
            CGSizeMake(380.0f, MAXFLOAT);
        }
    }
    else if (row == 0 && section == 2)
    {
        cell.textLabel.text = hoursOpen;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 3)
    {
        cell.textLabel.text = location;
        cell.textLabel.numberOfLines = 0;
        CGSizeMake(380.0f, MAXFLOAT);
    }
    else if (row == 0 && section == 4)
    {
        float tableViewWidth = self.view.frame.size.width;

        UIColor *buttonBG = [UIColor colorWithWhite:0.70 alpha:1];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = [indexPath row];

        [button addTarget:self action:@selector(ShowEventAddSheet:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:buttonBG];

        [button setTitle:@"Add to calendar" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];

        button.frame = CGRectMake(0, 0, tableViewWidth, 60.0);
        [cell addSubview:button];

        CGSizeMake(380.0f, MAXFLOAT);
    }

    cell.textLabel.font = [UIFont systemFontOfSize:13.0];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 18.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
    case 0:
        sectionName = NSLocalizedString(@"Event", @"Event");
        break;
    case 1:
        sectionName = NSLocalizedString(@"Date", @"Date");
        break;
    case 2:
        sectionName = NSLocalizedString(@"Time", @"Time");
        break;
    case 3:
        sectionName = NSLocalizedString(@"Location", @"Location");
        break;
    case 4:
        sectionName = NSLocalizedString(@"Calendar", @"Calendar");
        break;
    }
    return sectionName;
}

- (IBAction)ShowEventAddSheet:(id)sender
{
    NSInteger tid = ((UIControl *)sender).tag;
    selectedRow = tid;
    AddEventSheet = [[UIActionSheet alloc] initWithTitle:@"Add this event to your calendar?"
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@"Add to calendar", nil];
    // Show the sheet
    [AddEventSheet showInView:self.view];
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
    EKEventStore *es = [[EKEventStore alloc] init];
    EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    BOOL needsToRequestAccessToEventStore = (authorizationStatus == EKAuthorizationStatusNotDetermined);

    if (needsToRequestAccessToEventStore)
    {
        [es requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (granted) {
                // Access granted
                [es requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
                    if (!granted) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Calendar Permissions" message:@"Please change your permissions in Settings > Privacy > Calendar to allow this app access." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                        // optional - add more buttons:
                        [alert show];
                    } else {
                        GoogCal *calEvent = [[GoogCal alloc]init];
                        
                        calEvent = [_EventArray objectAtIndex:selectedRow];
                        EKEvent *event  = [EKEvent eventWithEventStore:es];
                        
                        event.title     = calEvent.Title;
                        event.location  = calEvent.Location;
                        event.startDate = calEvent.StartDate;
                        event.endDate   = calEvent.EndDate;
                        
                        [event setCalendar:[es defaultCalendarForNewEvents]];
                        NSError *err;
                        [es saveEvent:event span:EKSpanThisEvent error:&err];
                    }
                }];
            } else {
                // Denied
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Calendar Permissions" message:@"Please change your permissions in Settings > Privacy > Calendar to allow this app access." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                // optional - add more buttons:
                [alert show];
            }
        }];
    }
    else
    {
        BOOL granted = (authorizationStatus == EKAuthorizationStatusAuthorized);
        if (granted)
        {
            // Access granted
            GoogCal *calEvent = (GoogCal *)self.detailItem;

            EKEvent *event = [EKEvent eventWithEventStore:es];
            event.title = calEvent.Title;

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"The event has been added to your calendar." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            // optional - add more buttons:
            [alert show];

            event.startDate = calEvent.StartDate;
            event.endDate = calEvent.EndDate;
            [event setLocation:calEvent.Location];

            [event setCalendar:[es defaultCalendarForNewEvents]];
            NSError *err;
            [es saveEvent:event span:EKSpanThisEvent error:&err];
        }
        else
        {
            // Denied
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Calendar Permissions" message:@"Please change your permissions in Settings > Privacy > Calendar to allow this app access." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            // optional - add more buttons:
            [alert show];
        }
    }
}

@end
