//
//  RadioViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/9/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "RadioViewController.h"

@interface RadioViewController ()
@property (strong, nonatomic) MPMoviePlayerController *streamPlayer;
@end

@implementation RadioViewController

@synthesize streamPlayer = _streamPlayer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *streamURL = [NSURL URLWithString:@"http://stolaf-flash.streamguys.net/radio/ksto1.stream/playlist.m3u8"];
    _streamPlayer = [[MPMoviePlayerController alloc] initWithContentURL:streamURL];

    // depending on your implementation your view may not have it's bounds set here
    // in that case consider calling the following 4 msgs later
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    [self.streamPlayer.view setFrame:CGRectMake(0, 395, height = 320, width = 38)];
    self.streamPlayer.controlStyle = MPMovieControlStyleEmbedded;
    [self.view addSubview:self.streamPlayer.view];
    [self.streamPlayer play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
