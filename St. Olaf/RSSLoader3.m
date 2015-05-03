//
//  RSSLoader.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "RSSLoader3.h"

#import "RXMLElement.h"
#import "RSSItem3.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation RSSLoader3

- (void)fetchRssWithURL:(NSURL *)url complete:(RSSLoaderCompleteBlock)c
{
    dispatch_async(kBgQueue, ^{
        
        //work in the background
        RXMLElement *rss = [RXMLElement elementFromURL: url];
        RXMLElement* title = [[rss child:@"course"] child:@"coursename"];
        NSArray* items = [rss children:@"course"];

        NSMutableArray* result = [NSMutableArray arrayWithCapacity:items.count];
        
        //more code
        for (RXMLElement *e in items) {
            
            //iterate over the articles
            RSSItem3 *item = [[RSSItem3 alloc] init];
            item.title = [[e child:@"coursename"] text];
            item.meetingTimes = [[e child:@"meetingtimes"] text];
            item.meetingLocs = [[e child:@"meetinglocations"] text];
            item.courseNumber = [[e child:@"coursenumber"] text];
            item.courseSection = [[e child:@"coursesection"] text];
            item.department = [[e child:@"deptname"] text];
            item.teacher = [[e child:@"instructors"] text];
            item.geReqs = [[e child:@"gereqs"] text];
            item.credits = [[e child:@"credits"] text];
            item.notes = [[e child:@"notes"] text];
            
            [result addObject: item];
            
        }
        c([title text], result);
    });
}

@end
