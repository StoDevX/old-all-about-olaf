//
//  socialViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/9/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface socialViewController : UIViewController{
    UIView *subView;
}
@property (nonatomic, retain) UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *loadingText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

@property (nonatomic, retain) UIView *subView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)changeWebsite;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIScrollView *textView;

@property (nonatomic,strong) AVAudioPlayer *music;
@property (weak, nonatomic) IBOutlet UILabel *noNetwork;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;

@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@end
