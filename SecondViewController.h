//
//  SecondViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/NSJSONSerialization.h>
#import <UIKit/UIKit.h>
#import "GoogCal.h"
#import <EventKit/EventKit.h>

// URL to fetch 25 events
#define kGoogleCalendarURL [NSURL URLWithString: @"https://www.googleapis.com/calendar/v3/calendars/le6tdd9i38vgb7fcmha0hu66u9gjus2e%40import.calendar.google.com/events?key=AIzaSyDMqNx0x1pNZ80pmu2HvCMMFX-KVjdwbxs&orderBy=startTime&maxResults=25&singleEvents=true&futureevents=true"]
// Queue priority
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1


@interface SecondViewController : UITableViewController<UIActionSheetDelegate>
{
    NSMutableArray *_EventArray;
    UIActionSheet *AddEventSheet;
    NSInteger selectedRow;
    
}

@property (nonatomic, retain) NSMutableArray *EventArray;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, retain) UIView *subView;


-(void)LoadCalendarData;
-(void)AddEventToCalendar;
-(IBAction)cancel:(id)sender;
@end
