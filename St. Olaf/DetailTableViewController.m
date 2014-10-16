//
//  DetailTableViewController.m
//  Oleville
//
//  Created by Drew Volz on 4/12/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "DetailTableViewController.h"
#import "FloorPlansTableViewController.h"
#import "FloorPlanViewController.h"
#import "Hall.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

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
    [super viewDidLoad];
	
    self.title = self.hall.name;
    self.displayMe.image = [UIImage imageNamed: self.hall.cover];
    self.tableView.backgroundColor = [UIColor whiteColor];

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = self.hall.descrip.firstObject;
            [cell.textLabel setNumberOfLines:0];
            [cell.textLabel setLineBreakMode:UILineBreakModeWordWrap];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else if (indexPath.row == 1) {
            if([self.hall.name  isEqual: @"Ellingson"]) {
                cell.textLabel.text = @"";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else {
                cell.textLabel.text = @"Floor Plans";
            }
        }
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float result = 0.0;
    
    if (indexPath.row == 0) {
        result = self.hall.cellSize;
    }
    else if(indexPath.row == 1) {
        if([self.hall.name  isEqual: @"Ellingson"]) {
            result = 0;
        }
        else
        result = 40;
    }
    else if(indexPath.row == 2) {
        result = 40;
    }
    return result;
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



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"floorPlan"]) {
        FloorPlanViewController *destViewController = segue.destinationViewController;
        destViewController.thePDF = self.hall.floorPlan;
    }
}

@end
