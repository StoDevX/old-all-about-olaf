//
//  AboutViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "AboutViewController.h"
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize contactMe;


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 2){
        if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        NSArray *toRecipients = [NSArray arrayWithObjects:@"support@drewvolz.com",nil];
        [controller setToRecipients:toRecipients];
        [controller setSubject:@"St. Olaf App Support"];
        [controller setMessageBody:@"" isHTML:YES];
            if (controller) [self presentViewController:controller animated:YES completion:nil];
        }
    }
}




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    {
        [super viewDidLoad];
        
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It has sent!");
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
