//
//  movieBusViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/22/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface movieBusViewController : UIViewController<UIAlertViewDelegate>{
    
    UIView *subView;
}
@property (nonatomic, retain) UIView *subView;

@property (nonatomic, retain) UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *loadingText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;

@end
