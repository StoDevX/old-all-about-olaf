//
//  bcplazaViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/11/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "bcplazaViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface bcplazaViewController ()

@property (strong, nonatomic) MPMoviePlayerController *streamPlayer;

@end

@implementation bcplazaViewController

@synthesize streamPlayer = _streamPlayer;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([self hasConnectivity] == NO) {
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        subView = [[UIView alloc] initWithFrame:frame];
        subView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:subView];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }

    else{
        NSURL *streamURL = [NSURL URLWithString:@"http://stolaf-flash.streamguys.net/webcams/bcplaza.stream/playlist.m3u8"];
        _streamPlayer = [[MPMoviePlayerController alloc] initWithContentURL:streamURL];
        
        // depending on your implementation your view may not have it's bounds set here
        // in that case consider calling the following 4 msgs later
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        self.streamPlayer.view.center = self.view.center;
        
        
        // Screen size detection...
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize calc = [[UIScreen mainScreen] bounds].size;
            if(calc.height <= 480)
            {
                // iPhone Classic
                [self.streamPlayer.view setFrame:CGRectMake( 0, 0, height=320, width=480 )];
            }
            if(calc.height >= 568)
            {
                // iPhone 5
                [self.streamPlayer.view setFrame:CGRectMake( 5, 10, height=310, width=580 )];
            }
        }

        [self.streamPlayer.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        self.streamPlayer.controlStyle = MPMovieControlStyleNone;
        [self.view addSubview: self.streamPlayer.view];
        [self.streamPlayer play];


        /*
        // Detect if we are trying to swipe to change webcams
        UISwipeGestureRecognizer *recognizerForward = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromForward:)];
        recognizerForward.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:recognizerForward];
        
        UISwipeGestureRecognizer *recognizerBackward = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromBackward:)];
        recognizerBackward.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:recognizerBackward];
        
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
        */
         
         
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleBars:)];
        [self.view addGestureRecognizer:singleTap];
        singleTap.delegate = self;
        
    }
}


/*
// Handle webcam swipe action
-(void)handleSwipeFromBackward:(UISwipeGestureRecognizer *)recognizerBackward
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Alumni"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navController animated:NO completion:nil];
}

-(void)handleSwipeFromForward:(UISwipeGestureRecognizer *)recognizerForward
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Quad"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navController animated:NO completion:nil];
}
*/


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


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

-(BOOL)shouldAutorotate
{
    return YES;
}


- (void)toggleBars:(UITapGestureRecognizer *)gesture
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    BOOL statusBarHidden = YES;
    
    BOOL barsHidden = self.navigationController.navigationBar.hidden;
    [self.navigationController setNavigationBarHidden:!barsHidden animated:YES];
    
    
    if (([UIApplication sharedApplication].statusBarHidden = YES))
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
