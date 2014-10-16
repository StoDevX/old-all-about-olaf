//
//  TransportationTableViewController.m
//  Oleville
//
//  Created by Drew Volz on 3/24/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "TransportationTableViewController.h"
#import "TransportationWebViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface TransportationTableViewController ()

@end

@implementation TransportationTableViewController
@synthesize url;
@synthesize urlArrCar;
@synthesize urlArrBus;
@synthesize urlArrBike;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    urlArrCar = [[NSMutableArray alloc] init];
    urlArrBus = [[NSMutableArray alloc] init];
    urlArrBike = [[NSMutableArray alloc] init];

    // Bike array
    [urlArrBike addObject: [NSURL URLWithString:@"http://wp.stolaf.edu/sa/transportation/greenbikes/"]];
    
    // Car array
    [urlArrCar addObject: [NSURL URLWithString:@"http://www.wecar.com/content/car-sharing/en_US/join-wecar/program-details-stolaf.html"]];
    [urlArrCar addObject: [NSURL URLWithString:@"http://www.stolaf.edu/apps/rideboard"]];
    
    // Bus array
    [urlArrBus addObject: [NSURL URLWithString:@"https://webstore.northfieldlines.com/ticketing/"]];
    [urlArrBus addObject: [NSURL URLWithString:@"http://youarriveontime.com"]];
    [urlArrBus addObject: [NSURL URLWithString:@"http://www.threeriverscap.org/transportation/hiawathaland-transit/northfield-service-area"]];
    [urlArrBus addObject: [NSURL URLWithString:@"http://wp.stolaf.edu/sa/transportation/localexpressbus/"]];
    [urlArrBus addObject: [NSURL URLWithString:@"http://wp.stolaf.edu/sa/transportation/moviebus/"]];
    [urlArrBus addObject: [NSURL URLWithString:@"http://www.northfieldlines.com/content/stop-location-maps"]];
    [urlArrBus addObject: [NSURL URLWithString:@"http://van-go.info/schedule/"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger theRows = 0;
    if (section == 0)
    {
        theRows = urlArrBike.count;
    }
    else if (section == 1) {
        theRows = urlArrCar.count;
    }
    else {
        theRows = urlArrBus.count;
    }
    
    return theRows;
}

// Header Titles
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"Bike";
    else if(section == 1)
        return @"Car";
    else
        return @"Bus";
}

// Header Titles Setion Heights
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

// Cell heights
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


// Customizing cells in sections
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.detailTextLabel.numberOfLines = 0;
    
    //Bike
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0){
            cell.textLabel.text = @"Green Bikes";
            cell.detailTextLabel.text = @"Great green alternative, available for check-out through Rolvaag Library.";
        }
    }
    //Car
    else if (indexPath.section == 1) {
        if (indexPath.row == 0){
            cell.textLabel.text = @"Enterprise CarShare";
            cell.detailTextLabel.text = @"Car sharing program for business, school, or personal use.";
        }
        if (indexPath.row == 1){
            cell.textLabel.text = @"Ride Board";
            cell.detailTextLabel.text = @"Post a ride or look for a ride with students.";
        }
    }
    //Bus
    else if (indexPath.section == 2) {
        if (indexPath.row == 0){
            cell.textLabel.text = @"Break Airport Shuttles";
            cell.detailTextLabel.text = @"Northfield Lines shuttle operates only immediately before and after break. You must buy tickets 48 hours in advance.";
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"First Choice Shuttle";
            cell.detailTextLabel.text = @"Shuttle service to and from MSP airports, bus and train depots, local shuttle, medical appointments, casinos, and package delivery.";
        }
        else if (indexPath.row == 2){
            cell.textLabel.text = @"Hiawathaland Transit";
            cell.detailTextLabel.text = @"This shuttle operates Monday - Friday and will pick you up from any location in Northfield. You must call first.";
        }
        else if (indexPath.row == 3){
            cell.textLabel.text = @"Local Bus";
            cell.detailTextLabel.text = @"Free route bus that stops at both colleges, Division Street, Target/Cub, and El Tequila/Culvers.";
        }
        else if (indexPath.row == 4){
            cell.textLabel.text = @"Movie Bus";
            cell.detailTextLabel.text = @"This bus operates on Saturday Evenings only and goes to the Muller Family Theater in Lakeville. See more for the movie bus schedule";
        }
        else if (indexPath.row == 5){
            cell.textLabel.text = @"Northfield Metro Express";
            cell.detailTextLabel.text = @"Shuttle service 3 times daily/7 days a week that stops at Carleton, St. Olaf, Northfield Park & Ride, and MSP Airport.";
        }
        else if (indexPath.row == 6){
            cell.textLabel.text = @"Van-GO!";
            cell.detailTextLabel.text = @"Van service that operates Monday - Friday from 7 a.m. to 6 p.m. Business use only.";
        }
    }
    return cell;
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([self hasConnectivity] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
        return false;
    }
    return YES;
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Define indexpath
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    
    if ([[segue identifier] isEqualToString:@"displayURL"]) {
        if(indexPath.section == 0) {
            //Display the url for bike
            [[segue destinationViewController] setPassMePlease: urlArrBike[indexPath.row]];
        }
        else if(indexPath.section == 1) {
            //Display the url for car
            [[segue destinationViewController] setPassMePlease: urlArrCar[indexPath.row]];
        }
        else if(indexPath.section == 2) {
            //Display the url for bus
            [[segue destinationViewController] setPassMePlease: urlArrBus[indexPath.row]];
        }
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



@end
