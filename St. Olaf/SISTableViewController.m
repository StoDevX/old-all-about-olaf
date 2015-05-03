//
//  SISTableViewController.m
//  Oleville
//
//  Created by Drew Volz on 4/5/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "SISTableViewController.h"
#import "MyCoursesTableViewController.h"
#import "Course.h"
#import "CourseLoader.h"
#import "XPathQuery.h"
#import "TFHpple.h"
#import "NSString_stripHtml.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "HTMLParser.h"

@interface SISTableViewController ()
{
    NSArray *_objects;
    NSString *seenError;
}
@end

@implementation SISTableViewController
//View elements
@synthesize tableView;
@synthesize loginButton;
// UI general
@synthesize refreshControl;

//Secure values
// credentials
@synthesize username;
@synthesize password;
@synthesize prefs;

//Stored requests
@synthesize courseList;
// finances
@synthesize financeData;
@synthesize finances;
//Parsed data
// finances
@synthesize balances;
@synthesize printingBalance;
@synthesize oleBalance;
@synthesize flexBalance;

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
    // user credentials
    prefs = [NSUserDefaults standardUserDefaults];
    // returned account data
    balances = [[NSMutableArray alloc] init];

    seenError = @"0";

    // Refresh control
    refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];

    //**************************************************************
    // Using the plist called "special" for use of populating
    // UITableViewCells with downloaded info:
    //      - printing money
    //      - flex dollars
    //      - ole dollars
    //      - course data
    //**************************************************************

    //Property List Functions

    _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory = [_paths objectAtIndex:0];
    _path = [_documentsDirectory stringByAppendingPathComponent:@"special.plist"];
    _fileManager = [NSFileManager defaultManager];

    // Create the other inital values for the first time
    _savedInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:_path];
    NSString *printMoney = @"";
    NSString *oleDollars = @"";
    NSString *flexDollars = @"";

    if ([_fileManager fileExistsAtPath:_path])
    {
        _data = [[NSMutableDictionary alloc] initWithContentsOfFile:_path];
    }
    // If the file doesn’t exist, create an empty dictionary
    else
    {
        _data = [[NSMutableDictionary alloc] init];

        // write our data into it
        [_data setObject:[NSNumber numberWithInt:0] forKey:@"loggedIn"];
        [_data setObject:[NSString stringWithString:printMoney] forKey:@"printMoney"];
        [_data setObject:[NSString stringWithString:oleDollars] forKey:@"oleDollars"];
        [_data setObject:[NSString stringWithString:flexDollars] forKey:@"flexDollars"];

        [_data writeToFile:_path atomically:YES];
    }

    // Login button
    loginButton.action = @selector(logInOrOut);
    loginButton.target = self;

    if ([[_savedInfo objectForKey:@"loggedIn"] intValue] == 1)
    {
        loginButton.title = @"Logout";

        // Log the user-in
        [self refreshTable];
    }
    else
    {
        loginButton.title = @"Login";
    }
}

- (void)logInOrOut
{
    if ([[_data objectForKey:@"loggedIn"] intValue] == 1)
    {
        // reset the button text
        loginButton.title = @"Login";

        // reset the textfield inputs
        username.text = @"";
        password.text = @"";

        // clear the stored username and password
        [prefs setObject:@"" forKey:@"userName"];
        [prefs setObject:@"" forKey:@"password"];
        [prefs synchronize];

        // reset the plist variables
        [_data setObject:@"" forKey:@"printMoney"];
        [_data setObject:@"" forKey:@"oleDollars"];
        [_data setObject:@"" forKey:@"flexDollars"];
        [_data setObject:[NSNumber numberWithInt:0] forKey:@"loggedIn"];
        [_data writeToFile:_path atomically:YES];

        // delete the PLIST containing user course info
        _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentsDirectory = [_paths objectAtIndex:0];
        for (int p = 0; p < 4; ++p)
        {
            NSString *fileName = [NSString stringWithFormat:@"%@%d%@", @"courseInfo", p, @".json"];
            _path = [_documentsDirectory stringByAppendingPathComponent:fileName];

            if (![[NSFileManager defaultManager] removeItemAtPath:_path error:nil])
            {
                // we do not have a file for some reason here...
            }
        }

        // refresh the table
        [self.tableView reloadData];
    }
    // we are logged-out and trying to login
    else
    {
        // try to login the user
        [self refreshTable];
    }
}

