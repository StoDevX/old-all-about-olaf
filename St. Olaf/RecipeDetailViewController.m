//
//  RecipeDetailViewController.m
//  RecipeApp
//
//  Created by Simon on 23/12/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "RecipeTableViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController
@synthesize recipeList;
@synthesize theIndex;
@synthesize count;
@synthesize displaySegments;
@synthesize nextPrevSegmentedControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Add switchers for definitions
    count = 0;

    // Check and see if we want to display the controls (if we are not searching)
    if (displaySegments)
    {
        // Prepare an array of segmented control items as images
        NSArray *nextPrevItems = [NSArray arrayWithObjects:[UIImage imageNamed:@"down.png"], [UIImage imageNamed:@"up.png"], nil];
        // Create the segmented control with the array from above
        nextPrevSegmentedControl = [[UISegmentedControl alloc] initWithItems:nextPrevItems];
        // Change the size
        nextPrevSegmentedControl.frame = CGRectMake(10, 50, 79, 30);
        // Assign it to the function
        [nextPrevSegmentedControl addTarget:self action:@selector(segmentSwitch:) forControlEvents:UIControlEventValueChanged];
        // Create the bar button item with the segmented control from above
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:nextPrevSegmentedControl];
        // Add the bar button item from above to the navigation item
        [self.navigationItem setRightBarButtonItem:rightButton animated:YES];
    }

    self.title = self.recipe.name;
    self.wordTitle.text = self.recipe.name;

    NSMutableString *ingredientsText = [NSMutableString string];
    for (NSString *ingredient in self.recipe.ingredients)
    {
        [ingredientsText appendFormat:@"%@\n", ingredient];
    }
    self.ingredientsTextView.text = ingredientsText;
    [self.ingredientsTextView setEditable:NO];
}

// Prevent modification of local text (although it is only changed on the view temporariliy)
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

/***********************************
 Segmented control up and down
 **********************************/
- (IBAction)segmentSwitch:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;

    // This magical piece of code makes the segment reset. SWEETPOTATO BABY JESUS
    segmentedControl.momentary = YES;

    // Fix me... this is a bad example of how to program. Fix the problem instead of ignoring the error.
    @try
    {
        // Check if we are trying to go forward, and that we are not at the last word
        if (selectedSegment == 0)
        {
            // NEXT
            count++;
            self.recipe = recipeList[theIndex + count];
            self.title = self.recipe.name;
            self.wordTitle.text = self.recipe.name;
            self.ingredientsTextView.text = self.recipe.ingredients[0];
            [self.ingredientsTextView setEditable:NO];
        }
        // Check if we are trying to go backward, and that we are not at the fist word
        else if (selectedSegment == 1)
        {
            // PREV
            count--;
            self.recipe = recipeList[theIndex + count];
            self.title = self.recipe.name;
            self.wordTitle.text = self.recipe.name;
            self.ingredientsTextView.text = self.recipe.ingredients[0];
            [self.ingredientsTextView setEditable:NO];
        }
    }
    @catch (NSException *e)
    {
    }

    // Disable selection of segment (for UI purposes... otherwise it "sticks"
    [nextPrevSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
