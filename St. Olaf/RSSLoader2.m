//
//  RSSLoader.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "RSSLoader2.h"

#import "RXMLElement.h"
#import "RSSItem2.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation RSSLoader2

-(void)fetchRssWithURL:(NSURL*)url complete:(RSSLoaderCompleteBlock)c
{
    dispatch_async(kBgQueue, ^{
        
        //work in the background
        RXMLElement *rss = [RXMLElement elementFromURL: url];
        RXMLElement* title = [[rss child:@"channel"] child:@"title"];
        NSArray* items = [[rss child:@"channel"] children:@"item"];

        NSMutableArray* result = [NSMutableArray arrayWithCapacity:items.count];
        NSArray* theEvents;

        //more code
        for (RXMLElement *e in items) {
            
            //To delete the date on the end of the string, get the current year and compare
            NSDate *now = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@", yyyy"];
            NSString *year = [formatter stringFromDate:now];
            
            //define the item
            RSSItem2* item = [[RSSItem2 alloc] init];
            //define link rss
            item.link = [NSURL URLWithString: [[e child:@"link"] text]];
            //define description rss
            item.descrip = [[e child:@"title"] text];

            //define title rss trim white space characters and new line characters to isolate the text
            item.title = [[[e child:@"description"] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //fix a few formatting errors
            item.title = [NSString stringWithFormat:@"%@%@%@", item.descrip, @"\n", item.title];
            //replace the unnecessary text of "Events for " with an empty string
            item.title = [item.title stringByReplacingOccurrencesOfString:@"Events for " withString:@""];
            //Replace the current year string with an empty string
            item.title = [item.title stringByReplacingOccurrencesOfString:year withString:@""];
            //Replace the <i></i> strings with empty strings
            item.title = [item.title stringByReplacingOccurrencesOfString:@"<i>" withString:@""];
            item.title = [item.title stringByReplacingOccurrencesOfString:@"</i>" withString:@""];
            //Replace the <I></I> strings with empty strings
            item.title = [item.title stringByReplacingOccurrencesOfString:@"<I>" withString:@""];
            item.title = [item.title stringByReplacingOccurrencesOfString:@"</I>" withString:@""];
            //Replace the @ strings with at
            item.title = [item.title stringByReplacingOccurrencesOfString:@"@" withString:@"at"];
            
            theEvents = [item.title componentsSeparatedByString:@"|"];
            NSLog(@"%@%@", theEvents,@"\n\n");
            
            //Replace the pipe character "| " with two new lines to separate multiple events
            if([item.title rangeOfString:@"| "].location != NSNotFound) {
                //Replace the pipe sign with two new lines to tidy up
                item.title = [item.title stringByReplacingOccurrencesOfString:@"| " withString:@"\n\n"];
                //Replace the link of the item to go to the list of items as there are more than one
                item.link = [NSURL URLWithString:@"http://stolaf.edu/calendar/index.cfm?fuseaction=EventsThisWeek&timeLength=Week"];
            }
            //Replace ", Other" with no text
            item.title = [item.title stringByReplacingOccurrencesOfString:@", Other" withString:@""];
            
            //add it to the NSMutableArray as a feed item
            [result addObject: item];

        }
    
        
        c([title text], result);
    });
    
}

@end
