//
//  CafScheduleViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/23/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "CafScheduleViewController.h"
#import "RSSLoader4.h"
#import "RSSItem4.h"
#import "NSString_stripHtml.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "GTMNSString+HTML.h"


#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
NSString *two;


@interface CafScheduleViewController ()
{
    NSArray *_objects;
    NSURL* feedURL;
    UIRefreshControl* refreshControl;
}
@end

@implementation CafScheduleViewController
@synthesize subView;



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.activityIndicator.hidesWhenStopped = YES;

    
    //Get the current date to display the right RSS Food Menu Item from Bon Appetit
   
    self.title = @"Stav Menu";
    
    if([self hasConnectivity] == NO) {
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        subView = [[UIView alloc] initWithFrame:frame];
        subView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:subView];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    else {
        //http://legacy.cafebonappetit.com/rss/menu/261 this is the menu for Stav Hall
        //http://legacy.cafebonappetit.com/rss/menu/262 this is the menu for The Cage
        feedURL = [NSURL URLWithString:@"http://legacy.cafebonappetit.com/rss/menu/261"];
        
        //add refresh control to the table view
        refreshControl = [[UIRefreshControl alloc] init];
        
        [refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];
        
        NSString* fetchMessage = [NSString stringWithFormat:@""];
        
        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:11.0]}];
        
        //[self.tableView addSubview: refreshControl];
        //add the header
      
        //Hide the "No Menu Text" label...
        [_noMenuText setHidden: YES];
        
        [self refreshFeed];
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

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
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


-(void) refreshInvoked:(id)sender forState:(UIControlState)state
{
    [self refreshFeed];

}


-(void)refreshFeed
{
    
    //Show activity indicators
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.activityIndicator startAnimating];
    
    RSSLoader4* rss = [[RSSLoader4 alloc] init];
    [rss fetchRssWithURL:feedURL
                complete:^(NSString *title, NSArray *results) {
                    
                    //completed fetching the RSS
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //UI code on the main queue
                        _objects = results;
                        //Check if our object has a menu
                        if (_objects.count == 0) {
                            // Display the no menu available text
                            [_noMenuText setHidden: NO];
                            // Lock scrolling
                            self.tableView.scrollEnabled = NO;
                            //NSLog(@"%lu",(unsigned long)_objects.count);
                        } else {
                            [_noMenuText setHidden: YES];
                            self.tableView.scrollEnabled = YES;
                            //NSLog(@"%lu",(unsigned long)_objects.count);
                        }

                        
                        
                        [self.tableView reloadData];
                       
                        // Stop refresh control
                        [refreshControl endRefreshing];
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        [self.activityIndicator stopAnimating];
                    });
                }];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    RSSItem4 *object = _objects[indexPath.row];
    
    //Get the current date to display the right RSS Food Menu Item from Bon Appetit
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, yyy"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger year = [components year];
    NSInteger day = [components day];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEE,"];
    NSDateFormatter *calMonth = [[NSDateFormatter alloc] init];
    [calMonth setDateFormat:@"MMM"];
    

    //Handling double-digit days
    if(day >= 10){
        
    NSString *todayIs = [NSString stringWithFormat:@"%@%@%ld%@%@%@%ld", [weekDay stringFromDate:date], @" ", (long)day, @" ", [calMonth stringFromDate:date], @" ", (long)year];
        
        //Making sure to alert on Mondays when the menu gets updated by Bon App
        //So check if the current day is Monday AND check that
        if ([@"Mon,"  isEqual: [weekDay stringFromDate:date]] && _objects.count == 0) {
            [_noMenuText setHidden: NO];
        }
        
        //Replace the HTML with the desired output
        object.contentEncoded = [object.contentEncoded stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"<h3>" withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"</h3>" withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"<h4>" withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"</h4>" withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"<p>"  withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"</p>"  withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@", "  withString:@"\n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@" ,"  withString:@"\n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&amp;#38;"  withString:@"&"];
        
        
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&amp;"  withString:@"&"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&amp;"  withString:@"&"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&#38;"  withString:@"&"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&#34;"  withString:@"\""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&#241;"  withString:@"ñ"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&nbsp;"  withString:@" "];
        
        
        //Replace these category headers to make them look like sections
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"Breakfast" withString:
                                 @"-----------------------------------------\n                      Breakfast\n-----------------------------------------\n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"Brunch" withString:
                                 @"-----------------------------------------\n                      Brunch\n-----------------------------------------\n"];
        
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"Lunch" withString:
                                 @"-----------------------------------------\n                       Lunch\n-----------------------------------------\n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"Dinner" withString:
                                 @"-----------------------------------------\n                       Dinner\n-----------------------------------------\n"];
        //Replace these category headers to make them look like titles
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[grains] " withString:@"Grains: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[grill] " withString:@"Grill: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[brunch classics] " withString:@"Brunch Classics: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[bowls] " withString:@"Bowls: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[fire & ice] " withString:@"Fire & Ice: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[fire &amp;#38; ice] " withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[grill/made to order] " withString:@"Grill: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[pizza] " withString:@"Pizza: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[vegetarian/vegan options on stations] " withString:@"Vegetarian/Vegan: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[soup of the day] " withString:@"Soup: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[pasta] " withString:@"Pasta: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[home lunch] " withString:@"Home: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[home dinner] " withString:@"Home: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[tortilla] " withString:@"Tortilla: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[hot cereal] " withString:@"Hot Cereal: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[welcome picnic Buntrock plaza] " withString:@"Welcome Picnic: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[boxed dinners - Skoglund Gym] " withString:@"Boxed Dinners - Skoglund: \n"];
        
        object.contentEncoded= [object.contentEncoded stripHtml];
        
        
        object.contentEncoded = [object.contentEncoded stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        //Check the day from the todayIs string and compare it to the feeds we've been given
        //Only print out the data for the day we want
        if([object.title isEqualToString: todayIs]){
            
            NSString *text = object.contentEncoded;
            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            cell.textLabel.text = object.contentEncoded;
            cell.textLabel.numberOfLines = 0;
            [cell setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 3044.0f))];
        }
    return cell;
}
    
    
    if(day < 10){
        NSString *two = [NSString stringWithFormat:@"%@%ld", @"0", (long)day];
        
        NSString *todayIs = [NSString stringWithFormat:@"%@%@%@%@%@%@%ld", [weekDay stringFromDate:date], @" ", two, @" ", [calMonth stringFromDate:date], @" ", (long)year];
    

        //Replace the HTML with the desired output
        object.contentEncoded = [object.contentEncoded stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"<h3>" withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"</h3>" withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"<h4>" withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"</h4>" withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"<p>"  withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"</p>"  withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@", "  withString:@"\n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@" ,"  withString:@"\n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&amp;#38;"  withString:@"&"];


        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&amp;"  withString:@"&"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&amp;"  withString:@"&"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&#38;"  withString:@"&"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&#34;"  withString:@"\""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&#241;"  withString:@"ñ"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"&nbsp;"  withString:@" "];

    
        //Replace these category headers to make them look like sections
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"Breakfast" withString:
                                 @"-----------------------------------------\n                      Breakfast\n-----------------------------------------\n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"Brunch" withString:
                                 @"-----------------------------------------\n                      Brunch\n-----------------------------------------\n"];

        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"Lunch" withString:
                                 @"-----------------------------------------\n                       Lunch\n-----------------------------------------\n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"Dinner" withString:
                                 @"-----------------------------------------\n                       Dinner\n-----------------------------------------\n"];
        //Replace these category headers to make them look like titles
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[grains] " withString:@"Grains: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[grill] " withString:@"Grill: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[brunch classics] " withString:@"Brunch Classics: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[bowls] " withString:@"Bowls: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[fire & ice] " withString:@"Fire & Ice: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[fire &amp;#38; ice] " withString:@""];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[grill/made to order] " withString:@"Grill: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[pizza] " withString:@"Pizza: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[vegetarian/vegan options on stations] " withString:@"Vegetarian/Vegan: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[soup of the day] " withString:@"Soup: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[pasta] " withString:@"Pasta: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[home lunch] " withString:@"Home: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[home dinner] " withString:@"Home: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[tortilla] " withString:@"Tortilla: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[hot cereal] " withString:@"Hot Cereal: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[welcome picnic Buntrock plaza] " withString:@"Welcome Picnic: \n"];
        object.contentEncoded = [object.contentEncoded stringByReplacingOccurrencesOfString:@"[boxed dinners - Skoglund Gym] " withString:@"Boxed Dinners - Skoglund: \n"];

        object.contentEncoded= [object.contentEncoded stripHtml];

    
        object.contentEncoded = [object.contentEncoded stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //Check the day from the todayIs string and compare it to the feeds we've been given
    //Only print out the data for the day we want
    if([object.title isEqualToString: todayIs]){
        
        NSString *text = object.contentEncoded;
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        cell.textLabel.text = object.contentEncoded;
        cell.textLabel.numberOfLines = 0;
        [cell setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 3044.0f))];
    }
   }
    return cell;
}




