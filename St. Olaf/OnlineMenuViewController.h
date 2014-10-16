//
//  OnlineMenuViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 8/29/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineMenuViewController : UIViewController<UIAlertViewDelegate>{
    
    UIView *subView;
}
@property (nonatomic, retain) UIView *subView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
