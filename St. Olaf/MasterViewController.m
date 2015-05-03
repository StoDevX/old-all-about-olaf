//
//  MasterViewController.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "RSSLoader.h"
#import "RSSItem.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface MasterViewController ()
{
    NSArray *_objects;
    NSURL *feedURL;
    UIRefreshControl *refreshControl;
}
@end

@implementation MasterViewController
@synthesize subView;
@synthesize segmentedControl;

BOOL firstSelected = true;
BOOL secondSelected = false;
BOOL thirdSelected = false;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.activityIndicator.hidesWhenStopped = YES;

    //Activity Indicator
    self.overlayView = [[UIView alloc] init];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.overlayView.frame = self.tableView.bounds;

    //configuration
    self.title = @"News";

    if ([self hasConnectivity] == NO)
    {
        CGRect frame = [[UIScreen mainScreen] bounds];
        subView = [[UIView alloc] initWithFrame:frame];
        subView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:subView];
        [_noInternet setHidden:YES];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    else if ([self hasConnectivity] == YES)
    {
        [_noInternet setHidden:YES];

        //Set the segmented control to be where we want it to be
        segmentedControl = [[UISegmentedControl alloc] initWithItems:@[ @"St. Olaf", @"Manitou", @"PoliticOle" ]];
        firstSelected = true;

        // Olaf news
        feedURL = [NSURL URLWithString:@"http://wp.stolaf.edu/feed/"];

        //add refresh control to the table view
        refreshControl = [[UIRefreshControl alloc] init];

        [refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];

        NSString *fetchMessage = [NSString stringWithFormat:@""];

        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:11.0] }];

        //[self.tableView addSubview: refreshControl];
        //add the header
        [self refreshFeed];
    }
}

- (IBAction)segmentedAction:(UISegmentedControl *)control
{
    if ([self hasConnectivity] == NO)
    {
        CGRect frame = [[UIScreen mainScreen] bounds];
        subView = [[UIView alloc] initWithFrame:frame];
        subView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:subView];
        [_noInternet setHidden:NO];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    if ([self hasConnectivity] == YES)
    {
        [_noInternet setHidden:YES];
        //Load the Olaf news feed
        if (control.selectedSegmentIndex == 0)
        {
            firstSelected = true;
            secondSelected = false;
            thirdSelected = false;
            feedURL = [NSURL URLWithString:@"http://wp.stolaf.edu/feed/"];

            //add refresh control to the table view
            refreshControl = [[UIRefreshControl alloc] init];

            [refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];

            NSString *fetchMessage = [NSString stringWithFormat:@""];

            refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:11.0] }];

            //[self.tableView addSubview: refreshControl];
            //add the header
            [self refreshFeed];
        }

        //Load the Manitou Messenger news feed
        else if (control.selectedSegmentIndex == 1)
        {
            firstSelected = false;
            secondSelected = true;
            thirdSelected = false;
            feedURL = [NSURL URLWithString:@"http://manitoumessenger.com/feed"];

            //add refresh control to the table view
            refreshControl = [[UIRefreshControl alloc] init];

            [refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];

            NSString *fetchMessage = [NSString stringWithFormat:@""];

            refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:11.0] }];

            //[self.tableView addSubview: refreshControl];
            //add the header
            [self refreshFeed];
        }

        //Load the PoliticOle news feed
        else if (control.selectedSegmentIndex == 2)
        {
            firstSelected = false;
            secondSelected = false;
            thirdSelected = true;
            feedURL = [NSURL URLWithString:@"http://oleville.com/politicole/feed/"];

            //add refresh control to the table view
            refreshControl = [[UIRefreshControl alloc] init];

            [refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];

            NSString *fetchMessage = [NSString stringWithFormat:@""];

            refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:11.0] }];

            //[self.tableView addSubview: refreshControl];
            //add the header
            [self refreshFeed];
        }
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

- (NSUInteger)supportedInterfaceOrientations
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
    self.tableView.scrollEnabled = NO;

    RSSLoader *rss = [[RSSLoader alloc] init];
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
                        self.tableView.scrollEnabled = YES;
                    });
                }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 0 : _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    RSSItem *object = _objects[indexPath.row];

    // customize cell
    cell.textLabel.attributedText = object.cellMessage;
    cell.textLabel.numberOfLines = 0;

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        [segmentedControl addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        //segmentedControl.transform = CGAffineTransformMakeScale(.87f, .87f);

        if (firstSelected)
        {
            segmentedControl.selectedSegmentIndex = 0;
        }
        else if (secondSelected)
        {
            segmentedControl.selectedSegmentIndex = 1;
        }
        else if (thirdSelected)
        {
            segmentedControl.selectedSegmentIndex = 2;
        }

        return segmentedControl;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0 : 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSSItem *object = _objects[indexPath.row];

    RSSItem *item = [_objects objectAtIndex:indexPath.row];
    CGRect cellMessageRect = [item.cellMessage boundingRectWithSize:CGSizeMake(100, 65)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                            context:nil];
    return cellMessageRect.size.height;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RSSItem *object = _objects[indexPath.row];

        //Display the normal story
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
