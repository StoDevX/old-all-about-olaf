//
//  FirstViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UITableViewController
{
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITableViewCell *newsButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *buildingButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *aboutButton;

@property (strong, nonatomic) NSArray *paths;
@property (strong, nonatomic) NSString *documentsDirectory;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSFileManager *fileManager;
@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) NSMutableDictionary *savedInfo;

@property (strong, nonatomic) NSMutableArray *arrayTag;
@end
