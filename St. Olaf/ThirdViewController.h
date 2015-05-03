//
//  ThirdViewController.h
//  St. Olaf
//
//  Created by Drew Volz on 7/26/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ThirdViewController : UIViewController
{
    NSMutableArray *myArray;
}

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (nonatomic, strong) NSMutableArray *myLocArray;
@property (strong, nonatomic) NSMutableArray *content;

@end
