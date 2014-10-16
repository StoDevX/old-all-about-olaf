//
//  MovieViewController.h
//  Oleville
//
//  Created by Drew Volz on 2/16/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MovieViewController : UITableViewController
@property (nonatomic, retain) UIView *subView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
