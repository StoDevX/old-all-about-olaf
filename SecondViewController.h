//
//  SecondViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *noEventsLabel;

@end
