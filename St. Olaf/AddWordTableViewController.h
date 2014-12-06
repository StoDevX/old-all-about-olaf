//
//  AddWordTableViewController.h
//  All About Olaf
//
//  Created by Drew Volz on 12/3/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddWordTableViewController : UITableViewController

@property (strong, nonatomic) UITextField *myTextFieldWord;
@property (strong, nonatomic) UITextView *myTextViewDef;
@property (nonatomic, assign) id currentResponder;

@property (strong, nonatomic) UIBarButtonItem *submitBtn;
@property (strong, nonatomic) UIBarButtonItem *cancelBtn;

@end
