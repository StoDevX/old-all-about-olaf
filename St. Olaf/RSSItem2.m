//
//  RSSItem.m
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "RSSItem2.h"
#import "GTMNSString+HTML.h"

@implementation RSSItem2

-(NSAttributedString*)cellMessage
{
    if (_cellMessage!=nil) return _cellMessage;
    
    /*
    NSDictionary* normalStyle = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Italic" size:16.0]};
    
    NSMutableAttributedString* articleAbstract = [[NSMutableAttributedString alloc] initWithString:self.title];
    
    [articleAbstract setAttributes:normalStyle range:NSMakeRange(0, self.title.length)];
    
    [articleAbstract appendAttributedString:
     [[NSAttributedString alloc] initWithString:@"\n\n"]
     ];
    
    int startIndex = [articleAbstract length];
    
    NSString* description = [NSString stringWithFormat:@"%@", [self.description substringToIndex:10]];
    description = [description gtm_stringByUnescapingFromHTML];
    
    [articleAbstract appendAttributedString: [[NSAttributedString alloc] initWithString: description]];
    
    [articleAbstract setAttributes:normalStyle range:NSMakeRange(startIndex, articleAbstract.length - startIndex)];
    
    _cellMessage = articleAbstract;
     */
    return _cellMessage;
    
}

@end
