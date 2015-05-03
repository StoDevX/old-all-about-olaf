//
//  SecondViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/NSJSONSerialization.h>
#import "GoogCal.h"
#import <EventKit/EventKit.h>

// Queue priority
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define key @"AIzaSyDMqNx0x1pNZ80pmu2HvCMMFX-KVjdwbxs"                         // Google Developer Console API Key

@interface SecondViewController : UITableViewController <UIActionSheetDelegate>
{
    NSMutableArray *_EventArray;
    UIActionSheet *AddEventSheet;
    NSInteger selectedRow;
}

@property (nonatomic, retain) NSMutableArray *EventArray;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, retain) UIView *subView;

- (void)LoadCalendarData;
- (void)AddEventToCalendar;
- (IBAction)cancel:(id)sender;
@end
