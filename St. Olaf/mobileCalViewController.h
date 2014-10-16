//
//  mobileCalViewController.h
//  Oleville
//
//  Created by Drew Volz on 3/16/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mobileCalViewController : UIViewController<UIAlertViewDelegate>{
    
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
