//
//  Hall.h
//  Oleville
//
//  Created by Drew Volz on 4/12/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hall : NSObject

@property (nonatomic, strong) NSString *name; // name of hall
@property (atomic, weak) NSString *cover; // image of hall
@property (atomic, weak) NSString *tour; // tour of hall
@property (atomic, weak) NSString *floorPlan; // floorplan of hall
@property (nonatomic, strong) NSArray *descrip; // facts of hall
@property (nonatomic, assign) NSInteger cellSize; //size of description

@end