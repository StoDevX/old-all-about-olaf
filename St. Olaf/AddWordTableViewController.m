//
//  AddWordTableViewController.m
//  All About Olaf
//
//  Created by Drew Volz on 12/3/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "AddWordTableViewController.h"
#import <Parse/Parse.h>

@interface AddWordTableViewController ()

@end

@implementation AddWordTableViewController
@synthesize myTextFieldWord;
@synthesize myTextViewDef;
@synthesize currentResponder;
@synthesize submitBtn;
@synthesize cancelBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //title
    self.title = @"Add Definition";
    
    
    // Tap recognizer to allow user to hide keyboard quickly when touching the surrounding view
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [self.tableView addGestureRecognizer:tap];
    
    
    // Display a cancel button in the navigation bar for this view controller.
    cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    // Display a submit button in the navigation bar for this view controller.
    submitBtn = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    self.navigationItem.rightBarButtonItem = submitBtn;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Have this here in order to hide the keyboard input when we pop the view
- (void)viewWillDisappear:(BOOL)animated
{
    [myTextFieldWord resignFirstResponder];
    [myTextViewDef resignFirstResponder];
    [super viewWillDisappear:animated];
}



// method to hide keyboard when user taps on a scrollview
- (void)resignOnTap:(id)sender
{
    [myTextViewDef resignFirstResponder];
    [myTextFieldWord resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentResponder = textField;
}

// Resign the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return true;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
        // Word
        if ([indexPath section] == 0) {
            myTextFieldWord = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, tableView.frame.size.width - 30, 44)];
            
            myTextFieldWord.autocorrectionType = UITextAutocorrectionTypeNo;
            myTextFieldWord.autocapitalizationType = UITextAutocapitalizationTypeWords;
            [myTextFieldWord setClearButtonMode:UITextFieldViewModeWhileEditing];
            
            myTextFieldWord.keyboardType = UIKeyboardTypeDefault;
            
            myTextFieldWord.placeholder = @"Tap here to get started";
            
            cell.accessoryView = myTextFieldWord;
            [tableView addSubview:myTextFieldWord];
        }
        // Definition: we use a textview here instead of a textfield so we can scroll and hit enter
        if ([indexPath section] == 1) {
            myTextViewDef = [[UITextView alloc]initWithFrame:CGRectMake(99, 0, tableView.frame.size.width - 30, 112)];
            [myTextViewDef setBackgroundColor:[UIColor clearColor]];
            myTextViewDef.userInteractionEnabled = YES;
            myTextViewDef.delegate = self;
            
            // Set font size
            [myTextViewDef setFont:[UIFont systemFontOfSize:16]];
            
            myTextViewDef.autocorrectionType = UITextAutocorrectionTypeYes;
            myTextViewDef.autocapitalizationType = UITextAutocapitalizationTypeSentences;
            
            myTextViewDef.keyboardType = UIKeyboardTypeDefault;
            
            cell.accessoryView = myTextViewDef;
            [tableView addSubview:myTextViewDef];
        
    }
  
    return cell;    
}


// Heights of cells
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        return 44.0;
    }
    else{
        return 144;
    }
}

// Headers for tableview cells
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Word", @"Word");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Definition", @"Definition");
            break;
    }
    return sectionName;
}

// Handle cancel button touched
- (void)cancel:(id)sender {
    // check for input...
    if(myTextFieldWord.text.length > 0 || myTextViewDef.text.length > 0) {
        // alert the user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Abandon your word?" message:@"You have started to write something. Are you sure you want to leave this screen?" delegate:self cancelButtonTitle:@"Stay" otherButtonTitles:@"Leave",nil];
        // optional - add more buttons:
        [alert show];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// Handle which alert button was pressed
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        // just cancel and return to the current screen

    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}


// Handle submit button touched
- (void)submit:(id)sender {
    
    // Check to make sure we can submit
    if(myTextFieldWord.text.length > 0 && myTextViewDef.text.length > 0 &&
       (([myTextFieldWord.text isEqualToString:@" "]) == false && ([myTextViewDef.text isEqualToString:@" "]) == false)) {
    
        // Create a new Parse object
        PFObject *testObject    = [PFObject objectWithClassName:@"Dictionary"];
        testObject[@"word"]     = myTextFieldWord.text;
        testObject[@"def"]      = myTextViewDef.text;
        testObject[@"approved"] = @"false";

        // Save it to Parse
        [testObject saveInBackground];

        
        // alert the user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks" message:@"Your word will be reviewed soon. Thank you for helping grow the dictionary!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
        
        // Get out now that we have submitted our definition
        [self dismissViewControllerAnimated:YES completion:nil];
        
        // Kickoff the Parse cloud code to send us an email
        [PFCloud callFunctionInBackground:@"sendMail"
                           withParameters:@{}
                                    block:^(NSString *result, NSError *error) {
                                        if (!error) {
                                        }
                                    }];
    }
    else {
        // alert the user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You must add a word and a definition before submitting." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];

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



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
