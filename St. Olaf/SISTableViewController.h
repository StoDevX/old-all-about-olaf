//
//  SISTableViewController.h
//  Oleville
//
//  Created by Drew Volz on 4/5/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseLoader.h"

@interface SISTableViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate>

// View Elements
@property (strong, nonatomic) IBOutlet UIRefreshControl *refreshControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginButton;

// Stored Secure Data
@property (strong, nonatomic) UITextField *username;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) NSUserDefaults *prefs;

// Stored Requests
@property (strong, nonatomic) NSData *financeData;
@property (strong, nonatomic) CourseLoader *courseList;
// Parsed Data
// finances
@property (strong, nonatomic) NSMutableArray *balances;
@property (strong, nonatomic) NSString *printingBalance;
@property (strong, nonatomic) NSString *oleBalance;
@property (strong, nonatomic) NSString *flexBalance;

// Stored dictionary of data
@property (strong, nonatomic) NSMutableDictionary *finances;

@property (strong, nonatomic) NSArray *paths;
@property (strong, nonatomic) NSString *documentsDirectory;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSFileManager *fileManager;
@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) NSMutableDictionary *savedInfo;

@end