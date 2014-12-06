//
//  CustomTableViewController.h
//  CustomTable
//
//  Created by Simon on 7/12/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeTableViewController : UITableViewController
@property (strong,nonatomic) NSArray *recipes;
@property (strong,nonatomic) NSArray *searchResults;
@property (nonatomic, assign) int myInt;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addWord;
@end
