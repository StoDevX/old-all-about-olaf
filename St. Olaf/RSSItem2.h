//
//  RSSItem.h
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//

#import <Foundation/Foundation.h>

@interface RSSItem2 : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* descrip;
@property (strong, nonatomic) NSURL* link;
@property (strong, nonatomic) NSAttributedString* cellMessage;

@end