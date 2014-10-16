//
//  AdsTableViewController.m
//  All About Olaf
//
//  Created by Drew Volz on 4/24/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "AdsTableViewController.h"

@interface AdsTableViewController ()

@end

@implementation AdsTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 3, 3)];

    if(indexPath.row == 0) {
        //Ad image
        imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                            [NSURL URLWithString:@"http://oleville.com/new/all-about-olaf/ads/caribou.jpg"]]];
        cell.imageView.image = imgView.image;
        
        //Ad company text
        cell.textLabel.text = @"Caribou Coffee";
        cell.detailTextLabel.text = @"Get a FREE shot of espresso in any drink when you show this coupon at your local Northfield store.";
        cell.detailTextLabel.numberOfLines = 0;
    }
    else if(indexPath.row == 1) {
        //Ad image
        imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                [NSURL URLWithString:@"http://oleville.com/new/all-about-olaf/ads/ragstock.jpg"]]];
        cell.imageView.image = imgView.image;
        
        //Ad company text
        cell.textLabel.text = @"Ragstock";
        cell.detailTextLabel.text = @"Stop by your Northfield Ragstock and receive 10% off any purchase when you show this coupon.";
        cell.detailTextLabel.numberOfLines = 0;
    }
    else if(indexPath.row == 2) {
        //Ad image
        imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                [NSURL URLWithString:@"http://oleville.com/new/all-about-olaf/ads/oleStore.png"]]];
        cell.imageView.image = imgView.image;
        
        //Ad company text
        cell.textLabel.text = @"Ole Store Restaurant";
        cell.detailTextLabel.text = @"Tuesdays are our FREE appetizer nights! Show your cashier this deal, and receive your free appetizer.";
        cell.detailTextLabel.numberOfLines = 0;
    }
    else if(indexPath.row == 3) {
        //Ad image
        imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                [NSURL URLWithString:@"http://oleville.com/new/all-about-olaf/ads/tandem.png"]]];
        cell.imageView.image = imgView.image;
        
        //Ad company text
        cell.textLabel.text = @"Tandem Bagels";
        cell.detailTextLabel.text = @"Buy 1 bagel, receive a drink for half-off with this exclusive coupon. Show your cashier to receive this deal.";
        cell.detailTextLabel.numberOfLines = 0;
    }

    //Little trick to show dividers in front of the images
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
