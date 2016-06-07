//
//  HoursViewController.swift
//  All About Olaf
//
//  Created by Hawken Rives on 6/6/16.
//  Copyright © 2016 Drew Volz. All rights reserved.
//

import Foundation
import UIKit

extension CollectionType {
    func find(@noescape predicate: (Self.Generator.Element) throws -> Bool) rethrows -> Self.Generator.Element? {
        return try indexOf(predicate).map({self[$0]})
    }
}

enum dayOfWeek: Int {
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
}

func am(hour: Int, _ minute: Int = 0) -> Int {
    let hour = hour % 12
    return (hour * 60) + minute
}

func pm(hour: Int, _ minute: Int = 0) -> Int {
    let hour = (hour + 12) % 24
    return (hour * 60) + minute
}

struct BuildingTime {
    let open: Int
    let close: Int
    init?(_ timeset: [String]) {
        guard timeset.count != 2 else {
            print("wrong number of times: \(timeset.count) instead of 2")
            return nil
        }

        open = toMinutesSinceMidnight(timeset[0])
        close = toMinutesSinceMidnight(timeset[1])
    }
    private func toMinutesSinceMidnight(str: String) -> Int {
        return 0
    }
    func asString() {

    }
}

struct BuildingTimeSet {
    let days: [String: BuildingTime?]

    init(_ timesAndDays: [String : [String]]) {
        for (day, times) in timesAndDays {
            days[day] = BuildingTime(times)
        }
    }
}

struct Building {
    let category: String
    let name: String
    let times: [String: BuildingTimeSet]
    init?(_ building: [String: AnyObject]) {
        guard
            building["category"] != nil &&
            building["name"] != nil &&
            building["times"] != nil
        else {
            return nil
        }

        category = building["category"] as! String
        name = building["name"] as! String

        // [String: [String: [String]]] => [group: [day: [open, close]]]
        let groupedTimes = building["times"] as! [String: [String: [String]]]
        for (group, timeset) in groupedTimes {
            times[group] = BuildingTimeSet(timeset)
        }
    }
}

let buildings = [
    [
        "category": "Food",
        "name": "Stav Hall",
        "times": [
            "Breakfast": [
                "Mon": ["7:00am", "9:45am"],
            ],
            "Lunch": [
                "Mon": ["10:30am", "2:00pm"],
            ],
            "Dinner": [
                "Mon": ["4:30pm", "7:00pm"],
            ],
        ],
    ],
].map({Building($0)})

let closingSoonCircle = UIImage(named: "closingSoon-circle.png")!
let openingSoonCircle = UIImage(named: "openingSoon-circle.png")!
let openNowCircle = UIImage(named: "green-circle.png")!
let closedNowCircle = UIImage(named: "red-circle.png")!

func checkBuildingStatus(buildingName: String, atTime: NSDate) -> UIImage {
    let building = buildings.find({$0 != nil && $0!.name == buildingName})

    guard building != nil
    else {
        return closedNowCircle
    }

    // unwrap once for the failable initializer, and once for the result of .find
    for (_, hourSet) in building!!.times {
        for (day, times) in hourSet.days {
            guard times != nil else {
                continue
            }
            if day != currentWeekday {
                continue
            }

            // the "opens/closing soon" timespan is fifteen minutes
            if (times!.open - currentTime) <= 15 {
                return openingSoonCircle
            }
            else if (times!.close - currentTime) <= 15 {
                return closingSoonCircle
            }
            else if (currentTime >= times!.open && currentTime <= times!.close) {
                return openNowCircle
            }
        }
    }

    return closedNowCircle
}

class HoursViewControllerSwift : UITableViewController {
    var now: NSDate
    var calendar: NSCalendar
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        calendar.timeZone = NSTimeZone(name: "CST")!
    }

    override func viewDidLoad() {
        // Initialize a calendar, and assign the time zone we want
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        calendar.timeZone = NSTimeZone(name: "CST")!

        // Set up our tracker for seconds after midnight
        now = NSDate()
        // let unitFlags = NSCalendarUnit(arrayLiteral: [.Weekday, .Hour, .Minute])
        // let components = calendar.components(unitFlags, fromDate: now)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: animated)
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView.cellForRowAtIndexPath(indexPath)

//        switch (indexPath.row, indexPath.section) {
//        case (0, 0):
//            stavCircle.image = self.findAppropriateImageFor(.StavHall)
//        }
        let image = checkBuildingStatus("Stav Hall", atTime: now)
    }
}
