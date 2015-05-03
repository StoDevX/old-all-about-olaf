//
//  socialViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/9/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "socialViewController.h"

@interface socialViewController ()

@end

@implementation socialViewController

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
    NSString *urlString = @"https://www.facebook.com/pages/St-Olaf-College/136842418331";
    //2
    NSURL *url = [NSURL URLWithString:urlString];
    //3
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //4
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //5
    [NSURLConnection sendAsynchronousRequest:request queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ([data length] > 0 && error == nil) [_webView loadRequest:request];
                               else if (error != nil) NSLog(@"Error: %@", error);
                           }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeWebsite
{
    if (_segment.selectedSegmentIndex == 0)
    {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.facebook.com/pages/St-Olaf-College/136842418331"]]];
    }
    else
    {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://twitter.com/StOlaf"]]];
    }
}
@end
