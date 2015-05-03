//
//  DirectoryNavController.m
//  All About Olaf
//
//  Created by Drew Volz on 8/28/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "DirectoryNavController.h"

@interface DirectoryNavController ()

@end

@implementation DirectoryNavController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
