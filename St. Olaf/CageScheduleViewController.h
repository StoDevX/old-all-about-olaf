//
//  CageScheduleViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 11/9/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>


@interface CageScheduleViewController : UITableViewController<UIAlertViewDelegate>{
    
    UIView *subView;
}
@property (nonatomic, retain) UIView *subView;
+ (NSString *)stringByStrippingHTML:(NSString *)inputString;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *noMenuText;


@end