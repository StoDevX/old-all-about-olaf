//
//  LegalTextViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/12/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController
@synthesize toolbar;
@synthesize navBar;

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

    // size up the toolbar and set its frame
    // please note that it will work only for views without Navigation toolbars.
    CGFloat toolbarHeight = [toolbar frame].size.height;

    CGRect mainViewBounds = self.view.bounds;
    [toolbar setFrame:CGRectMake(CGRectGetMinX(mainViewBounds),
                                 CGRectGetMinY(mainViewBounds) + CGRectGetHeight(mainViewBounds) - (toolbarHeight),
                                 CGRectGetWidth(mainViewBounds),
                                 toolbarHeight)];

    UITextView *myUITextView = [[UITextView alloc] initWithFrame:CGRectMake(10, -60, CGRectGetWidth(mainViewBounds) - 50, CGRectGetHeight(mainViewBounds) - 50)];
    myUITextView.text = @"________________________________\n\nGeographic Position\n________________________________\n\nThis application may use User location Data in order to provide location-based services. Most browsers and devices provide tools to opt out from this feature by default. If explicit authorization has been provided, the User’s location data may be tracked by this Application only while the User is using the map.\n\nThe User's data is not used for anything other than displaying their current location.\n\n________________________________\n\nSIS Account\n________________________________\n\nThis application may use User financial and schedule data in order to provide personalized information.\n\nThe User's data is not used for anything other than displaying their account information.\n";

    myUITextView.textColor = [UIColor blackColor];
    myUITextView.font = [UIFont systemFontOfSize:15.5];
    [myUITextView setBackgroundColor:[UIColor clearColor]];
    myUITextView.editable = NO;
    myUITextView.scrollEnabled = YES;
    [_legalText addSubview:myUITextView];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
