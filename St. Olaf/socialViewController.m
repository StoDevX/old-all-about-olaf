//
//  socialViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/9/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "socialViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface socialViewController ()

@end

@implementation socialViewController
@synthesize music;
@synthesize subView;
@synthesize toolbar;
@synthesize navBar;
int play = 0;
UIButton *button;

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

    //Showing and hiding the webView as necessary
    //Show it for facebook and twitter
    int height = [[UIScreen mainScreen] bounds].size.height;

    // Set width and height of view to be full screen
    CGRect frame = [[UIScreen mainScreen] bounds];
    _webView.frame = frame;

    if (_segment.selectedSegmentIndex == 0)
    {
        [_webView setHidden:YES];
        [_loadingText setHidden:YES];
        [_loadingSpinner setHidden:YES];
    }
    else
    {
        [_webView setHidden:NO];
        [_loadingText setHidden:NO];
        [_loadingSpinner setHidden:NO];
    }

    // Set-up the forward/backward buttons for the webview
    toolbar = [UIToolbar new];
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

    UITextView *myUITextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(mainViewBounds) - 50, height)];
    myUITextView.text = @"One of the nation’s leading four-year residential colleges, St. Olaf offers an academically rigorous education with a vibrant faith tradition. Founded in 1874, St. Olaf is a liberal arts college of the church in the Lutheran tradition (ELCA). Committed to the liberal arts and incorporating a global perspective, St. Olaf fosters the development of the whole person in mind, body, and spirit.\n\nAcademic excellence informs St. Olaf College’s identity and characterizes its history. Through its curriculum, campus life, and off-campus programs, St. Olaf hones students’ critical thinking and nurtures their moral formation. The college encourages and challenges its students to be seekers of truth, to lead lives of unselfish service to others, and to be responsible and knowledgeable citizens of the world.\n\nWidely known for its world-class programs in mathematics and music, St. Olaf is also recognized for its innovative approaches to undergraduate science education and its commitment to environmental sustainability as evidenced in such initiatives as the adoption of green chemistry principles across the science curriculum.\n\nFor nearly half a century, St. Olaf has been at the forefront of global education and a pioneer in study abroad. Today, with 110 distinct international and off-campus programs in 46 countries, St. Olaf students enjoy a world of opportunities when pursuing their studies.\n\nSt. Olaf is an inclusive community that welcomes people of differing backgrounds and beliefs, a community that embraces spirituality and cultivates compassion. Conversations about faith are part of campus life and numerous opportunities are provided for students to grow in their faith and discover how they are called upon to serve others.\n\nSt. Olaf takes pride in its record of academic excellence. A leader among undergraduate colleges in producing prestigious Rhodes Scholars, Fulbright Fellows, and Peace Corps volunteers, St. Olaf ranks 11th overall among the nation’s baccalaureate colleges in the number of graduates who go on to earn doctoral degrees, with top ten rankings in the fields of mathematics/statistics, religion/theology, arts and music, medical sciences, education and the social service professions, chemistry and the physical sciences, life sciences, and foreign languages.\n\n\n\n";
    myUITextView.textColor = [UIColor blackColor];
    myUITextView.font = [UIFont systemFontOfSize:16];
    [myUITextView setBackgroundColor:[UIColor clearColor]];
    myUITextView.editable = NO;
    myUITextView.scrollEnabled = YES;
    [_textView addSubview:myUITextView];

    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"lion.png"] forState:UIControlStateNormal];

    [button addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 32, 38)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

// Play music if play is even (touched once)
- (void)playMusic:(UIBarButtonItem *)sender
{
    if ((play % 2) == 0)
    {
        //...then play music
        NSURL *musicFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"theme" ofType:@"mp3"]];
        music = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:nil];
        [music setVolume:1.0];
        [music play];
        ++play;
    }
    // Stop music if play is odd (touched again)
    else if ((play % 2) == 1)
    {
        [music stop];
        ++play;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeWebsite
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    if ([self hasConnectivity] == NO && _segment.selectedSegmentIndex != 0)
    {
        //Load screen...
        [_webView setDelegate:self];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    else
    {
        [self.view addSubview:toolbar];

        if (_segment.selectedSegmentIndex == 0)
        {
            [_webView setHidden:YES];
            [_textView setHidden:NO];
            [_segment setHidden:NO];
            [_loadingText setHidden:YES];
            [toolbar setHidden:YES];
        }
        if (_segment.selectedSegmentIndex == 1)
        {
            [_webView setHidden:NO];
            [_textView setHidden:YES];
            [_segment setHidden:NO];
            [toolbar setHidden:NO];

            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            CGRect frame = CGRectMake(0, 93, screenWidth, screenHeight - 7);
            _overlayView = [[UIView alloc] initWithFrame:frame];
            _overlayView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:_overlayView];

            [_loadingText setHidden:NO];
            [_loadingSpinner setHidden:NO];
            [_loadingSpinner startAnimating];
            [_webView setDelegate:self];

            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.facebook.com/profile.php?id=136842418331"]]];
        }
        else if (_segment.selectedSegmentIndex == 2)
        {
            [_webView setHidden:NO];
            [_textView setHidden:YES];
            [_segment setHidden:NO];
            [toolbar setHidden:NO];

            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            CGRect frame = CGRectMake(0, 93, screenWidth, screenHeight - 7);
            _overlayView = [[UIView alloc] initWithFrame:frame];
            _overlayView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:_overlayView];

            [_loadingText setHidden:NO];
            [_loadingSpinner setHidden:NO];
            [_loadingSpinner startAnimating];
            [_webView setDelegate:self];

            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mobile.twitter.com/StOlaf"]]];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        self.tabBarController.selectedIndex = 0;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)_webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.view addSubview:_loadingSpinner];
    [self.view addSubview:_loadingText];
    [_loadingSpinner startAnimating];
}

// Reload
- (void)reload:(UIBarButtonItem *)sender
{
    [_webView reload];
}

// Back
- (void)back:(UIBarButtonItem *)sender
{
    [_webView goBack];
}

// Forward
- (void)forward:(UIBarButtonItem *)sender
{
    [_webView goForward];
}

- (void)viewDidDisappear:(BOOL)animated
{
    _webView.delegate = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)_webView
{
    if (_segment.selectedSegmentIndex == 1)
    {
        _webView.scrollView.contentOffset = CGPointMake(0, 55);
    }

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [_overlayView setHidden:YES];
    [_loadingSpinner setHidden:YES];
    [_loadingText setHidden:YES];
    [_textView setHidden:YES];

    //canGoBack and canGoForward are properties which indicate if there is any forward or backward history
    if (_webView.canGoBack == YES)
    {
        _back.enabled = YES;
    }
    if (_webView.canGoForward == YES)
    {
        _forward.enabled = YES;
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

@end
