//
//  socialViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/9/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface socialViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)changeWebsite;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
