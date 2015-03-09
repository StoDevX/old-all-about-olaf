//
//  FirstViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize arrayTag;
@synthesize tableView;

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

    // Setting up moving our tableviewcell positions
    arrayTag = [[NSMutableArray alloc] init];
    // Display an Edit button in the navigation bar
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Moving our tableview where we want it to be
    UIEdgeInsets inset = UIEdgeInsetsMake(-35, 0, -35, 0);
    self.tableView.contentInset = inset;

    
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
    _savedInfo = [[NSMutableDictionary alloc] initWithContentsOfFile: _path];
    NSString *printMoney = @"";
    NSString *oleDollars = @"";
    NSString *flexDollars = @"";
    NSString *dailyMeals = @"";
    NSString *weeklyMeals = @"";

    
    if ([_fileManager fileExistsAtPath: _path])
    {
        _data = [[NSMutableDictionary alloc] initWithContentsOfFile: _path];
    }
    // If the file doesn’t exist, create an empty dictionary
    else
    {
        _data = [[NSMutableDictionary alloc] init];
        
        // write our data into it
        [_data setObject: [NSString stringWithString: printMoney]  forKey:@"printMoney"];
        [_data setObject: [NSString stringWithString: oleDollars]  forKey:@"oleDollars"];
        [_data setObject: [NSString stringWithString: flexDollars] forKey:@"flexDollars"];
        [_data setObject: [NSString stringWithString: dailyMeals] forKey:@"dailyMeals"];
        [_data setObject: [NSString stringWithString: weeklyMeals] forKey:@"weeklyMeals"];
        
        [_data setObject: [NSNumber numberWithInt:0]               forKey:@"loggedIn"];

        [_data writeToFile: _path atomically:YES];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated
{
    // Clear selection of rows
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:animated];
    [super viewWillDisappear:animated];
}



// Height of each table cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.5;
}


// Reordering the tableviewcells
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = [arrayTag objectAtIndex:sourceIndexPath.row];
    [arrayTag removeObjectAtIndex:sourceIndexPath.row];
    [arrayTag insertObject:stringToMove atIndex:destinationIndexPath.row];
}


 // Override to support conditional editing of the table view.
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
     // Return NO if you do not want the specified item to be editable.
     return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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
    // Dispose of any resources that can be recreated.
}





@end
