//
//  BalancesTableViewController.h
//  All About Olaf
//
//  Created by Drew Volz on 8/9/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalancesTableViewController : UITableViewController
@property (nonatomic, retain) UIView *subView;

@property (weak, nonatomic) IBOutlet UILabel *printBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oleBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *flexBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyMealsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeklyMealsLabel;

@property (strong, nonatomic) NSArray *paths;
@property (strong, nonatomic) NSString *documentsDirectory;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSFileManager *fileManager;
@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) NSMutableDictionary *savedInfo;
@end