- (void)refreshTable
{
    if ([self hasConnectivity] == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];

        // stop the spinner
        [refreshControl endRefreshing];
    }

    // If we have internet, see if we now have username/password
    else
    {
        [self tryLoggingUserIn];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    username.delegate = self;
    password.delegate = self;

    //Username and Password
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.row == 0 && indexPath.section == 0)
    {
        username = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];

        username.placeholder = @"Username";
        username.text = [prefs stringForKey:@"userName"];

        username.autocorrectionType = UITextAutocorrectionTypeNo;
        username.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [username setClearButtonMode:UITextFieldViewModeWhileEditing];

        username.keyboardType = UIKeyboardTypeDefault;
        username.returnKeyType = UIReturnKeyNext;

        cell.accessoryView = username;
        [tableView addSubview:username];
    }

    if (indexPath.row == 1 && indexPath.section == 0)
    {
        password = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 280, 21)];

        password.placeholder = @"Password";
        password.text = [prefs stringForKey:@"password"];

        password.secureTextEntry = YES;
        password.autocorrectionType = UITextAutocorrectionTypeNo;
        password.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password.keyboardType = UIKeyboardTypeDefault;

        password.returnKeyType = UIReturnKeyDone;
        [password setClearButtonMode:UITextFieldViewModeWhileEditing];
        cell.accessoryView = password;
        [tableView addSubview:password];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

// Make the keyboard disappear when the GO key has been touched
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

    if (indexPath.row == 0 && indexPath.section == 0)
    {
        [password becomeFirstResponder];
        [textField resignFirstResponder];
    }
    if (indexPath.row == 1 && indexPath.section == 0)
    {
        [textField resignFirstResponder];
    }

    // If we are on the password field and we have text in username and password...
    if (username.text != NULL && ![username.text isEqual:@""] && password.text != NULL && ![password.text isEqual:@""] && indexPath.row == 1)
    {
        // Log the user-in
        [self refreshTable];
    }

    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    // Pull the user's credentials from NSUserDefaults
    NSString *tokenUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *tokenPass = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];

    // If the credentials have changed then save the update
    if (!([tokenUser isEqual:username.text]) || (!([tokenPass isEqual:password.text])))
    {
        [prefs setObject:username.text forKey:@"userName"];
        [prefs setObject:password.text forKey:@"password"];
        [prefs synchronize];
    }

    return YES;
}

// Handle when the log-in button is pressed
- (void)loginTapped:(UIButton *)button
{
    // Log the user-in
    [self refreshTable];
}

// Loggin-in with the user's credentials with POST data
- (bool)tryLoggingUserIn
{
    // Pull the user's credentials from NSUserDefaults
    NSString *tokenUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *tokenPass = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];

    // if we have a username and password
    if ((tokenUser != NULL && ![tokenUser isEqual:@""] && tokenPass != NULL && ![tokenPass isEqual:@""]))
    {
        [self logMeIn];
    }
    else
    {
        // stop the spinner
        [refreshControl endRefreshing];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Log-In!" message:@"Please provide your username and password and try again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    return true;
}

