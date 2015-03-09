//
//  MasterViewController.h
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//

#import <UIKit/UIKit.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
@interface MasterViewController : UITableViewController<UIAlertViewDelegate>{
    
    UIView *subView;
}
@property (nonatomic, retain) UIView *subView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UIView *overlayView;
//- (IBAction)changeWebsite;
@property (weak, nonatomic) IBOutlet UILabel *noInternet;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;


@end
