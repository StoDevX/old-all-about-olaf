//
//  RadioViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/9/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "RadioViewController.h"
#import "XPathQuery.h"
#import "TFHpple.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>

@interface RadioViewController ()
@property (strong, nonatomic) MPMoviePlayerController *streamPlayer;
@end

@implementation RadioViewController
@synthesize nowPlayingText;
@synthesize nowPlayingToolbar;

@synthesize streamPlayer = _streamPlayer;

- (void)viewDidLoad
{
    if([self hasConnectivity] == NO) {
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        subView = [[UIView alloc] initWithFrame:frame];
        subView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:subView];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    
    else {
        
        NSURL *streamURL = [NSURL URLWithString:@"http://stolaf-flash.streamguys.net/radio/ksto1.stream/playlist.m3u8"];
        _streamPlayer = [[MPMoviePlayerController alloc] initWithContentURL:streamURL];
        
        // depending on your implementation your view may not have it's bounds set here
        // in that case consider calling the following 4 msgs later
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        
        [self.streamPlayer.view setFrame:CGRectMake(0, 485 ,height=0, width=0)];
        self.streamPlayer.controlStyle = MPMovieControlStyleNone;
        [self.view addSubview: self.streamPlayer.view];
        [self.streamPlayer play];
        
        [UIApplication sharedApplication].idleTimerDisabled = YES;
        
        

        //******************************
        // Goal: pull in the Radio page and parse out the now-playing information
        //******************************
        
        //Playing text
        NSString *title = @"";
        
         //*******************************
         // Begin the web-scraping process
         //******************************
        
         //Get the URL we want to parse and throw that baby into a NSURL
         NSURLRequest *request = [[NSURLRequest alloc] initWithURL:
         [NSURL URLWithString:[NSString stringWithFormat:@"http://www.stolaf.edu/multimedia/play/embed/ksto.html"]]];
         
         //Error object in case we get one...
         NSError *error;
         //Response from the URL
         NSURLResponse *response;
         //The wonderful funderful NSData object that pases our synchronous request and schmoozes with the wizards in the internet world
         NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
         //The awesome TFHpple object which parses all of our data
         TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:urlData];
         
         //We tell the parser where to look in the HTML code
         NSArray *nowPlayingInfo = [xpathParser searchWithXPathQuery:@"//div[@id='meta']"];
        
         //TITLE
         //The parser looks for the "h4" tag which contains the movie title
         for (TFHppleElement * element in nowPlayingInfo) {
             title = nowPlayingInfo[0];
         }
        NSLog(@"%@", title);


        self.nowPlayingToolbar.clipsToBounds = YES;



        // Set-up for the call button for the station phone
        [_callStation setTarget:self];
        [_callStation setAction:@selector(callTheStation:)];

    }
}

- (IBAction)callTheStation:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://5077863602"]];
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

