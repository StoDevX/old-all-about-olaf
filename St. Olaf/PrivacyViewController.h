//
//  PrivacyViewController.h
//  All About Olaf
//
//  Created by Drew Volz on 4/26/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *legalText;

@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

@end
