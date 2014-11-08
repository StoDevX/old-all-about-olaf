//
//  CourseLoader.m
//  All About Olaf
//
//  Created by Drew Volz on 8/2/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "CourseLoader.h"
#import "Course.h"
#import "SBJson.h"
#import "TFHpple.h"
#import "XPathQuery.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation CourseLoader
// schedule
@synthesize scheduleData;
@synthesize courseNums;
@synthesize courseNames;
@synthesize courseTimes;
@synthesize courseLocs;
@synthesize courseInstructors;

@synthesize dictArray;
@synthesize jsonFinalString;
@synthesize courseDict;
@synthesize courseNum;
@synthesize courseName;
@synthesize courseTime;
@synthesize courseLoc;
@synthesize courseInstructor;


-(void)fetchCourses:(NSString*)foo complete:(CourseLoaderCompleteBlock)c
{
    dispatch_async(kBgQueue, ^{
        
        // returned schedule data
        courseNums =    [[NSMutableArray alloc] init];
        courseNames =   [[NSMutableArray alloc] init];
        courseTimes =   [[NSMutableArray alloc] init];
        courseLocs =    [[NSMutableArray alloc] init];
        courseInstructors = [[NSMutableArray alloc] init];
        dictArray = [[NSMutableArray alloc] init];
        
        
        // debugging HTML in a string instead of from a URL, plug in HTML into fakeURLRequest string
        //NSString *fakeURLRequest = @"";
        //NSData* fakeData = [fakeURLRequest dataUsingEncoding:NSUTF8StringEncoding];
        //NSString *urlDataStr = [NSString stringWithUTF8String:[fakeData bytes]];
        
        //Get the current date
        NSDate* date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMM, yyy"];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
        NSDateComponents *components = [calendar components:units fromDate:date];
        NSInteger day = [components day];
        NSInteger year = [components year];
        NSInteger month = [components month];
        NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
        [weekDay setDateFormat:@"EEE,"];
        NSDateFormatter *calMonth = [[NSDateFormatter alloc] init];
        [calMonth setDateFormat:@"MMM"];
        
        int theYear = year;

        // Adjust the year based on the date
        // We want to look at 2013 for 2013-2014 year, and so on
        // Check Jan through May
        if (month >= 1 && month < 6) {
            // Subtract 1 from the current year to get the right URL
            theYear = year - 1;
        }
        // Check Jun - Dec
        else if (month >= 6 && month <= 12) {
            // It's a new school year, so don't touch it to get the right URL
            theYear = year;
        }
        
        // Loop through the terms we want to download and display
        for(int k = 1; k < 4; k++) {
        
            // Our POST data for when we want to load a specific term of courses
            // THIS IS THE POT OF GOLD RIGHT HERE
            NSString *post = [NSString stringWithFormat:@"stnum=%@&preserve=%@&searchyearterm=%d%d",
                              [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"], // POST: student Id
                              @"noadd", // POST: noadd for preserve?
                              theYear,  // POST: the year we are searching for
                              k];       // POST: the term we are searching for
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            // Make the request to the server to sign-in
            NSMutableURLRequest *request2 = [[NSMutableURLRequest alloc] init];
            [request2 setURL:[NSURL URLWithString:@"https://www.stolaf.edu/sis/st-courses.cfm?"]];
            [request2 setHTTPMethod:@"POST"];
            [request2 setHTTPShouldHandleCookies:YES];
            [request2 setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request2 setHTTPBody:postData];
        
            
            //Error object in case we get one...
            NSError *error2;
            //Response from the URL
            NSURLResponse *response2;
            //The wonderful funderful NSData object that pases our synchronous request and schmoozes with the wizards in the internet world
            NSData *urlData2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:&response2 error:&error2];
            
            //Convert from NSData to NSString to remove <br> tags from response (to make parsing children easier)
            NSString *urlDataStr = [NSString stringWithUTF8String:[urlData2 bytes]];

            //Replace breaks and spaces (unescaped HTML)
            urlDataStr = [urlDataStr stringByReplacingOccurrencesOfString: @"<br>" withString:@"\n"];
            urlDataStr = [urlDataStr stringByReplacingOccurrencesOfString: @"&nbsp;" withString:@" "];
            //Replace empty class name td with empty class name links
            urlDataStr = [urlDataStr stringByReplacingOccurrencesOfString: @"<td nowrap class=\"sis-coursename\"> </td>"
                                                               withString:@"<td nowrap class=\"sis-coursename\"><a class=\"sis-nounderline\"></a></td>"];

            //Replace empty location td with empty location links
            urlDataStr = [urlDataStr stringByReplacingOccurrencesOfString: @"<td nowrap class=\"sis-meetinglocation\"> </td>"
                                                               withString:@"<td nowrap class=\"sis-meetinglocation\"><a class=\"sis-nounderline\"></a></td>"];
            //Replace empty instructor td with empty instructor links
            urlDataStr = [urlDataStr stringByReplacingOccurrencesOfString: @"<td nowrap class=\"sis-instructorname\"> </td>"
                                                               withString:@"<td nowrap class=\"sis-instructorname\"><a class=\"sis-nounderline\"></a></td>"];
            
            
            
            //Check to see if we have holds on our account, blocking our view...
            if ( [urlDataStr rangeOfString:@"Sorry, you cannot view"].location != NSNotFound ) {
                // get outta here
                NSMutableArray *myExitArray = [NSMutableArray array];
                [myExitArray addObject:@"exitNow"];
                // return statement for the block
                c(myExitArray);
            }
            
            
            
            //And convert back to NSData while converting Unicode!
            NSData *urlDataFiltered = [urlDataStr dataUsingEncoding:NSASCIIStringEncoding   allowLossyConversion:YES];

            //The awesome TFHpple object which parses all of our data
            TFHpple *xpathParser2 = [[TFHpple alloc] initWithHTMLData:urlDataFiltered];
            
            //We tell the parser to look at table data with classes
            NSArray *courseNumsArr = [[NSArray alloc] init];
            NSArray *courseNamesArr = [[NSArray alloc] init];
            NSArray *courseTimesArr = [[NSArray alloc] init];
            NSArray *courseLocsArr = [[NSArray alloc] init];
            NSArray *courseInstructorsArr = [[NSArray alloc] init];
            
            //Clear the old objects
            [dictArray removeAllObjects];

            courseNumsArr =        [xpathParser2 searchWithXPathQuery:@"//td [@class='sis-departmentname']"];
            courseNamesArr =       [xpathParser2 searchWithXPathQuery:@"//td [@class='sis-coursename']/a"];
            courseTimesArr =       [xpathParser2 searchWithXPathQuery:@"//td [@class='sis-meetingtime']"];
            courseLocsArr =        [xpathParser2 searchWithXPathQuery:@"//td [@class='sis-meetinglocation']/a [@class='sis-nounderline'][1]"];
            courseInstructorsArr = [xpathParser2 searchWithXPathQuery:@"//td [@class='sis-instructorname']/a [@class='sis-nounderline']"];
            
            if(courseNamesArr.count > 0) {
                // Course number
                for (TFHppleElement * element in courseNumsArr) {
                    // Be sure that the time exists/is not NULL
                    if([[element firstChild] content] == NULL || [[[element firstChild] content]  isEqual: @""] || [[[element firstChild] content]  isEqual: @" "]
                       || [[[element firstChild] content]  isEqual: @"&nbsp;"]) {
                        [courseNums addObject: @"Number not listed"];
                    } else {
                        [courseNums addObject:[[element firstChild] content]];
                    }
                }
                [courseNums removeObjectAtIndex: 0]; // remove the first item (it is a table header!)
                
                // Course name
                for (TFHppleElement * element in courseNamesArr) {
                    // Be sure that the time exists/is not NULL
                    if([[element firstChild] content] == NULL || [[[element firstChild] content]  isEqual: @""] || [[[element firstChild] content]  isEqual: @" "]
                       || [[[element firstChild] content]  isEqual: @"&nbsp;"]) {
                        [courseNames addObject: @"Name not listed"];
                    } else {
                        [courseNames addObject:[[element firstChild] content]];
                    }
                }
                
                // Course times
                for (TFHppleElement * element in courseTimesArr) {
                    // Be sure that the time exists/is not NULL
                    if([[element firstChild] content] == NULL || [[[element firstChild] content]  isEqual: @""] || [[[element firstChild] content]  isEqual: @" "]
                       || [[[element firstChild] content]  isEqual: @"&nbsp;"]) {
                        [courseTimes addObject: @"Time not listed"];
                    } else {
                        [courseTimes addObject:[[element firstChild] content]];
                    }
                }
                [courseTimes removeObjectAtIndex: 0]; // remove the first item (it is a table header!)
                
                
                // Course locations
                for (TFHppleElement * element in courseLocsArr) {
                    // Be sure that the time exists/is not NULL or empty
                    if([[element firstChild] content] == NULL || [[[element firstChild] content]  isEqual: @""] || [[[element firstChild] content]  isEqual: @" "]
                       || [[[element firstChild] content]  isEqual: @"&nbsp;"]) {
                        [courseLocs addObject: @"Location not listed"];
                    } else {
                        [courseLocs addObject:[[element firstChild] content]];
                    }
                }
                
                // Course instructors
                for (TFHppleElement * element in courseInstructorsArr) {
                    // Be sure that the time exists/is not NULL or empty
                    if([[element firstChild] content] == NULL || [[[element firstChild] content]  isEqual: @""] || [[[element firstChild] content]  isEqual: @" "]
                       || [[[element firstChild] content]  isEqual: @""]) {
                        [courseInstructors addObject: @"Instructor not listed"];
                    } else {
                        [courseInstructors addObject:[[element firstChild] content]];
                    }
                }
                
                // Debug our filtered arrays
                /*
                NSLog(@"%@", courseNums);
                NSLog(@"%@", courseNames);
                NSLog(@"%@", courseTimes);
                NSLog(@"%@", courseLocs);
                NSLog(@"%@", courseInstructors);
                */

                
                // We will create courseNames.count Course objects
                NSMutableArray *result = [[NSMutableArray alloc] init];
                result = [NSMutableArray arrayWithCapacity:courseNames.count];
                
                // Create Course objects which are comprised of our results
                for(int i = 0; i < courseNames.count; i++) {
                    Course *item =          [[Course alloc] init];
                    item.courseName =       courseNames[i];          // name
                    item.courseNum =        courseNums[i];           // number
                    item.courseTime =       courseTimes[i];          // time
                    item.courseLoc =        courseLocs[i];           // location    FIX ME! THIS IS ONLY FIRST CHILD, SHOULD PULL ALL RESULTS
                    item.courseInstructor = courseInstructors[i];    // instructor  FIX ME! THIS IS ONLY FIRST CHILD, SHOULD PULL ALL RESULTS
                    
                    //trim white space
                    [item.courseName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
                    [item.courseNum stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
                    [item.courseInstructor stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
                    [item.courseLoc stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
                    [item.courseInstructor stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];


                    [result addObject: item];
                    
                    
                    
                    // file path
                    _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    _documentsDirectory = [_paths objectAtIndex:0];
                    // make a json for each term
                    NSString *fileName = [NSString stringWithFormat:@"%@%i%@", @"courseInfo", k, @".json"];
                    _path = [_documentsDirectory stringByAppendingPathComponent:fileName];
                    
                    // json from dictionary
                    courseDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                courseNames[i],        @"name",
                                                courseNums[i],         @"course",
                                                courseTimes[i],        @"time",
                                                courseLocs[i],         @"location",
                                                courseInstructors[i],  @"instructor",
                                                nil];
                    
                
                    // Now write each json object to the json file
                    NSData *json = [[NSData alloc] init];
                    // Dictionary convertable to JSON ?
                    if ([NSJSONSerialization isValidJSONObject:courseDict])
                    {
                        // Serialize the dictionary
                        json = [NSJSONSerialization dataWithJSONObject:courseDict options:NSJSONWritingPrettyPrinted error:nil];

                        // If no errors, let's put our json into a file
                        if (json != nil)
                        {
                            // put json into a string
                            NSString *course = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
                            // add each json string to a final string
                            jsonFinalString = [jsonFinalString stringByAppendingString:course];
                            [dictArray addObject: courseDict];
                        }
                    }
                }
                //NSLog(@"%@", dictArray);

                // Write the final output to a file in json format
                SBJsonWriter *writer = [[SBJsonWriter alloc] init];
                // this string will contain the JSON-encoded command NSDictionary
                NSString *jsonCommand = [writer stringWithObject:dictArray];
                [jsonCommand writeToFile:_path atomically:YES encoding:NSASCIIStringEncoding error:nil];
                
                NSString *jsonData = [NSString stringWithContentsOfFile:_path encoding:NSUTF8StringEncoding error:nil];
                if(jsonData) {
                    //NSLog(@"Contents of json file: %@", jsonData);
                } else {
                    //NSLog(@"We don't have json file.");
                }
                
                // clear the object before starting again
                [courseNums removeAllObjects];
                [courseNames removeAllObjects];
                [courseTimes removeAllObjects];
                [courseLocs removeAllObjects];
                [courseInstructors removeAllObjects];
                [dictArray removeAllObjects];
                [courseDict removeAllObjects];

                c(result);
            }
        }
    });
    
}

@end

