//
//  RSSLoader.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "RSSLoader4.h"
#import "RXMLElement.h"
#import "RSSItem4.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation RSSLoader4

-(void)fetchRssWithURL:(NSURL*)url complete:(RSSLoaderCompleteBlock)c
{
    dispatch_async(kBgQueue, ^{
        
        //work in the background
        RXMLElement *rss = [RXMLElement elementFromURL: url];
        RXMLElement* title = [[rss child:@"channel"] child:@"title"];
        NSArray* items = [[rss child:@"channel"] children:@"item"];
        NSMutableArray* result = [NSMutableArray arrayWithCapacity:items.count];
        
        //more code
        for (RXMLElement *e in items) {
            
            //iterate over the articles
            RSSItem4 *item = [[RSSItem4 alloc] init];
            item.title = [[e child:@"title"] text];
            item.contentEncoded = [[e child:@"description"] text];
            item.link = [NSURL URLWithString: [[e child:@"link"] text]];
            [result addObject: item];
        }
        
        c([title text], result);
    });
    
}

@end
