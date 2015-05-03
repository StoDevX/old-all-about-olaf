//
//  BalancesTableViewController.m
//  All About Olaf
//
//  Created by Drew Volz on 8/9/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "BalancesTableViewController.h"

@interface BalancesTableViewController ()

@end

@implementation BalancesTableViewController
@synthesize subView;
// finances
@synthesize printBalanceLabel;
@synthesize oleBalanceLabel;
@synthesize flexBalanceLabel;
@synthesize dailyMealsLabel;
@synthesize weeklyMealsLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Account Balances";

    //**************************************************************
    // Using the plist called "special" for use of populating
    // UITableViewCells with downloaded info:
    //      - printing money
    //      - flex dollars
    //      - ole dollars
    //      - course data
    //**************************************************************

    //Property List Functions
    _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory = [_paths objectAtIndex:0];
    _path = [_documentsDirectory stringByAppendingPathComponent:@"special.plist"];
    _fileManager = [NSFileManager defaultManager];

    // Create the other inital values for the first time
    _savedInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:_path];

    // If we haven't logged-in yet, show other things to the user
    if ([[_savedInfo objectForKey:@"loggedIn"] intValue] == 0)
    {
        CGRect frame = [[UIScreen mainScreen] bounds];
        subView = [[UIView alloc] initWithFrame:frame];
        subView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:subView];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Logged-In" message:@"Please login to view your balances." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }
    else
    {
        [subView removeFromSuperview];
        flexBalanceLabel.text = [_savedInfo objectForKey:@"flexDollars"];
        oleBalanceLabel.text = [_savedInfo objectForKey:@"oleDollars"];
        printBalanceLabel.text = [_savedInfo objectForKey:@"printMoney"];
    }
}

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger theRows = 0;
    if (section == 0)
    {
        theRows = 3;
    }
    else if (section == 1)
    {
        theRows = 2;
    }

    return theRows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *theTitle = @"";

    if ([[_savedInfo objectForKey:@"loggedIn"] intValue] == 0)
    {
        return @"";
    }
    else
    {
        if (section == 0)
        {
            theTitle = @"Balances";
        }
        else if (section == 1)
        {
            theTitle = @"Meal Plan";
        }
    }
    return theTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    // SECTION 1
    if (indexPath.row == 0 && indexPath.section == 0)
    {
        flexBalanceLabel.text = [_savedInfo objectForKey:@"flexDollars"];
    }

    if (indexPath.row == 1 && indexPath.section == 0)
    {
        oleBalanceLabel.text = [_savedInfo objectForKey:@"oleDollars"];
    }

    if (indexPath.row == 2 && indexPath.section == 0)
    {
        printBalanceLabel.text = [_savedInfo objectForKey:@"printMoney"];
    }

    // SECTION 2
    if (indexPath.row == 0 && indexPath.section == 1)
    {
        dailyMealsLabel.text = [_savedInfo objectForKey:@"dailyMeals"];
    }

    if (indexPath.row == 1 && indexPath.section == 1)
    {
        weeklyMealsLabel.text = [_savedInfo objectForKey:@"weeklyMeals"];
    }

    return cell;
}

@end
