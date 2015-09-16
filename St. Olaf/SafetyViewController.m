//
//  SafetyViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/14/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "SafetyViewController.h"

@interface SafetyViewController ()

@end

@implementation SafetyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// Header Titles Setion Heights
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

// Cell heights
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

// Customizing cells in sections
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://5076454475"]];
        }
        if (indexPath.row == 1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://18002221222"]];
        }
        if (indexPath.row == 2)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://5077863666"]];
        }
        if (indexPath.row == 3)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://5077863666"]];
        }
        if (indexPath.row == 4)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://5077863777"]];
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

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