//Display on the cell that we want
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get the current date to display the right RSS Food Menu Item from Bon Appetit
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, yyy"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger year = [components year];
    NSInteger day = [components day];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEE,"];
    NSDateFormatter *calMonth = [[NSDateFormatter alloc] init];
    [calMonth setDateFormat:@"MMM"];
    
    
    if(day < 10){
        NSString *two = [NSString stringWithFormat:@"%@%ld", @"0", (long)day];
        
        NSString *todayIs = [NSString stringWithFormat:@"%@%@%@%@%@%@%ld", [weekDay stringFromDate:date], @" ", two, @" ", [calMonth stringFromDate:date], @" ", (long)year];
        
        //NSLog(@"%@",todayIs);
        
        RSSItem4 *object = _objects[indexPath.row];
        
        
        if([object.title isEqualToString: todayIs]){
            NSString *text = object.contentEncoded;
            CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            CGFloat height = MAX(size.height+size.height/1.4, 1044.0f);
            return height + (CELL_CONTENT_MARGIN * 2.4);
        }
        else {
            return 0;
        }

    }
    
    NSString *todayIs = [NSString stringWithFormat:@"%@%@%ld%@%@%@%ld", [weekDay stringFromDate:date], @" ", (long)day, @" ", [calMonth stringFromDate:date], @" ", (long)year];
   


    RSSItem4 *object = _objects[indexPath.row];

    if([object.title isEqualToString: todayIs]){
        NSString *text = object.contentEncoded;
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 1.0), 20000.0f);
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        CGFloat height = MAX(size.height+size.height/1.8, 1044.0f);
        return height + (CELL_CONTENT_MARGIN * 2.0);
    }
    else {
        return 0;
    }
}


@end
