//
//  AdsTableViewController.h
//  All About Olaf
//
//  Created by Drew Volz on 4/24/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (weak, nonatomic) IBOutlet UILabel *descrip;

@end
