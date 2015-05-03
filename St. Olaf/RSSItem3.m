//
//  RSSItem.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "RSSItem3.h"
#import "GTMNSString+HTML.h"
#import "NSString_stripHtml.h"

@implementation RSSItem3

- (NSAttributedString *)cellMessage
{
    if (_cellMessage != nil)
        return _cellMessage;

    NSDictionary *normalStyle = @{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:16.0] };
    self.title = [self.title stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    self.title = [self.title stringByReplacingOccurrencesOfString:@"Top: " withString:@""];
    self.title = [self.title stringByReplacingOccurrencesOfString:@":" withString:@": "];
    self.title = [self.title stringByReplacingOccurrencesOfString:@"." withString:@" ."];

    self.geReqs = [self.geReqs stringByReplacingOccurrencesOfString:@" ('08)" withString:@""];
    self.geReqs = [self.geReqs stringByReplacingOccurrencesOfString:@"</a>" withString:@"  "];

    NSMutableAttributedString *articleAbstract = [[NSMutableAttributedString alloc] initWithString:self.title];

    [articleAbstract setAttributes:normalStyle
                             range:NSMakeRange(0, self.title.length)];

    int startIndex = [articleAbstract length];

    self.title = [self.title stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];

    self.teacher = [self.teacher stringByReplacingOccurrencesOfString:@"</a>" withString:@"  "];
    self.teacher = [self.teacher stripHtml];

    self.meetingLocs = [self.meetingLocs stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.meetingLocs = [self.meetingLocs stripHtml];

    self.notes = [self.notes stringByReplacingOccurrencesOfString:@"<br>" withString:@" "];
    self.notes = [self.notes stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.notes = [self.notes stripHtml];

    //Fix the problem of a double-display of the meeting location
    //Here is what we're going to do...
    //Check whether the characters ON or AFTER the fourth character are numbers
    //So anything like: RNS 202 or HH 201 -> LLL or LL_ will always be chars

    // FIX ME
    int newLength = 7;
    if (self.meetingLocs.length > newLength)
        self.meetingLocs = [self.meetingLocs substringToIndex:newLength];

    ////////////////////

    self.geReqs = [self.geReqs stripHtml];

    self.meetingTimes = [self.meetingTimes stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.meetingTimes = [self.meetingTimes stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    self.meetingTimes = [self.meetingTimes stripHtml];
    self.meetingTimes = [self.meetingTimes stringByReplacingOccurrencesOfString:@"AM" withString:@" a.m. "];
    self.meetingTimes = [self.meetingTimes stringByReplacingOccurrencesOfString:@"PM" withString:@" p.m. "];
    self.meetingTimes = [self.meetingTimes stringByReplacingOccurrencesOfString:@"-" withString:@" – "];

    [articleAbstract setAttributes:normalStyle
                             range:NSMakeRange(startIndex, articleAbstract.length - startIndex)];

    _cellMessage = articleAbstract;

    return _cellMessage;
}

@end
