//
//  SecondViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/8/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "SecondViewController.h"
#import "DetailViewController.h"
#import "TableHeaderView.h"

#import "RSSLoader.h"
#import "RSSItem.h"

@interface SecondViewController ()
{
    NSArray *_objects;
    NSURL *feedURL;
    UIRefreshControl *refreshControl;
}
@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //configuration
    self.title = @"Calendar";
    feedURL = [NSURL URLWithString:@"http://www.stolaf.edu/calendar/index.cfm?fuseaction=RSS"];

    //add refresh control to the table view
    refreshControl = [[UIRefreshControl alloc] init];

    [refreshControl addTarget:self
                       action:@selector(refreshInvoked:forState:)
             forControlEvents:UIControlEventValueChanged];

    NSString *fetchMessage = [NSString stringWithFormat:@""];

    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage
                                                                     attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:11.0] }];

    [self.tableView addSubview:refreshControl];

    //add the header
    self.tableView.tableHeaderView = [[TableHeaderView alloc] initWithText:@""];

    [self refreshFeed];
}

- (void)refreshInvoked:(id)sender forState:(UIControlState)state
{
    [self refreshFeed];
}

- (void)refreshFeed
{
    RSSLoader *rss = [[RSSLoader alloc] init];
    [rss fetchRssWithURL:feedURL
                complete:^(NSString *title, NSArray *results) {
                    
                    //completed fetching the RSS
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //UI code on the main queue
                        [(TableHeaderView*)self.tableView.tableHeaderView setText:title];
                        
                        _objects = results;
                        [self.tableView reloadData];
                        
                        // Stop refresh control
                        [refreshControl endRefreshing];
                    });
                }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    RSSItem *object = _objects[indexPath.row];
    cell.textLabel.attributedText = object.cellMessage;
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSSItem *item = [_objects objectAtIndex:indexPath.row];
    CGRect cellMessageRect = [item.cellMessage boundingRectWithSize:CGSizeMake(100, 65)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                            context:nil];
    return cellMessageRect.size.height;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showMore"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RSSItem *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
