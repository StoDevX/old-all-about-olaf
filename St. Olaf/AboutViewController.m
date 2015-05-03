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

@interface AboutViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet UISwipeGestureRecognizer *swipeLeftRecognizer;

@end

@implementation AboutViewController
@synthesize contactMe;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // We are in the credits

    /* messing with swipe gestures...
        UISwipeGestureRecognizer * Swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
        Swipeleft.direction=UISwipeGestureRecognizerDirectionUp;
        [self.view addGestureRecognizer:Swipeleft];
        */

    // We are in the support
    if (indexPath.row == 4)
    {
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            NSArray *toRecipients = [NSArray arrayWithObjects:@"support@drewvolz.com", nil];
            [controller setToRecipients:toRecipients];
            [controller setSubject:@"Support"];
            [controller setMessageBody:@"" isHTML:YES];
            if (controller)
                [self presentViewController:controller animated:YES completion:nil];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

//messing with swipe gestures...
/*-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Available" message:@"Please connect to a network." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert show];
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error;
{
    if (result == MFMailComposeResultSent)
    {
        //NSLog(@"It has sent!");
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
