//
//  RSSItem.h
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//

#import <Foundation/Foundation.h>

@interface RSSItem3 : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *department;
@property (strong, nonatomic) NSString *meetingTimes;
@property (strong, nonatomic) NSString *meetingLocs;
@property (strong, nonatomic) NSString *teacher;
@property (strong, nonatomic) NSString *courseNumber;
@property (strong, nonatomic) NSString *courseSection;
@property (strong, nonatomic) NSString *geReqs;
@property (strong, nonatomic) NSString *credits;
@property (strong, nonatomic) NSString *notes;

@property (strong, nonatomic) NSAttributedString *cellMessage;
@property (strong, nonatomic) NSAttributedString *none;


@end