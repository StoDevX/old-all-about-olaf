//
//  mobileSiteViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/11/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mobileSiteViewController : UIViewController <UIAlertViewDelegate>
{
    UIView *subView;
    UIActivityIndicatorView *activityIndicator;
}
@property (nonatomic, retain) UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *loadingText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

@property (nonatomic, retain) UIView *subView;
@property (weak, nonatomic) IBOutlet UIWebView *mobileSite;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;

@end
