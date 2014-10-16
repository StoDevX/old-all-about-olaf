//
//  FirstViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UITableViewController{
    
}
@property (weak, nonatomic) IBOutlet UITableViewCell *newsButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *buildingButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *aboutButton;

@end
