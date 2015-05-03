//
//  TransportationWebViewController.m
//  Oleville
//
//  Created by Drew Volz on 3/24/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "TransportationWebViewController.h"

@interface TransportationWebViewController ()

@end

@implementation TransportationWebViewController
@synthesize passMePlease;
@synthesize share;
@synthesize activityViewController;
@synthesize webView;

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
}

- (void)viewDidAppear:(BOOL)animated
{
    NSURL *thePassedURL = passMePlease;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    [webView setDelegate:self];

    NSURLRequest *req = [NSURLRequest requestWithURL:thePassedURL];
    webView.scrollView.scrollEnabled = TRUE;
    webView.scalesPageToFit = YES;
    [webView loadRequest:req];
    [self.view addSubview:webView];

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

//This is the share menu
- (IBAction)shareButtonPressed:(id)sender
{
    NSURL *thePassedURL = passMePlease;

    self.activityViewController = [[UIActivityViewController alloc]
        initWithActivityItems:@[ thePassedURL ]
        applicationActivities:nil];
    [self presentViewController:self.activityViewController animated:YES completion:nil];
}

// Reload
- (void)reload:(UIBarButtonItem *)sender
{
    [webView reload];
}

// Back
- (void)back:(UIBarButtonItem *)sender
{
    [webView goBack];
}

// Forward
- (void)forward:(UIBarButtonItem *)sender
{
    [webView goForward];
}

- (void)webViewDidFinishLoad:(UIWebView *)_mobileSite
{
    [_loadingText setHidden:YES];
    [_loadingSpinner setHidden:YES];
    [_loadingSpinner stopAnimating];

    //canGoBack and canGoForward are properties which indicate if there is any forward or backward history
    if (_mobileSite.canGoBack == YES)
    {
        _back.enabled = YES;
    }
    if (_mobileSite.canGoForward == YES)
    {
        _forward.enabled = YES;
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

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
