//
//  MasterViewController.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//

#import "ClassViewController.h"
#import "InfoTableViewController.h"
#import "RSSLoader3.h"
#import "RSSItem3.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import "NSString_stripHtml.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface ClassViewController ()
{
    NSArray *_objects;
    NSArray *_results;
    NSURL *feedURL;
    UIRefreshControl *refreshControl;
}
@end

@implementation ClassViewController
@synthesize subView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Activity Indicator
    self.overlayView = [[UIView alloc] init];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.overlayView.frame = self.tableView.bounds;

    //configuration
    self.title = @"Class & Lab";

    //Get the current date
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, yyy"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEE,"];
    NSDateFormatter *calMonth = [[NSDateFormatter alloc] init];
    [calMonth setDateFormat:@"MMM"];

    int theYear = year;

    // Adjust the year based on the date
    // We want to look at 2013 for 2013-2014 year, and so on

    // Check Jan through May
    if (month >= 1 && month < 6)
    {
        // Subtract 1 from the current year to get the right URL
        theYear = year - 1;
        NSLog(@"%d", theYear);
    }
    // Check Jun - Dec
    else if (month >= 6 && month <= 12)
    {
        // It's a new school year, so don't touch it to get the right URL
        theYear = year;
        NSLog(@"%d", theYear);
    }

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
    else
    {
        NSString *theURL = [NSString stringWithFormat:@"%@%d%@",
                                                      @"http://www.stolaf.edu/sis/public-acl-inez.cfm?searchyearterm=",
                                                      theYear,
                                                      @"1&searchkeywords=&searchdepts=&searchgereqs=&searchopenonly=&searchlabonly=&searchfsnum=&searchtimeblock="];

        feedURL = [NSURL URLWithString:theURL];

        //add refresh control to the table view
        refreshControl = [[UIRefreshControl alloc] init];

        [refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];

        NSString *fetchMessage = [NSString stringWithFormat:@""];

        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:11.0] }];

        //[self.tableView addSubview: refreshControl];
        [self refreshFeed];
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

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
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

- (void)refreshInvoked:(id)sender forState:(UIControlState)state
{
    [self refreshFeed];
}

- (void)refreshFeed
{
    //Show activity indicators
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.activityIndicator startAnimating];

    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.tableView addSubview:self.overlayView];
    self.tableView.scrollEnabled = NO;

    RSSLoader3 *rss = [[RSSLoader3 alloc] init];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    RSSItem3 *object = _objects[indexPath.row];
    NSString *one = object.department;
    NSString *two = object.courseNumber;
    NSString *three = object.courseSection;
    NSString *four = object.meetingTimes;

    NSString *theRealDeal = [NSString stringWithFormat:@"%@%@%@%@", one, @" ", two, three];
    four = [four stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    four = [four stringByReplacingOccurrencesOfString:@"AM" withString:@" a.m. "];
    four = [four stringByReplacingOccurrencesOfString:@"PM" withString:@" p.m. "];
    four = [four stringByReplacingOccurrencesOfString:@"-" withString:@" – "];
    NSString *theRealDeal2 = [NSString stringWithFormat:@"%@%@%@", theRealDeal, @"\n", four];

    theRealDeal2 = [theRealDeal2 stripHtml];

    cell.textLabel.attributedText = object.cellMessage;
    cell.detailTextLabel.text = theRealDeal2;
    cell.detailTextLabel.numberOfLines = 0;
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RSSItem3 *object = _objects[indexPath.row];

    return 94.0;
}

- (IBAction)changeWebsite
{
    //Get the current date to display the right RSS Food Menu Item from Bon Appetit
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, yyy"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEE,"];
    NSDateFormatter *calMonth = [[NSDateFormatter alloc] init];
    [calMonth setDateFormat:@"MMM"];

    int theYear = year;

    // Adjust the year based on the date
    // We want to look at 2013 for 2013-2014 year, and so on

    // Check Jan through May
    if (month >= 1 && month < 6)
    {
        // Subtract 1 from the current year to get the right URL
        theYear = year - 1;
    }
    // Check Jun - Dec
    else if (month >= 6 && month <= 12)
    {
        // It's a new school year, so don't touch it to get the right URL
        theYear = year;
    }

    // Now check which one of the buttons has been pressed
    // Semester 1
    if (_segment.selectedSegmentIndex == 0)
    {
        NSString *theURL = [NSString stringWithFormat:@"%@%d%@",
                                                      @"http://www.stolaf.edu/sis/public-acl-inez.cfm?searchyearterm=",
                                                      theYear,
                                                      @"1&searchkeywords=&searchdepts=&searchgereqs=&searchopenonly=&searchlabonly=&searchfsnum=&searchtimeblock="];

        feedURL = [NSURL URLWithString:theURL];
        refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];

        NSString *fetchMessage = [NSString stringWithFormat:@""];

        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:11.0] }];

        //[self.tableView addSubview: refreshControl];
        [self refreshFeed];
        [self.tableView reloadData];
    }

    // Interim button
    if (_segment.selectedSegmentIndex == 1)
    {
        NSString *theURL = [NSString stringWithFormat:@"%@%d%@",
                                                      @"http://www.stolaf.edu/sis/public-acl-inez.cfm?searchyearterm=",
                                                      theYear,
                                                      @"2&searchkeywords=&searchdepts=&searchgereqs=&searchopenonly=&searchlabonly=&searchfsnum=&searchtimeblock="];

        feedURL = [NSURL URLWithString:theURL];
        refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];

        NSString *fetchMessage = [NSString stringWithFormat:@""];

        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:11.0] }];

        //[self.tableView addSubview: refreshControl];
        [self refreshFeed];
        [self.tableView reloadData];
    }

    // Semester 2
    if (_segment.selectedSegmentIndex == 2)
    {
        NSString *theURL = [NSString stringWithFormat:@"%@%d%@",
                                                      @"http://www.stolaf.edu/sis/public-acl-inez.cfm?searchyearterm=",
                                                      theYear,
                                                      @"3&searchkeywords=&searchdepts=&searchgereqs=&searchopenonly=&searchlabonly=&searchfsnum=&searchtimeblock="];

        feedURL = [NSURL URLWithString:theURL];
        refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];

        NSString *fetchMessage = [NSString stringWithFormat:@""];

        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:11.0] }];

        //[self.tableView addSubview: refreshControl];
        [self refreshFeed];
        [self.tableView reloadData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showMore"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RSSItem3 *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
