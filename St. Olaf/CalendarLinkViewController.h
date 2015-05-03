//
//  CalendarLinkViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/14/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogCal.h"
#import <EventKit/EventKit.h>

@interface CalendarLinkViewController : UITableViewController <UIActionSheetDelegate>
{
    NSMutableArray *_EventArray;
    UIActionSheet *AddEventSheet;
    NSInteger selectedRow;
}

@property (nonatomic, assign) NSInteger selectedRow;
@property (strong, nonatomic) GoogCal *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (void)LoadCalendarData;
- (void)AddEventToCalendar;
- (IBAction)cancel:(id)sender;

@end
