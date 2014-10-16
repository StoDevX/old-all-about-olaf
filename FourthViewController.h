//
//  FourthViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 7/26/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface FourthViewController : UIViewController<UIAlertViewDelegate>{
    
    UIView *subView;
}
@property (nonatomic, retain) UIView *subView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, retain) UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *loadingText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forward;
@end
