//
//  RSSItem.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "RSSItem.h"
#import "GTMNSString+HTML.h"
#import "NSString_stripHtml.h"

@implementation RSSItem

-(NSAttributedString*)cellMessage
{
    if (_cellMessage!=nil) return _cellMessage;
    
    NSDictionary* normalStyle = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:16.0]};
    
    NSMutableAttributedString* articleAbstract = [[NSMutableAttributedString alloc] initWithString:self.title];

    [articleAbstract setAttributes:normalStyle
                             range:NSMakeRange(0, self.title.length)];

    int startIndex = [articleAbstract length];

    self.contentEncoded = [self.contentEncoded stringByReplacingOccurrencesOfString:@"<p class=\"wp-caption-text\">" withString:@""];
    self.contentEncoded = [self.contentEncoded stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    self.contentEncoded = [self.contentEncoded stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    self.contentEncoded = [self.contentEncoded stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.contentEncoded = [self.contentEncoded stripHtml];
    self.contentEncoded = [self.contentEncoded stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];


    [articleAbstract setAttributes:normalStyle
                             range:NSMakeRange(startIndex, articleAbstract.length - startIndex)];
    
    
    _cellMessage = articleAbstract;

    return _cellMessage;
    
}

@end
