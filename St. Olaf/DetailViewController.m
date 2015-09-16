//
//  DetailViewController.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//

#import "DetailViewController.h"
#import "RSSItem.h"

@interface DetailViewController ()

@property (nonatomic, strong) IBOutlet UIBarButtonItem *shareButton;

@property (nonatomic, strong) UIActivityViewController *activityViewController;

- (IBAction)shareButtonPressed:(id)sender;

@end

@implementation DetailViewController
@synthesize subView;

//We do not need to hesitate on loading the story as it has already been downloaded at this stage.
- (void)viewDidLoad
{
    [super viewDidLoad];
    RSSItem *item = (RSSItem *)self.detailItem;
    self.title = item.title;

    //Detecting trailers
    if ([item.title rangeOfString:@"Honest Trailers"].location != NSNotFound)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        NSURLRequest *req = [NSURLRequest requestWithURL:item.link];

        UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        [webview loadRequest:req];
        [self.view addSubview:webview];
    }

    //Detecting full story link to another page...
    if ([item.contentEncoded rangeOfString:@"Read the full story here"].location != NSNotFound)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        NSURLRequest *req = [NSURLRequest requestWithURL:item.link];

        UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        [webview loadRequest:req];
        [self.view addSubview:webview];
    }

    //Detecting YouTube story...
    if ([item.title rangeOfString:@"PSA:"].location != NSNotFound)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        NSURLRequest *req = [NSURLRequest requestWithURL:item.link];

        UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        [webview loadRequest:req];
        [self.view addSubview:webview];
    }

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;

    UITextView *myUITextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 275, screenHeight - 65)];

    NSString *one = item.title;
    NSString *lineBreak = @"________________________________";
    NSString *two = item.contentEncoded;

    //NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    //NSArray* matches = [detector matchesInString:item.contentEncoded options:0 range:NSMakeRange(0, [item.contentEncoded length])];

    NSString *theRealDeal = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", @"\n", one, @"\n", lineBreak, @"\n\n", two, @"\n"];

    myUITextView.text = theRealDeal;

    myUITextView.textColor = [UIColor blackColor];
    myUITextView.font = [UIFont systemFontOfSize:16];
    [myUITextView setBackgroundColor:[UIColor clearColor]];
    myUITextView.editable = NO;
    myUITextView.scrollEnabled = YES;
    //myUITextView.dataDetectorTypes = UIDataDetectorTypeAll;

    [_fullStory addSubview:myUITextView];
}

//This is the share menu
- (IBAction)shareButtonPressed:(id)sender
{
    RSSItem *item = (RSSItem *)self.detailItem;

    UISimpleTextPrintFormatter *printData = [[UISimpleTextPrintFormatter alloc] initWithText:item.contentEncoded];

    self.activityViewController = [[UIActivityViewController alloc]
        initWithActivityItems:@[ item.title, @"\n", item.link, printData ]
        applicationActivities:nil];
    [self presentViewController:self.activityViewController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
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

@end