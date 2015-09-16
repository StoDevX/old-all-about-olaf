//
//  CustomTableViewController.m
//  CustomTable
//
//  Created by Simon on 7/12/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "RecipeTableCell.h"
#import "RecipeDetailViewController.h"
#import "Recipe.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <netinet/in.h>

@interface RecipeTableViewController ()
@end

@implementation RecipeTableViewController
@synthesize searchResults;
@synthesize recipes;
@synthesize myInt;
@synthesize countOfParseObjs;
@synthesize addWord;

NSMutableArray *parseArr;

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self)
    {
        // The className to query on
        self.parseClassName = @"Dictionary";

        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"word";

        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;

        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;

        // The number of objects to show per page
        //self.objectsPerPage = 10;
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"approved" equalTo:@"true"];
    [query orderByAscending:@"word"];
    query.limit = 1000;

    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0)
    {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [self.tableView reloadData];

    return query;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Initialize the recipes array
    // NOTE: a hack has been implemented here....we check if a recipe has the "first" or "last" text in their position. Update as needed

    // Handling the plus button being pushed
    addWord.target = self;
    addWord.action = @selector(addWord:);
}

- (void)viewWillAppear:(BOOL)animated
{
    // the array we're going to store our converted pfquery objects into recipes in
    parseArr = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    PFQuery *theQuery = [PFQuery queryWithClassName:self.parseClassName];
    [theQuery whereKey:@"approved" equalTo:@"true"];
    theQuery.limit = 1000;

    // Use countObjects instead of findObjects
    [theQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        // count tells you how many objects matched the query
        countOfParseObjs = [objects count];
        
        for (int i = 0; i < countOfParseObjs; ++i) {
            // pull out the necesssary componenets of the word/def
            Recipe *recipe = [[Recipe alloc] init];
            recipe.name = self.objects[i][@"word"];
            recipe.ingredients = @[self.objects[i][@"def"]];
            
            // store it into an array for searching for later
            [parseArr addObject:recipe];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section object:(PFObject *)object
{
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        return [searchResults count];
    }
    else
    {
        return countOfParseObjs;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.height;
}

// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"CustomTableCell";
    RecipeTableCell *cell = (RecipeTableCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    Recipe *recipe = [[Recipe alloc] init];
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if ([indexPath row] >= [searchResults count])
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = NO;
            self.height = 52;
        }
        else
        {
            recipe = [searchResults objectAtIndex:indexPath.row];
            self.height = 51;
        }
    }
    else
    {
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        recipe.name = [object objectForKey:@"word"];
        recipe.ingredients = @[ [object objectForKey:@"def"] ];
        self.height = 51;
    }

    cell.nameLabel.font = [cell.textLabel.font fontWithSize:16];
    cell.nameLabel.text = recipe.name;

    return cell;
}

- (void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    //NSLog(@"error: %@", [error localizedDescription]);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showRecipeDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RecipeDetailViewController *destViewController = segue.destinationViewController;

        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        Recipe *recipe = [[Recipe alloc] init];

        bool shouldDisplay = nil;

        // If we are actively searching
        if (self.searchDisplayController.active)
        {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            recipe = [searchResults objectAtIndex:indexPath.row];
            myInt = indexPath.row;
            shouldDisplay = false;
        }
        // If we are browsing the table
        else
        {
            indexPath = [self.tableView indexPathForSelectedRow];
            myInt = indexPath.row;
            recipe.name = [object objectForKey:@"word"];
            recipe.ingredients = @[ [object objectForKey:@"def"] ];
            shouldDisplay = true;
        }

        destViewController.recipe = recipe;
        destViewController.recipeList = parseArr;
        destViewController.theIndex = myInt;

        // Tells the detail view whether or not to display the word arrows
        destViewController.displaySegments = shouldDisplay;
    }
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope
{
    NSPredicate *resultPredicate = [NSPredicate
        predicateWithFormat:@"name contains[cd] %@",
                            searchText];

    searchResults = [parseArr filteredArrayUsingPredicate:resultPredicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                         objectAtIndex:[self.searchDisplayController.searchBar
                                                               selectedScopeButtonIndex]]];

    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
                                                                                       [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
}

// Handle adding a word button touched
- (void)addWord:(id)sender
{
    [self performSegueWithIdentifier:@"addWord" sender:sender];
}

/*
 Connectivity testing code pulled from Apple's Reachability Example: http://developer.apple.com/library/ios/#samplecode/Reachability
 */

- (BOOL)hasConnectivity
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;

    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&zeroAddress);
    if (reachability != NULL)
    {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags))
        {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                return NO;
            }

            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }

            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs

                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }

            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }

    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
