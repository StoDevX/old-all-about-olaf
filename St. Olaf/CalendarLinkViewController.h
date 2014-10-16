//
//  CalendarLinkViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/14/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarLinkViewController : UIViewController
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
