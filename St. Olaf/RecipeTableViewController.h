//
//  CustomTableViewController.h
//  CustomTable
//
//  Created by Simon on 7/12/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

//@interface RecipeTableViewController : UITableViewController
@interface RecipeTableViewController : PFQueryTableViewController

@property (strong, nonatomic) NSArray *recipes;
@property (nonatomic, assign) int myInt;
@property (nonatomic, assign) int countOfParseObjs;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addWord;

@property (nonatomic) int height;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSArray *searchResults;
@end