// Handling the response from logging-in
- (BOOL)logMeIn
{
    // Pull the user's credentials from NSUserDefaults
    NSString *tokenUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *tokenPass = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];

    // Our POST data for when we sign-in
    NSString *post = [NSString stringWithFormat:@"login=%@&passwd=%@", tokenUser, tokenPass];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

    // Make the request to the server to sign-in
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://www.stolaf.edu/sis/login.cfm?"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:YES];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];

    // Header response from the server
    NSURLResponse *response;

    // Code to see if we have had any server errors or pages not found...
    int code = [(NSHTTPURLResponse *)response statusCode];
    // URL to search for the failure URL
    NSString *responseURL = [[response URL] absoluteString];

    if ([responseURL rangeOfString:@"Sorry"].location != NSNotFound)
    {
        [refreshControl endRefreshing];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Log-In" message:@"Please check your username and password and try again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
        return false;
    }
    if (code >= 200 && code < 300)
    {
        // We are logged in, set the PLIST value
        [_data setObject:[NSNumber numberWithInt:1] forKey:@"loggedIn"];
        [_data writeToFile:_path atomically:YES];

        [self getFinancialData];
    }
    // Problem that's out of my control (aka St. Olaf site is down, webserver unresponsive, etc)
    else
    {
        [refreshControl endRefreshing];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Log-In" message:@"Please try again in a bit." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    return true;
}

// Get financial data
- (void)getFinancialData
{
    //Get the URL we want to parse and throw that baby into a NSURL
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:
                                                      [NSURL URLWithString:[NSString stringWithFormat:@"https://www.stolaf.edu/sis/st-financials.cfm"]]];

    //Error object in case we get one...
    NSError *error;
    //Response from the URL
    NSURLResponse *response;

    //The wonderful funderful NSData object that pases our synchronous request and schmoozes with the wizards in the internet world
    NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    int code = [(NSHTTPURLResponse *)response statusCode];
    if (code >= 200 && code < 300)
    {
        //The awesome TFHpple object which parses all of our data
        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:urlData];

        // Find student number
        NSArray *studentNumberArr = [xpathParser searchWithXPathQuery:@"//h3"];

        NSMutableArray *studentNumber = [[NSMutableArray alloc] init];

        // Check to make sure we have data...
        if (studentNumberArr.count > 0 && studentNumberArr != NULL && ![studentNumberArr isEqual:@""])
        {
            // The parser looks for the content of each child
            for (TFHppleElement *element in studentNumberArr)
            {
                [studentNumber addObject:[[element firstChild] content]];
            }
        }

        // Split the string and pull out the part which we want
        NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
        NSArray *splitString = [studentNumber[0] componentsSeparatedByCharactersInSet:delimiters];

        NSString *yString = [splitString objectAtIndex:1];

        // Save the Id into NSUserDefaults
        [prefs setObject:yString forKey:@"userId"];
        [prefs synchronize];

        // Parse out the finances we want (Printing/Copy Balance, Ole Dollars, Flex Dollars)
        // Here we use another type of HTML parser because it is more flexible
        HTMLParser *parser = [[HTMLParser alloc] initWithData:urlData error:nil];
        HTMLNode *bodyNode = [parser body];

        NSArray *tdNodes = [bodyNode findChildTags:@"td"];
        NSMutableDictionary *balances = [[NSMutableDictionary alloc] init];
        for (HTMLNode *tdNode in tdNodes)
        {
            if ([[tdNode getAttributeNamed:@"class"] isEqualToString:@"sis-right"])
            {
                // Get the items and the neighbors we are wanting to display and save
                NSString *final = [tdNode allContents];
                HTMLNode *next = [[tdNode nextSibling] nextSibling];
                NSString *value = [next contents];

                // Housekeeping items to replace spaces and add them back where necessary...
                value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
                value = [value stringByReplacingOccurrencesOfString:@"NotAvailable" withString:@"Not Available"];

                balances[final] = value;
            }
        }

        // Write the info to the plist
        _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentsDirectory = [_paths objectAtIndex:0];
        _path = [_documentsDirectory stringByAppendingPathComponent:@"special.plist"];
        _fileManager = [NSFileManager defaultManager];

        [_data setObject:balances[@"Flex Dollars"] forKey:@"flexDollars"];
        [_data setObject:balances[@"Student Copy/Print"] forKey:@"printMoney"];
        [_data setObject:balances[@"Ole Dollars"] forKey:@"oleDollars"];
        [_data writeToFile:_path atomically:YES];

        // Change the login/logout button text
        loginButton.title = @"Logout";

        // Next get the student's schedule
        [self getScheduleData];
    }
    else
    {
        //NSLog(@"Uh-Oh");
        [refreshControl endRefreshing];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Log-In" message:@"Please check your username and password and try again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
}

