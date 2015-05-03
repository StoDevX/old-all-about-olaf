//
//  tomsonEastViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/11/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tomsonEastViewController : UIViewController <UIAlertViewDelegate>
{
    UIView *subView;
}
@property (nonatomic, retain) UIView *subView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@end
