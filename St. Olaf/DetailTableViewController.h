//
//  DetailTableViewController.h
//  Oleville
//
//  Created by Drew Volz on 4/12/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hall.h"

@interface DetailTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *displayMe;
@property (nonatomic, strong) Hall *hall;
@end
