//
//  LegalTextViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/12/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LegalTextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *legalText;

@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

@end
