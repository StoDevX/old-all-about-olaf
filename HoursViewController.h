//
//  HoursViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoursViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

//***************************
// These are the image files
//***************************
//Food
@property (weak, nonatomic) IBOutlet UIImageView *stavCircle;
@property (weak, nonatomic) IBOutlet UIImageView *cageCircle;
@property (weak, nonatomic) IBOutlet UIImageView *pauseCircle;
@property (weak, nonatomic) IBOutlet UIImageView *norwayCircle;

//Libraries
@property (weak, nonatomic) IBOutlet UIImageView *rolvaagCircle;
@property (weak, nonatomic) IBOutlet UIImageView *hustadCircle;
@property (weak, nonatomic) IBOutlet UIImageView *halvarsonCircle;

//Supplies and Books
@property (weak, nonatomic) IBOutlet UIImageView *bookStore;
@property (weak, nonatomic) IBOutlet UIImageView *convenienceStore;

//Mail and Packages
@property (weak, nonatomic) IBOutlet UIImageView *postOfficeCircle;

//Gym
@property (weak, nonatomic) IBOutlet UIImageView *skoglundCircle;



@end
