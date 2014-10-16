//
//  TransportationTableViewController.h
//  Oleville
//
//  Created by Drew Volz on 3/24/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransportationTableViewController : UITableViewController
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, strong) NSMutableArray *urlArrCar;
@property (nonatomic, strong) NSMutableArray *urlArrBus;
@property (nonatomic, strong) NSMutableArray *urlArrBike;

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender;

@end
