//
//  RecipeDetailViewController.h
//  RecipeApp
//
//  Created by Simon on 23/12/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "RecipeTableViewController.h"

@interface RecipeDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *ingredientsTextView;
@property (weak, nonatomic) IBOutlet UILabel *wordTitle;
@property (nonatomic, strong) UISegmentedControl* nextPrevSegmentedControl;

@property (nonatomic, strong) Recipe *recipe;
@property (nonatomic, strong) NSMutableArray *recipeList;
@property (nonatomic, assign) int theIndex;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) bool displaySegments;

@end
