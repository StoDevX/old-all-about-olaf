//
//  AboutViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <QuartzCore/QuartzCore.h>

@interface AboutViewController : UITableViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *contactMe;

@end
