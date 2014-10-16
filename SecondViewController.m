//
//  SecondViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "SecondViewController.h"
#import "DetailViewController.h"
#import "RSSLoader.h"
#import "RSSItem.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface SecondViewController ()
{
    NSArray *_objects;
    NSURL* feedURL;
    NSString *theTitle;
    UIRefreshControl* refreshControl;
    NSMutableArray *headerTitle;
}
@end

@implementation SecondViewController

- (void)viewDidAppear:(BOOL)animated {
    if([self hasConnectivity] == NO) {
        //Activity Indicator
        self.overlayView = [[UIView alloc] init];
        self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.overlayView.frame = self.tableView.bounds;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    } else {
        [self.overlayView removeFromSuperview];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.activityIndicator.hidesWhenStopped = YES;
    
    
    //configuration
    self.title = @"Calendar";

        feedURL = [NSURL URLWithString:@"http://www.stolaf.edu/calendar/index.cfm?fuseaction=RSS"];
        
        //add refresh control to the table view
        refreshControl = [[UIRefreshControl alloc] init];
        
        [refreshControl addTarget:self
                           action:@selector(refreshInvoked:forState:)
                 forControlEvents:UIControlEventValueChanged];
        
        NSString* fetchMessage = [NSString stringWithFormat:@""];
        
        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage
                                                                         attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:11.0]}];
        
        //[self.tableView addSubview: refreshControl];
        
        //Hide the "No Upcoming Events" label...
        [_noEventsLabel setHidden: YES];
        
        [self refreshFeed];
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.activityIndicator startAnimating];
    [self.view addSubview:_overlayView];
    self.tableView.scrollEnabled = NO;

    
    RSSLoader* rss = [[RSSLoader alloc] init];
    [rss fetchRssWithURL:feedURL
                complete:^(NSString *title, NSArray *results) {
                    
                    //completed fetching the RSS
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //UI code on the main queue
                        _objects = results;

                        [self.tableView reloadData];
                        
                        // Stop refresh control
                        [refreshControl endRefreshing];
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        [self.activityIndicator stopAnimating];
                        [self.overlayView removeFromSuperview];
                        self.tableView.scrollEnabled = YES;

                    });
                }];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// Section header height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

// Section header text
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Cell"];
    
    theTitle = @"Display the date here";
   
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = theTitle;
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    RSSItem *object = _objects[indexPath.row];
    
    if(([object.title rangeOfString:@"No events listed for this date"].location != NSNotFound) || ([object.title rangeOfString:@"No events this week."].location != NSNotFound)) {
        cell.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.attributedText = object.cellMessage;
    
    
    cell.textLabel.numberOfLines = 0;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.activityIndicator stopAnimating];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    RSSItem *item = [_objects objectAtIndex:indexPath.row];
    RSSItem *object = _objects[indexPath.row];

    [self.activityIndicator stopAnimating];
    //NSLog(@"%@", object.title);
    if(([object.title rangeOfString:@"No events this week."].location != NSNotFound)) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.activityIndicator stopAnimating];
        [_noEventsLabel setHidden: NO];
        cell.hidden = YES;
        self.tableView.scrollEnabled = NO;
        return 0.0;
    }
    else{
        [_noEventsLabel setHidden: YES];
        self.tableView.scrollEnabled = YES;
        CGRect cellMessageRect = [item.cellMessage boundingRectWithSize:CGSizeMake(240,1065) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        return cellMessageRect.size.height;
    }
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        self.tabBarController.selectedIndex = 0;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showMore"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RSSItem *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}


@end
