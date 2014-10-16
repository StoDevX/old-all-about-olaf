//
//  PauseMenuViewController.m
//  Oleville
//
//  Created by Drew Volz on 2/1/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "PauseMenuViewController.h"

@interface PauseMenuViewController ()

@end

@implementation PauseMenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) {     // 1st section
        if(indexPath.row == 0){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://5077866969"]];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.toolbar setHidden: NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.toolbar setHidden: NO];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
