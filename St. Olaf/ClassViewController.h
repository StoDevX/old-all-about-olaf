//
//  ClassViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/21/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
@interface ClassViewController : UITableViewController<UIAlertViewDelegate, UISearchBarDelegate>{
    
    UIView *subView;
}
@property (nonatomic, retain) UIView *subView;
@property (nonatomic, retain) UIView *overlayView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)changeWebsite;

@end

