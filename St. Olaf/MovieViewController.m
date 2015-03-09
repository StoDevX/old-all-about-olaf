//
//  MovieViewController.m
//  Oleville
//
//  Created by Drew Volz on 2/16/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "MovieViewController.h"
#import "XPathQuery.h"
#import "TFHpple.h"
#import "NSString_stripHtml.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>

@interface MovieViewController () 

@end

//******************************
// Goal: pull in the SAC page and parse out the movie information
//******************************

//Movie title
NSString *title = @"";

//Movie length in minutes
NSString *length = @"";

//Movie Showing Date
NSString *date = @"";

//Location information
NSString *location = @"";

//Trailer information
NSString *trailer = @"";


@implementation MovieViewController
@synthesize subView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = @"Movie";
        
        // The key of the PFObject to display in the label of the default cell style
        //self.textKey = @"word";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        //self.objectsPerPage = 10;
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query orderByDescending:@"createdAt"];
    query.limit = 1;

    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }

    return query;
}


- (void)viewWillAppear:(BOOL)animated
{
    
    //Show activity indicators
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [self.activityIndicator startAnimating];
    
//    NSDictionary *movieObj = [[NSDictionary alloc] init];
    
    PFQuery *theQuery = [PFQuery queryWithClassName:self.parseClassName];
    [theQuery orderByDescending:@"createdAt"];
    theQuery.limit = 1;
    
    // Use countObjects instead of findObjects
    [theQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        title =     objects[0][@"title"];
        length =    [NSString stringWithFormat:@"%@%@", objects[0][@"length"], @" minutes"];
        location =  objects[0][@"location"];
        date =      [NSString stringWithFormat:@"%@%@%@", objects[0][@"showdates"], @"\n", objects[0][@"showtimes"]];
        trailer =   objects[0][@"trailer"];
    }];

}

-(void)viewDidAppear:(BOOL)animated
{
    // Stop refresh control
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.activityIndicator stopAnimating];
    
    
    //******************************
    // Now display the trailer
    //******************************
    
    //Variable to calculate screen width
    CGFloat width = CGRectGetWidth(self.view.bounds);
    //Now embed the youtube trailer for the movie onto the screen
    UIWebView * youTubeWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 200, width, 250)];
    youTubeWebView.allowsInlineMediaPlayback=YES;
    youTubeWebView.mediaPlaybackRequiresUserAction=NO;
    youTubeWebView.mediaPlaybackAllowsAirPlay=YES;
    youTubeWebView.delegate=self;
    youTubeWebView.scrollView.bounces=NO;
    youTubeWebView.scrollView.scrollEnabled=NO;
    
    //All of the crazy-delicious formatting we want for our video... to show up as we want it to
    NSString *embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color:black; transparent-color: white;}\\</style>\\</head><body style=\"margin:0\">\\<embed webkit-playsinline id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \\width=\"100\" height=\"250\"></embed>\\</body></html>";
    //A new string with our embedHTML string and our linkObj put together so that it appears as if it were an HTML document
    NSLog(@"%@", trailer);
    NSString *html = [NSString stringWithFormat:embedHTML, trailer];
    [youTubeWebView loadHTMLString:html baseURL:nil];
    [self.view addSubview:youTubeWebView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        
    /*
    // ******************************
    // Begin the web-scraping process
    // ******************************

    //Get the URL we want to parse and throw that baby into a NSURL
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:
                             [NSURL URLWithString:[NSString stringWithFormat:@"http://oleville.com/sac/sac-movies/"]]];
    
    //Error object in case we get one...
    NSError *error;
    //Response from the URL
    NSURLResponse *response;
    //The wonderful funderful NSData object that pases our synchronous request and schmoozes with the wizards in the internet world
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //The awesome TFHpple object which parses all of our data
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:urlData];
    
    //We tell the parser where to look in the HTML code
    NSArray *movieInfo = [xpathParser searchWithXPathQuery:@"//div[@id='movieData']"];
    NSArray *movieInfo2 = [xpathParser searchWithXPathQuery:
                           @"//div[@class='movieLinkDiv']/iframe[@class='movieLink']"];

    //TITLE
    //The parser looks for the "movieTitle" class which contains the movie title
    for (TFHppleElement * element in movieInfo) {
        title = [element firstChildWithClassName:@"movieTitle"].text;
    }
        
    //DATE
    //The parser looks for the "showtimeText" class which contains the showing date
    for (TFHppleElement * element in movieInfo) {
        //Formatting: get rid of everything we do not want to show up
        date = [NSString stringWithFormat:@"%@", [element childrenWithClassName:@"showtimeText"]];
        date = [date stringByReplacingOccurrencesOfString:@"showtimeText" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"nodeName" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"}" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"{" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"br" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"<" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@">" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"/" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"raw" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"nodeContent" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"(" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@")" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"=" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"""" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"nodeAttributeArray" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"class" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"pickMe" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@";" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"nodeChildArray" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"nodeChildArray" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"," withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"text" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"attributeName" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"span" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"&#13n&#13n" withString:@" "];
        date = [date stringByReplacingOccurrencesOfString:@"&#13n" withString:@" "];
        date = [date stringByReplacingOccurrencesOfString:@"spa" withString:@" "];
        date = [date stringByReplacingOccurrencesOfString:@"n5" withString:@"5"];
        date = [date stringByReplacingOccurrencesOfString:@"{\n" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        date = [date stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        date = [date stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        date = [date stripHtml];
    }
        
    //Length
    //The parser looks for the "movieRuntime" class which contains the movie length in minutes
    for (TFHppleElement * element in movieInfo) {
        //Formatting for our multiple-lined cell
        length = [element firstChildWithClassName:@"movieRuntime"].text;
        
        //Formatting: get rid of parens
        length = [length stringByReplacingOccurrencesOfString:@"(" withString:@""];
        length = [length stringByReplacingOccurrencesOfString:@")" withString:@""];
        
        //Formatting: get rid of "mns"...and replace it with "minutes"
        length = [length stringByReplacingOccurrencesOfString:@"mns" withString:@"minutes"];
    }
        
    //Location
    //The parser looks for the "iframe" tag which contains the movie trailer
    for (TFHppleElement * element in movieInfo) {
        //Formatting for our multiple-lined cell
        location = [element firstChildWithClassName:@"movieLocation"].text;
    }
        
    //Trailer
    //The parser looks for the "iframe" tag which contains the movie trailer
    for (TFHppleElement * element in movieInfo2) {
        //Formatting for our multiple-lined cell
        trailer = [element objectForKey:@"src"];
    }

    */
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Now put the correct information into the correct UITableViewCell
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    //Format the cells to have unlimited lines
    [[cell textLabel] setNumberOfLines:0];
    [[cell detailTextLabel] setNumberOfLines:0];
    //Movie Title and Length
    if (indexPath.row == 0 && indexPath.section == 0){
        cell.textLabel.text = title;
        cell.detailTextLabel.text = length;
    }
    //Showtimes
    else if (indexPath.row == 0 && indexPath.section == 1){
        date = [date stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *showDate = [NSString stringWithFormat:@"%@", date];

        cell.textLabel.text = showDate;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    }
    //Location
    else if (indexPath.row == 0 && indexPath.section == 2){
        cell.textLabel.text = location;
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    return cell;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
