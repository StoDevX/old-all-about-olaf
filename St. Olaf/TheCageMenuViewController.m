//
//  TheCageMenuViewController.m
//  Oleville
//
//  Created by Drew Volz on 2/27/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "TheCageMenuViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface TheCageMenuViewController ()
@end
bool shouldDisplayLoading = true;

@implementation TheCageMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
        //Load screen...
        CGRect frame = [[UIScreen mainScreen] bounds];
        _overlayView = [[UIView alloc] initWithFrame:frame];
        _overlayView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_overlayView];
        [self.view addSubview:_loadingMenuText];
        [self.view addSubview:_loadingMenuSpinner];
        [_loadingMenuSpinner startAnimating];

        [_mobileSite setDelegate:self];
        _mobileSite.scrollView.scrollEnabled = TRUE;
        NSString *urlString = @"http://stolaf.cafebonappetit.com/hungry/the-cage/";
        //2
        NSURL *url = [NSURL URLWithString:urlString];
        //3
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //4
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        //5
        [NSURLConnection sendAsynchronousRequest:request queue:queue
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if ([data length] > 0 && error == nil) [_mobileSite loadRequest:request];
                                   else if (error != nil) NSLog(@"Error: %@", error);
                               }];

        // Set-up the forward/backward buttons for the webview
        UIToolbar *toolbar = [UIToolbar new];
        // create a bordered style button with custom title
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
        UIBarButtonItem *forward = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward.png"] style:UIBarButtonItemStylePlain target:self action:@selector(forward:)];
        UIBarButtonItem *reload = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
        UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem.width = 20.0f;

        NSArray *items = [NSArray arrayWithObjects:back, fixedItem, fixedItem, forward, fixedItem, fixedItem, reload, nil];
        toolbar.items = items;

        // size up the toolbar and set its frame
        // please note that it will work only for views without Navigation toolbars.
        [toolbar sizeToFit];
        CGFloat toolbarHeight = [toolbar frame].size.height;
        CGRect mainViewBounds = self.view.bounds;
        [toolbar setFrame:CGRectMake(CGRectGetMinX(mainViewBounds),
                                     CGRectGetMinY(mainViewBounds) + CGRectGetHeight(mainViewBounds) - (toolbarHeight),
                                     CGRectGetWidth(mainViewBounds),
                                     toolbarHeight)];
        [self.view addSubview:toolbar];
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

// Reload
- (void)reload:(UIBarButtonItem *)sender
{
    [_mobileSite reload];
}

// Back
- (void)back:(UIBarButtonItem *)sender
{
    [_mobileSite goBack];
}

// Forward
- (void)forward:(UIBarButtonItem *)sender
{
    [_mobileSite goForward];
}

- (void)webViewDidFinishLoad:(UIWebView *)site
{
    //stop the activity indicator when done loading
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.overlayView removeFromSuperview];
    [_loadingMenuText setHidden:YES];
    [_loadingMenuSpinner setHidden:YES];
    [_loadingMenuSpinner stopAnimating];

    //canGoBack and canGoForward are properties which indicate if there is any forward or backward history
    if (site.canGoBack)
    {
        _back.enabled = YES;
    }
    if (site.canGoForward)
    {
        _forward.enabled = YES;
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

- (void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    _mobileSite.delegate = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)_mobileSite
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end