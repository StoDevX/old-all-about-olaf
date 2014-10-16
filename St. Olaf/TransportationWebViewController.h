//
//  TransportationWebViewController.h
//  Oleville
//
//  Created by Drew Volz on 3/24/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransportationWebViewController : UIViewController
@property (nonatomic, retain) UIView *subView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *share;
- (IBAction)shareButtonPressed:(id)sender;
@property (nonatomic, strong) UIActivityViewController *activityViewController;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *loadingText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;

@property (strong, nonatomic) id passMePlease;
@end
