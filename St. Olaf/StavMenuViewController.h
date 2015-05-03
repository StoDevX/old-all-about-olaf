//
//  StavMenuViewController.h
//  Oleville
//
//  Created by Drew Volz on 2/26/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StavMenuViewController : UIViewController <UIAlertViewDelegate>
{
    UIView *subView;
}
@property (nonatomic, retain) UIView *subView;
@property (weak, nonatomic) IBOutlet UIWebView *mobileSite;
@property (nonatomic, retain) UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *loadingMenuText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingMenuSpinner;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;

@end