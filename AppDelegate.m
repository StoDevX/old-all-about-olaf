//
//  AppDelegate.m
//  Olaf
//
//  Created by Drew Volz on 7/26/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    [NSThread sleepForTimeInterval:0.5]; //add 0.5 seconds longer to start image

    // This allows us to customize the text color of our UINaviagtionBar
    [[UINavigationBar appearance]  setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    // This allows us to customize the color of our UINavigationBar navigation item
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // This allows us to customize the color of our UINaviagtionBar
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:252.0f/255.0f green:166.0f/255.0f blue:44.0f/255.0f alpha:1.0]];

    // This allows us to play audio in the background as well as ignore vibrate/silent switch
    // by creating a separate thread
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    
    // This allows us to work with Parse in order to save information to the cloud
    [Parse setApplicationId:@"xtocr2xOZJojqHEtNRcF75JnLwJ3IRm2pzEBg9AF"
                  clientKey:@"NcIHdz219z3YFqUZk5fmqllXyiOJPXg0Am2lDem3"];
    
    return YES;
}


- (NSUInteger)application:(UIApplication*)application supportedInterfaceOrientationsForWindow:(UIWindow*)window
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{

    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
