//
//  RadioViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/9/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RadioViewController : UIViewController<UIAlertViewDelegate>{
    
    UIView *subView;

}
@property (nonatomic, retain) UIView *subView;

@property (weak, nonatomic) IBOutlet UIImageView *narwhalImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *callStation;
@property (weak, nonatomic) IBOutlet UIToolbar *nowPlayingToolbar;
@property (weak, nonatomic) IBOutlet UILabel *nowPlayingText;

@end
