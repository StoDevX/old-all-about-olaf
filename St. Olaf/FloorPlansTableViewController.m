//
//  FloorPlansTableViewController.m
//  Oleville
//
//  Created by Drew Volz on 4/12/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "FloorPlansTableViewController.h"
#import "DetailTableViewController.h"
#import "Hall.h"

@interface FloorPlansTableViewController ()

@end

@implementation FloorPlansTableViewController
{
    NSArray *academicHall;
    NSArray *halls;
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
    [super viewDidLoad];


    
    // Initialize the hall array
    Hall *Ellingson = [Hall new];
    Ellingson.name = @"Ellingson";
    Ellingson.cover = @"ellingson.png";
    Ellingson.tour = @"ellingson.mov";
    Ellingson.floorPlan = @"ellingson1_plan";
    Ellingson.cellSize = 180;
    Ellingson.descrip = [NSArray arrayWithObjects:@"Ellingson Hall, housing 186 students, is a four-story building that serves as the central location for students in the Great Conversation program. This setting provides an intellectual atmosphere as well as an excellent chance for socialization and the development of a core group of friends. Great Con students represent about one-quarter of Ellingson residents and typically room with students who are not in the program.", nil];
    
    Hall *Thorson = [Hall new];
    Thorson.name = @"Thorson";
    Thorson.cover = @"Thorson.png";
    Thorson.tour = @"Thorson.mov";
    Thorson.floorPlan = @"thorson1_plan";
    Thorson.cellSize = 140;
    Thorson.descrip = [NSArray arrayWithObjects:@"Thorson Hall is a beautiful, recently renovated building housing 235 students. It offers a spacious back yard with a patio and provides a striking view of the Northfield community. It has several features, most notably its spacious lounge that is a favorite study and conversation spot.", nil];

    /* ********************************************************************* */
    
     Hall *Buntrock = [Hall new];
     Buntrock.name = @"Buntrock Commons";
     Buntrock.cover = @"buntrock.png";
     Buntrock.tour = @"Buntrock.mov";
     Buntrock.floorPlan = @"buntrockfloor1map";
     Buntrock.cellSize = 110;
     Buntrock.descrip = [NSArray arrayWithObjects:@"The Buntrock Commons is the community center for the St. Olaf campus, serving all of the members of the college family — students, faculty, staff, alumni, parents, friends, and supporters.", nil];
    
    Hall *Rolvaag = [Hall new];
    Rolvaag.name = @"Rolvaag Memorial Library";
    Rolvaag.cover = @"rolvaag.png";
    Rolvaag.tour = @"Rolvaag.mov";
    Rolvaag.floorPlan = @"rolvaag";
    Rolvaag.cellSize = 125;
    Rolvaag.descrip = [NSArray arrayWithObjects:@"Completed in 1942, Rølvaag Library is the largest of three libraries on the St. Olaf campus. Together the St. Olaf libraries house approximately 420,000 books, 22,000 media items, 5,000 periodical titles, and 18,000 scores.", nil];
    
    
    
    academicHall = [NSArray arrayWithObjects: Buntrock, Rolvaag, nil];
    halls = [NSArray arrayWithObjects: Ellingson, Thorson, nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
           return [halls count];
           break;
        case 1:
           return [academicHall count];
           break;
    }
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        // Display recipe in the table cell
        Hall *hall = nil;

        hall = [halls objectAtIndex:indexPath.row];
        
        cell.textLabel.text = hall.name;
    }
    else if (indexPath.section == 1) {
        // Display recipe in the table cell
        Hall *hall = nil;
        
        hall = [academicHall objectAtIndex:indexPath.row];
        
        cell.textLabel.text = hall.name;
    }
    
    return cell;
}
        
        
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Residence", @"Residence");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Academic", @"Academic");
            break;
    }
    return sectionName;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"residence"]) {
        NSIndexPath *indexPath = nil;
        
        Hall *returnMe = nil;

        if(indexPath.section == 0) {
            indexPath = [self.tableView indexPathForSelectedRow];
            returnMe = [halls objectAtIndex:indexPath.row];
        }
        if(indexPath.section == 1) {
            indexPath = [self.tableView indexPathForSelectedRow];
            returnMe = [academicHall objectAtIndex:indexPath.row];
        }
        
        DetailTableViewController *destViewController = segue.destinationViewController;
        destViewController.hall = returnMe;
    }
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



@end