- (void)getMealsLeft
{
    // Pull the user's credentials from NSUserDefaults
    NSString *tokenUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *tokenPass = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];

    // Start NSURLSession
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    // POST parameters
    NSURL *url = [NSURL URLWithString:@"https://www.stolaf.edu/apps/olecard/checkbalance/authenticate.cfm?"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = [NSString stringWithFormat:@"username=%@&password=%@", tokenUser, tokenPass];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // Handle response
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger statusCode = [httpResponse statusCode];
        NSLog(@"%ld", (long)statusCode);

        if(error == nil) {
            
            if (statusCode == 400) {}
            else if (statusCode == 403) {}
            else if (statusCode == 200) {
                
                NSString *html= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSError *error = nil;
                HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
                
                if (error) {
                    NSLog(@"Error: %@", error);
                    return;
                }
                
                HTMLNode *bodyNode = [parser body];
                
                NSArray *tdNodes = [bodyNode findChildTags:@"td"];
                for (HTMLNode *tdNode in tdNodes) {
                    // Daily meals left
                    if ([[tdNode getAttributeNamed:@"id"] isEqualToString:@"mealsleftdaily"]) {
                        HTMLNode * next  = [[tdNode nextSibling] nextSibling] ;
                        NSString * value  = [next contents];
                        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
                        [_data setObject:value   forKey:@"dailyMeals"];
                    }
                    // Weekly meals left
                    if ([[tdNode getAttributeNamed:@"id"] isEqualToString:@"mealsleftweekly"]) {
                        HTMLNode * next2  = [[tdNode nextSibling] nextSibling] ;
                        NSString * value2  = [next2 contents];
                        value2 = [value2 stringByReplacingOccurrencesOfString:@" " withString:@""];
                        [_data setObject:value2  forKey:@"weeklyMeals"];
                    }
                    
                    [_data writeToFile: _path atomically:YES];
                }
            } else {
                NSLog(@"Error: %@", error);
            }
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
    [dataTask resume];
}

// Get schedule data by using a block
- (void)getScheduleData
{
    courseList = [[CourseLoader alloc] init];

    [courseList fetchCourses:@"text" // text param doesn't do anything... just a away for me to get the function started... my lack of knowledge...
                    complete:^(NSArray *results) {

            //completed fetching the data
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // Check to see if we got our data or an error...
                if([results[0] isKindOfClass:[NSString class]]) {
                    if([results[0] rangeOfString:@"exitNow"].location != NSNotFound || [results[0] rangeOfString:@"Nodes was nil"].location != NSNotFound) {
                        if([seenError  isEqual: @"0"]) {
                            // alert the user
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Update Classes" message:@"Please check to see if you have any holds on your account." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                            // optional - add more buttons:
                            [alert show];
                            
                            // Only display the alert once despite checking many schedules
                            seenError = @"1";
                        }
                    }
                        // stop the spinner
                        [refreshControl endRefreshing];
                    }
                    else {
                        // UI code on the main queue
                        _objects = results;
                        
                        // And finally see how many meals we have left
                        [self getMealsLeft];
                        
                        // Refresh UI
                        // stop the spinner
                        [refreshControl endRefreshing];
                        
                        // refresh the table
                        [self.tableView reloadData];
                    }
            });
                    }];
}

// Pass the course data collected to the MyCourses view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showClasses"])
    {
        [[segue destinationViewController] setDetailItem:_objects];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end