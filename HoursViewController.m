//
//  HoursViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "HoursViewController.h"

@interface HoursViewController ()

@end

@implementation HoursViewController
@synthesize stavCircle;
@synthesize cageCircle;
@synthesize pauseCircle;
@synthesize norwayCircle;
@synthesize rolvaagCircle;
@synthesize hustadCircle;
@synthesize halvarsonCircle;
@synthesize bookStore;
@synthesize convenienceStore;
@synthesize postOfficeCircle;
@synthesize skoglundCircle;
@synthesize tableView;

//enum of days of week (easier to read)
typedef enum dayOfWeek : NSInteger dayOfWeekType;
enum dayOfWeekType : NSInteger {
    Sunday = 1,
    Monday = 2,
    Tuesday = 3,
    Wednesday = 4,
    Thursday = 5,
    Friday = 6,
    Saturday = 7
};

//enum of minutes passed since midnight (easier to read)
typedef enum numberOfMinutesPastMidnight : NSInteger numberOfMinutesPastMidnightType;
enum numberOfMinutesPastMidnightType : NSInteger {
    Twelve_am = 0,
    Two_am = 120,
    Six_thirty_am = 390,
    Seven_am = 420,
    Seven_fifteen_am = 435,
    Seven_thirty_am = 450,
    Seven_fourty_five_am = 465,
    Eight_am = 480,
    Eight_thirty_am = 510,
    Nine_am = 540,
    Nine_thirty_am = 570,
    Nine_fourty_five_am = 585,
    Ten_am = 600,
    Ten_fifteen_am = 615,
    Ten_thirty_am = 630,
    Eleven_am = 660,
    Twelve_pm = 720,
    One_pm = 780,
    One_thirty_pm = 810,
    Two_pm = 840,
    Two_fifteen_pm = 855,
    Four_pm = 960,
    Four_thirty_pm = 990,
    Five_pm = 1020,
    Six_pm = 1080,
    Seven_pm = 1140,
    Seven_thirty_pm = 1170,
    Eight_pm = 1200,
    Eight_Thirty_pm = 1230,
    Eight_fourty_five_pm = 1245,
    Nine_pm = 1260,
    Ten_pm = 1320,
    Ten_thirty_pm = 1350,
    Ten_fourty_five_pm = 1365,
    Eleven_pm = 1380,
    Eleven_fifty_nine_pm = 1439
};

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear selection of rows
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:animated];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Initialize a calendar
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //Assign the time zone we want
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"CST"];
    
    //Get the current time
    NSDate *now = [[NSDate alloc] init];

    //Force the timzone on our calendar object
    [calendar setTimeZone:zone];
    
    //Set up the necessary date components we want to use
    NSDateComponents *comp = [calendar components:(NSWeekdayCalendarUnit) fromDate:now];
    
    //Set up our tracker for seconds after midnight
    NSDate *date = [NSDate date];
    NSDateComponents *components = [calendar components:NSIntegerMax fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    NSDate *midnight = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSDateComponents *diff = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:midnight toDate:date options:0];
    
    //Adjust what "now" is and take the componesnts from them
    now = [calendar dateFromComponents:comp];

    //Assign the adjusted time components to the desired integer name
    enum dayOfWeek currentWeekday = [comp weekday];
    NSInteger numberOfMinutesPastMidnight = [diff minute];
    
    
    //Get the current date to show which days do not have service
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, yyy"];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components2 = [calendar components:units fromDate:date];
    NSInteger day = [components2 day];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEE,"];
    NSDateFormatter *calMonth = [[NSDateFormatter alloc] init];
    [calMonth setDateFormat:@"MMM"];
    
    NSString *todayIs = [NSString stringWithFormat:@"%@%@%ld", [calMonth stringFromDate:date], @" ", (long)day];

    

    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0 && indexPath.section == 0){
        
        //////////////////////////
        // Stav Hall Calculations
        //////////////////////////
        
        //Mon-Fri
        if(currentWeekday == Monday || currentWeekday == Tuesday || currentWeekday == Wednesday || currentWeekday == Thursday || currentWeekday == Friday)
        {

            //Closing soon
            //Stav Breakfast closes 09:45 a.m.
            if (((numberOfMinutesPastMidnight >= Nine_fourty_five_am - 20)
                 && (numberOfMinutesPastMidnight < Nine_fourty_five_am)) ||
                //Stav Lunch      10:30 a.m. – 02:00 p.m.
                ((numberOfMinutesPastMidnight >= Two_pm - 20) && (numberOfMinutesPastMidnight < Two_pm)) ||
                //Stav Dinner     04:30 p.m. – 07:30 p.m.
                ((numberOfMinutesPastMidnight >= Seven_thirty_pm - 20) && (numberOfMinutesPastMidnight < Seven_thirty_pm)))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                stavCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            
            //Opening soon
            //Stav Breakfast opens 07:00 a.m.
            else if (((numberOfMinutesPastMidnight >= Seven_am - 20)
                 && (numberOfMinutesPastMidnight < Seven_am)) ||
                //Stav Lunch opens 10:30 a.m.
                ((numberOfMinutesPastMidnight >= Ten_thirty_am - 20) && (numberOfMinutesPastMidnight < Ten_thirty_am)) ||
                //Stav Dinner opens 04:30 p.m.
                ((numberOfMinutesPastMidnight >= Four_thirty_pm - 20) && (numberOfMinutesPastMidnight < Four_thirty_pm)))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                stavCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }

                 //Stav Breakfast  07:00 a.m. – 09:45 a.m.
            else if (((numberOfMinutesPastMidnight >= Seven_am)
                 && (numberOfMinutesPastMidnight < Nine_fourty_five_am)) ||
                 //Stav Lunch      10:30 a.m. – 02:00 p.m.
                 ((numberOfMinutesPastMidnight >= Ten_thirty_am) && (numberOfMinutesPastMidnight < Two_pm)) ||
                 //Stav Dinner     04:30 p.m. – 07:30 p.m.
                 ((numberOfMinutesPastMidnight >= Four_thirty_pm) && (numberOfMinutesPastMidnight < Seven_thirty_pm)))
            {
                //If the current time falls between these calculations, set the circle to be green
                stavCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                stavCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        
        //Sat
        if(currentWeekday == Saturday)
        {
            //Closing soon
            //Stav Breakfast closes at 09:45 a.m.
            if(((numberOfMinutesPastMidnight >= Nine_fourty_five_am - 20) && (numberOfMinutesPastMidnight < Nine_fourty_five_am)) ||
               //Stav Lunch closes at 01:30 p.m.
               ((numberOfMinutesPastMidnight >= One_thirty_pm - 20) && (numberOfMinutesPastMidnight < One_thirty_pm)) ||
               //Stav Dinner closes at 07:30 p.m.
               ((numberOfMinutesPastMidnight >= Seven_thirty_pm - 20) && (numberOfMinutesPastMidnight < Seven_thirty_pm)))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                stavCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            
            //Opening soon
            //Stav Breakfast opens 07:00 a.m.
            else if (((numberOfMinutesPastMidnight >= Seven_am - 20)
                      && (numberOfMinutesPastMidnight < Seven_am)) ||
                     //Stav Lunch opens 11:00 a.m.
                     ((numberOfMinutesPastMidnight >= Eleven_am - 20) && (numberOfMinutesPastMidnight < Eleven_am)) ||
                     //Stav Dinner opens 04:30 p.m.
                     ((numberOfMinutesPastMidnight >= Four_thirty_pm - 20) && (numberOfMinutesPastMidnight < Four_thirty_pm)))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                stavCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }

               //Stav Breakfast  07:00 a.m. – 09:45 a.m.
            else if(((numberOfMinutesPastMidnight >= Seven_am) && (numberOfMinutesPastMidnight < Nine_fourty_five_am)) ||
               //Stav Lunch      11:00 a.m. – 01:30 p.m.
               ((numberOfMinutesPastMidnight >= Eleven_am) && (numberOfMinutesPastMidnight < One_thirty_pm)) ||
               //Stav Dinner     04:30 p.m. – 07:30 p.m.
               ((numberOfMinutesPastMidnight >= Four_thirty_pm) && (numberOfMinutesPastMidnight < Seven_thirty_pm)))
            {
                //If the current time falls between these calculations, set the circle to be green
                stavCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                stavCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sun
        if(currentWeekday == Sunday)
        {
            //Stav Breakfast closes at 10:15 a.m.
            if (((numberOfMinutesPastMidnight >= Ten_fifteen_am - 20) && (numberOfMinutesPastMidnight < Ten_fifteen_am)) ||
                //Stav Lunch closes at 01:30 p.m.
                ((numberOfMinutesPastMidnight >= One_thirty_pm - 20) && (numberOfMinutesPastMidnight < One_thirty_pm)) ||
                //Stav Dinner closes at 07:30 p.m.
                ((numberOfMinutesPastMidnight >= Seven_thirty_pm - 20) && (numberOfMinutesPastMidnight < Seven_thirty_pm)))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                stavCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            
            //Opening soon
            //Stav Breakfast opens 10:15 a.m.
            else if (((numberOfMinutesPastMidnight >= Ten_fifteen_am - 20)
                      && (numberOfMinutesPastMidnight < Ten_fifteen_am)) ||
                     //Stav Lunch opens 11:00 a.m.
                     ((numberOfMinutesPastMidnight >= Eleven_am - 20) && (numberOfMinutesPastMidnight < Eleven_am)) ||
                     //Stav Dinner opens 04:30 p.m.
                     ((numberOfMinutesPastMidnight >= Four_thirty_pm - 20) && (numberOfMinutesPastMidnight < Four_thirty_pm)))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                stavCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }

            
                //Stav Breakfast  08:30 a.m. – 10:15 a.m.
            else if (((numberOfMinutesPastMidnight >= Eight_thirty_am) && (numberOfMinutesPastMidnight < Ten_fifteen_am)) ||
                //Stav Lunch      11:00 a.m. – 01:30 p.m.
                ((numberOfMinutesPastMidnight >= Eleven_am) && (numberOfMinutesPastMidnight < One_thirty_pm)) ||
                //Stav Dinner     04:30 p.m. – 07:30 p.m.
                ((numberOfMinutesPastMidnight >= Four_thirty_pm) && (numberOfMinutesPastMidnight < Seven_thirty_pm)))
            {
                //If the current time falls between these calculations, set the circle to be green
                stavCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                stavCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
    }
    
    if (indexPath.row == 1 && indexPath.section == 0){

        /////////////////////////
        // The Cage Calculations
        /////////////////////////
        
        //Mon-Thur
        if(currentWeekday == Monday || currentWeekday == Tuesday || currentWeekday == Wednesday || currentWeekday == Thursday)
        {
            //Closing soon
            //Cage  closes at 11:00 p.m.
            if ((numberOfMinutesPastMidnight >= Eleven_pm - 20) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                cageCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            
            //Opening soon
            //Cage opens at 7:30 a.m.
            else if ((numberOfMinutesPastMidnight >= Seven_thirty_am - 20) && (numberOfMinutesPastMidnight < Seven_thirty_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                cageCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }

                //Cage  07:30 a.m. – 11:00 p.m.
            else if ((numberOfMinutesPastMidnight >= Seven_thirty_am) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                cageCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                cageCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Fri
        if(currentWeekday == Friday)
        {
            //Cage closes at 08:00 p.m.
            if ((numberOfMinutesPastMidnight >= Eight_pm - 20) && (numberOfMinutesPastMidnight < Eight_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                cageCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            
            //Opening soon
            //Cage opens at 7:30 a.m.
            else if ((numberOfMinutesPastMidnight >= Seven_thirty_am - 20) && (numberOfMinutesPastMidnight < Seven_thirty_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                cageCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }

                //Cage  07:30 a.m. – 08:00 p.m.
            else if ((numberOfMinutesPastMidnight >= Seven_thirty_am) && (numberOfMinutesPastMidnight < Eight_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                cageCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                cageCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sat
        if(currentWeekday == Saturday)
        {
            //Cage closes at 20:00
            if ((numberOfMinutesPastMidnight >= Eight_pm - 20) && (numberOfMinutesPastMidnight < Eight_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                cageCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Nine_am - 20) && (numberOfMinutesPastMidnight < Nine_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                cageCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Cage  09:00 a.m. – 20:00
            else if ((numberOfMinutesPastMidnight >= Nine_am) && (numberOfMinutesPastMidnight < Eight_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                cageCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                cageCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sun
        if(currentWeekday == Sunday)
        {
            if ((numberOfMinutesPastMidnight >= Eleven_pm - 20) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                cageCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Nine_am - 20) && (numberOfMinutesPastMidnight < Nine_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                cageCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            
                //Cage  09:00 a.m. – 11:00 p.m.
            else if ((numberOfMinutesPastMidnight >= Nine_am) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                cageCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }

            else{
                //If the current time does not fall between these calculations, set the circle to be red
                cageCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
    }
    
    if (indexPath.row == 2 && indexPath.section == 0){
        
        /////////////////////////
        // The Pause Calculations
        /////////////////////////
        
    
        //Sun - Thur
        if(currentWeekday ==  Sunday || currentWeekday == Monday || currentWeekday == Tuesday || currentWeekday == Wednesday || currentWeekday == Thursday)
        {
            //Pause closes at 12:00 a.m.
            if ((numberOfMinutesPastMidnight >= Eleven_fifty_nine_pm - 20) && (numberOfMinutesPastMidnight <= Eleven_fifty_nine_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                pauseCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Ten_thirty_am - 20) && (numberOfMinutesPastMidnight <= Ten_thirty_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                pauseCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Pause  10:30 a.m. – 12:00 a.m.
            else if ((numberOfMinutesPastMidnight >= Ten_thirty_am) && (numberOfMinutesPastMidnight <= Eleven_fifty_nine_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                pauseCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                pauseCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Fri
        if(currentWeekday == Friday)
        {
            //Pause closes at 02:00 a.m.
            if((numberOfMinutesPastMidnight >= Two_am - 20) && (numberOfMinutesPastMidnight < Two_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                pauseCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if((numberOfMinutesPastMidnight >= Ten_thirty_am - 20) && (numberOfMinutesPastMidnight < Ten_thirty_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                pauseCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Pause  10:30 a.m. – 11:59 p.m. or 12:00 a.m. – 1:39 a.m.
            else if (((numberOfMinutesPastMidnight >= Ten_thirty_am) && (numberOfMinutesPastMidnight <= Eleven_fifty_nine_pm)) ||
                     ((numberOfMinutesPastMidnight >= Twelve_am) && (numberOfMinutesPastMidnight <= Two_am - 19)))
            {
                //If the current time falls between these calculations, set the circle to be green
                pauseCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                pauseCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sat
        if(currentWeekday == Saturday)
        {
            //Pause closes at 02:00 a.m.
            if((numberOfMinutesPastMidnight >= Two_am - 20) && (numberOfMinutesPastMidnight < Two_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                pauseCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if((numberOfMinutesPastMidnight >= Ten_thirty_am - 20) && (numberOfMinutesPastMidnight < Ten_thirty_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                pauseCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Pause  12:00 a.m. – 02:00 a.m.
            else if(((numberOfMinutesPastMidnight >= Twelve_am) && (numberOfMinutesPastMidnight < Two_am)) ||
                //Pause  10:30 a.m. – 12:00 a.m.
            ((numberOfMinutesPastMidnight >= Ten_thirty_am) && (numberOfMinutesPastMidnight <= Eleven_fifty_nine_pm)))
            {
                //If the current time falls between these calculations, set the circle to be green
                pauseCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                pauseCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sun
        if(currentWeekday == Sunday)
        {
            //Pause closes at 02:00 a.m.
            if((numberOfMinutesPastMidnight >= Two_am - 20) && (numberOfMinutesPastMidnight < Two_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                pauseCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if((numberOfMinutesPastMidnight >= Ten_thirty_am - 20) && (numberOfMinutesPastMidnight < Ten_thirty_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                pauseCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
               //Pause  12:00 a.m. – 02:00 a.m.
            else if(((numberOfMinutesPastMidnight >= Twelve_am) && (numberOfMinutesPastMidnight < Two_am)) ||
               //Pause  10:30 a.m. – 12:00 a.m.
              ((numberOfMinutesPastMidnight >= Ten_thirty_am) && (numberOfMinutesPastMidnight <= Eleven_fifty_nine_pm)))
            {
                //If the current time falls between these calculations, set the circle to be green
                pauseCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                pauseCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
    }
    
    
    
    if (indexPath.row == 0 && indexPath.section == 1){
        
        ////////////////////////////////
        // Rolvaag Library Calculations
        ////////////////////////////////
        
        
        
        //Mon-Thur
        if(currentWeekday == Monday || currentWeekday == Tuesday || currentWeekday == Wednesday || currentWeekday == Thursday)
        {
            //Rolvaag Library closes at 02:00 a.m.
            if ((numberOfMinutesPastMidnight >= Two_am - 20) && (numberOfMinutesPastMidnight < Two_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                rolvaagCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Seven_fourty_five_am - 20) && (numberOfMinutesPastMidnight < Seven_fourty_five_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                rolvaagCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Rolvaag Library  07:45 a.m. – 02:00 a.m.
            else if ((numberOfMinutesPastMidnight >= Seven_fourty_five_am) && (numberOfMinutesPastMidnight < Eleven_fifty_nine_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                rolvaagCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
                //Rolvaag Library  12:00 a.m. – 02:00 a.m.
            else if(((numberOfMinutesPastMidnight >= Twelve_am) && (numberOfMinutesPastMidnight < Two_am - 21)) ||
                    //Rolvaag  12:00 a.m – 02:00 a.m.
                    ((numberOfMinutesPastMidnight >= Twelve_am) && (numberOfMinutesPastMidnight < Two_am - 21)))
            {
                //If the current time falls between these calculations, set the circle to be green
                rolvaagCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }

            else{
                //If the current time does not fall between these calculations, set the circle to be red
                rolvaagCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Fri
        if(currentWeekday == Friday)
        {
            //Rolvaag Library closes at 09:00 p.m.
            if ((numberOfMinutesPastMidnight >= Nine_pm - 20) && (numberOfMinutesPastMidnight < Nine_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                rolvaagCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Seven_fourty_five_am - 20) && (numberOfMinutesPastMidnight < Seven_fourty_five_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                rolvaagCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Rolvaag Library  07:45 a.m. – 09:00 p.m.
            else if((numberOfMinutesPastMidnight >= Seven_fourty_five_am) && (numberOfMinutesPastMidnight < Nine_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                rolvaagCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                rolvaagCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sat
        if(currentWeekday == Saturday)
        {
            //Rolvaag Library closes at 09:00 p.m.
            if ((numberOfMinutesPastMidnight >= Nine_pm - 20) && (numberOfMinutesPastMidnight < Nine_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                rolvaagCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Nine_am - 20) && (numberOfMinutesPastMidnight < Nine_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                rolvaagCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Rolvaag Library  09:00 a.m. – 09:00 p.m.
            else if((numberOfMinutesPastMidnight >= Nine_am) && (numberOfMinutesPastMidnight < Nine_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                rolvaagCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                rolvaagCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
    
        //Sun
        if(currentWeekday == Sunday)
        {
            //Rolvaag Library closes at 12:00 a.m.
            if ((numberOfMinutesPastMidnight >= Eleven_fifty_nine_pm - 20) && (numberOfMinutesPastMidnight < Eleven_fifty_nine_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                rolvaagCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Twelve_pm - 20) && (numberOfMinutesPastMidnight < Twelve_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                rolvaagCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Rolvaag Library 12:00 p.m. – 12:00 a.m.
            else if ((numberOfMinutesPastMidnight >= Twelve_pm) && (numberOfMinutesPastMidnight < Eleven_fifty_nine_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                rolvaagCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                rolvaagCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
    }
    
    if (indexPath.row == 1 && indexPath.section == 1){
        
        ////////////////////////////////
        // Husdtad Library Calculations
        ////////////////////////////////
        
        //Mon-Thur
        if(currentWeekday == Monday || currentWeekday == Tuesday || currentWeekday == Wednesday || currentWeekday == Thursday)
        {
            //Husdtad Library closes at 11:00 p.m.
            if ((numberOfMinutesPastMidnight >= Eleven_pm - 20) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                hustadCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Eight_am - 20) && (numberOfMinutesPastMidnight < Eight_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                hustadCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Husdtad Library  08:00 a.m. – 11:00 p.m.
            else if ((numberOfMinutesPastMidnight >= Eight_am) && (numberOfMinutesPastMidnight < Eleven_pm))
                {
                //If the current time falls between these calculations, set the circle to be green
                hustadCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                hustadCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Fri
        if(currentWeekday == Friday)
        {
            //Husdtad Library closes at 07:00 p.m.
            if ((numberOfMinutesPastMidnight >= Seven_pm - 20) && (numberOfMinutesPastMidnight < Seven_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                hustadCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Eight_am - 20) && (numberOfMinutesPastMidnight < Eight_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                hustadCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Husdtad Library  08:00 a.m. – 07:00 p.m.
            else if((numberOfMinutesPastMidnight >= Eight_am) && (numberOfMinutesPastMidnight < Seven_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                hustadCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                hustadCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sat
        if(currentWeekday == Saturday)
        {
            //Husdtad Library closes at 04:00 p.m.
            if ((numberOfMinutesPastMidnight >= Four_pm - 20) && (numberOfMinutesPastMidnight < Four_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                hustadCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Nine_thirty_am - 20) && (numberOfMinutesPastMidnight < Nine_thirty_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                hustadCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Husdtad Library  09:30 a.m. – 04:00 p.m.
            else if((numberOfMinutesPastMidnight >= Nine_thirty_am) && (numberOfMinutesPastMidnight < Four_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                hustadCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                hustadCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sun
        if(currentWeekday == Sunday)
        {
            //Husdtad Library closes at 11:00 p.m.
            if ((numberOfMinutesPastMidnight >= Eleven_pm - 20) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                hustadCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= One_pm - 20) && (numberOfMinutesPastMidnight < One_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                hustadCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Husdtad Library 1:00 p.m. – 11:00 p.m.
            else if ((numberOfMinutesPastMidnight >= One_pm) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                hustadCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                hustadCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
    }

    
    
    if (indexPath.row == 2 && indexPath.section == 1){
        
        //////////////////////////////////
        // Halvarson Library Calculations
        //////////////////////////////////
        
        //Mon-Thur
        if(currentWeekday == Monday || currentWeekday == Tuesday || currentWeekday == Wednesday || currentWeekday == Thursday)
        {
            //Halvarson Library closes at 11:00 p.m.
            if ((numberOfMinutesPastMidnight >= Eleven_pm - 20) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                halvarsonCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Seven_fourty_five_am - 20) && (numberOfMinutesPastMidnight < Seven_fourty_five_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                halvarsonCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Halvarson Library  07:45 a.m. – 11:00 p.m.
            else if ((numberOfMinutesPastMidnight >= Seven_fourty_five_am) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                halvarsonCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                halvarsonCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Fri
        if(currentWeekday == Friday)
        {
            //Halvarson Library closes at 08:00 p.m.
            if ((numberOfMinutesPastMidnight >= Eight_pm - 20) && (numberOfMinutesPastMidnight < Eight_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                halvarsonCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Seven_fourty_five_am - 20) && (numberOfMinutesPastMidnight < Seven_fourty_five_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                halvarsonCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Halvarson Library  07:45 a.m. – 08:00 p.m.
            else if((numberOfMinutesPastMidnight >= Seven_fourty_five_am) && (numberOfMinutesPastMidnight < Eight_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                halvarsonCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                halvarsonCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sat
        if(currentWeekday == Saturday)
        {
            //Halvarson Library closes at 06:00 p.m.
            if ((numberOfMinutesPastMidnight >= Six_pm - 20) && (numberOfMinutesPastMidnight < Six_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                halvarsonCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Nine_am - 20) && (numberOfMinutesPastMidnight < Nine_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                halvarsonCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Halvarson Library  09:00 a.m. – 06:00 p.m.
            else if((numberOfMinutesPastMidnight >= Nine_am) && (numberOfMinutesPastMidnight < Six_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                halvarsonCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                halvarsonCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sun
        if(currentWeekday == Sunday)
        {
            //Halvarson Library closes at 11:00 p.m.
            if ((numberOfMinutesPastMidnight >= Eleven_pm - 20) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                halvarsonCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Twelve_pm - 20) && (numberOfMinutesPastMidnight < Twelve_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                halvarsonCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
                //Halvarson Library 12:00 p.m. – 11:00 p.m.
            else if ((numberOfMinutesPastMidnight >= Twelve_pm) && (numberOfMinutesPastMidnight < Eleven_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                halvarsonCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                halvarsonCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
    }
    
    
    if (indexPath.row == 0 && indexPath.section == 2){
        
        ///////////////////////////
        // Book Store Calculations
        ///////////////////////////
        
        //Mon-Fri
        if(currentWeekday == Monday || currentWeekday == Tuesday || currentWeekday == Wednesday || currentWeekday == Thursday || currentWeekday == Friday)
        {
            //Book Store closes at 5:00 p.m.
            if ((numberOfMinutesPastMidnight >= Five_pm - 20) && (numberOfMinutesPastMidnight < Five_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                bookStore.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Eight_am - 20) && (numberOfMinutesPastMidnight < Eight_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                bookStore.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Book Store  08:00 a.m. – 5:00 p.m.
            else if ((numberOfMinutesPastMidnight >= Eight_am) && (numberOfMinutesPastMidnight < Five_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                bookStore.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                bookStore.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sat
        if(currentWeekday == Saturday)
        {
            //Book Store closes at 4:00 p.m.
            if ((numberOfMinutesPastMidnight >= Four_pm - 20) && (numberOfMinutesPastMidnight < Four_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                bookStore.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Ten_am - 20) && (numberOfMinutesPastMidnight < Ten_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                bookStore.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Book Store  10:00 a.m. – 04:00 p.m.
            else if((numberOfMinutesPastMidnight >= Ten_am) && (numberOfMinutesPastMidnight < Four_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                bookStore.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                bookStore.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
    }
    
    
    if (indexPath.row == 1 && indexPath.section == 2){
        
        /////////////////////////////////
        // Convenience Store Calculations
        /////////////////////////////////
        
        //Mon-Fri
        if(currentWeekday == Monday || currentWeekday == Tuesday || currentWeekday == Wednesday || currentWeekday == Thursday || currentWeekday == Friday)
        {
            //Convenience Store closes at 08:00 p.m.
            if ((numberOfMinutesPastMidnight >= Eight_pm - 20) && (numberOfMinutesPastMidnight < Eight_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                convenienceStore.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Eight_am - 20) && (numberOfMinutesPastMidnight < Eight_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                convenienceStore.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Convenience Store  08:00 a.m. – 08:00 p.m.
            else if ((numberOfMinutesPastMidnight >= Eight_am) && (numberOfMinutesPastMidnight < Eight_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                convenienceStore.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                convenienceStore.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sat
        if(currentWeekday == Saturday)
        {
            //Convenience Store closes at 08:00 p.m.
            if ((numberOfMinutesPastMidnight >= Eight_pm - 20) && (numberOfMinutesPastMidnight < Eight_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                convenienceStore.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Ten_am - 20) && (numberOfMinutesPastMidnight < Ten_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                convenienceStore.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Convenience Store  10:00 a.m. – 08:00 p.m.
            else if((numberOfMinutesPastMidnight >= Ten_am) && (numberOfMinutesPastMidnight < Eight_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                convenienceStore.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                convenienceStore.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sun
        if(currentWeekday == Sunday)
        {
            //Convenience Store closes at 04:00 p.m.
            if ((numberOfMinutesPastMidnight >= Four_pm - 20) && (numberOfMinutesPastMidnight < Four_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                convenienceStore.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Twelve_pm - 20) && (numberOfMinutesPastMidnight < Twelve_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                convenienceStore.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Convenience Store  12:00 p.m. – 04:00 p.m.
            else if((numberOfMinutesPastMidnight >= Twelve_pm) && (numberOfMinutesPastMidnight < Four_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                convenienceStore.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                convenienceStore.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }

    }
    
    if (indexPath.row == 0 && indexPath.section == 3){
        
        ////////////////////////////
        // Post Office Calculations
        ////////////////////////////
        
        //Mon-Fri
        if(currentWeekday == Monday || currentWeekday == Tuesday || currentWeekday == Wednesday || currentWeekday == Thursday || currentWeekday == Friday)
        {
            //Post Office closes at 05:00 p.m.
            if ((numberOfMinutesPastMidnight >= Five_pm - 20) && (numberOfMinutesPastMidnight < Five_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                postOfficeCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Eight_am - 20) && (numberOfMinutesPastMidnight < Eight_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                postOfficeCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Post Office  08:00 a.m. – 05:00 p.m.
            else if ((numberOfMinutesPastMidnight >= Eight_am) && (numberOfMinutesPastMidnight < Five_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                postOfficeCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                postOfficeCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sat
        if(currentWeekday == Saturday)
        {
            //Post Office closes at 01:00 p.m.
            if ((numberOfMinutesPastMidnight >= One_pm - 20) && (numberOfMinutesPastMidnight < One_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                postOfficeCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            else if ((numberOfMinutesPastMidnight >= Ten_am - 20) && (numberOfMinutesPastMidnight < Ten_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                postOfficeCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Post Office  10:00 a.m. – 01:00 p.m.
            else if((numberOfMinutesPastMidnight >= Ten_am) && (numberOfMinutesPastMidnight < One_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                postOfficeCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                postOfficeCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
    }
    
    if (indexPath.row == 0 && indexPath.section == 4){
        
        ////////////////////
        // Gym Calculations
        ////////////////////

        //Mon-Thur
        if(currentWeekday == Monday || currentWeekday == Tuesday || currentWeekday == Wednesday || currentWeekday == Thursday)
        {
            //Gym closes at 10:45 p.m.
            if ((numberOfMinutesPastMidnight >= Ten_fourty_five_pm - 20) && (numberOfMinutesPastMidnight < Ten_fourty_five_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                skoglundCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            if ((numberOfMinutesPastMidnight >= Six_thirty_am - 20) && (numberOfMinutesPastMidnight < Six_thirty_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                skoglundCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Gym  06:30 a.m. – 10:45 p.m.
           else if ((numberOfMinutesPastMidnight >= Six_thirty_am) && (numberOfMinutesPastMidnight < Ten_fourty_five_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                skoglundCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                skoglundCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Fri
        if(currentWeekday == Friday)
        {
            //Gym closes at 08:45 p.m.
            if ((numberOfMinutesPastMidnight >= Eight_fourty_five_pm - 20) && (numberOfMinutesPastMidnight < Eight_fourty_five_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                skoglundCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            if ((numberOfMinutesPastMidnight >= Six_thirty_am - 20) && (numberOfMinutesPastMidnight < Six_thirty_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                skoglundCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Gym  6:30 a.m. – 08:45 p.m.
            else if((numberOfMinutesPastMidnight >= Six_thirty_am) && (numberOfMinutesPastMidnight < Eight_fourty_five_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                skoglundCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                skoglundCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sat
        if(currentWeekday == Saturday)
        {
            //Gym closes at 08:45 p.m.
            if ((numberOfMinutesPastMidnight >= Eight_fourty_five_pm - 20) && (numberOfMinutesPastMidnight < Eight_fourty_five_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                skoglundCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            if ((numberOfMinutesPastMidnight >= Nine_am - 20) && (numberOfMinutesPastMidnight < Nine_am))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                skoglundCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Gym  09:00 a.m. – 08:45 p.m.
            else if((numberOfMinutesPastMidnight >= Nine_am) && (numberOfMinutesPastMidnight < Eight_fourty_five_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                skoglundCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                skoglundCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
        
        //Sun
        if(currentWeekday == Sunday)
        {
            //Gym closes at 10:45 p.m.
            if ((numberOfMinutesPastMidnight >= Ten_fourty_five_pm - 20) && (numberOfMinutesPastMidnight < Ten_fourty_five_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                skoglundCircle.image = [UIImage imageNamed: @"closingSoon-circle.png"];
            }
            if ((numberOfMinutesPastMidnight >= Twelve_pm - 20) && (numberOfMinutesPastMidnight < Twelve_pm))
            {
                //If the current time falls between these calculations, set the circle to be yellow
                skoglundCircle.image = [UIImage imageNamed: @"openingSoon-circle.png"];
            }
            //Gym  12:00 p.m. – 10:45 p.m.
            else if((numberOfMinutesPastMidnight >= Twelve_pm) && (numberOfMinutesPastMidnight < Ten_fourty_five_pm))
            {
                //If the current time falls between these calculations, set the circle to be green
                skoglundCircle.image = [UIImage imageNamed: @"green-circle.png"];
            }
            else{
                //If the current time does not fall between these calculations, set the circle to be red
                skoglundCircle.image = [UIImage imageNamed: @"red-circle.png"];
            }
        }
    }
    

    

    
    return cell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
