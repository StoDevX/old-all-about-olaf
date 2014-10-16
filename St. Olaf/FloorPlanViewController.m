//
//  FloorPlanViewController.m
//  Oleville
//
//  Created by Drew Volz on 4/12/14.
//  Copyright (c) 2014 Drew Volz. All rights reserved.
//

#import "FloorPlanViewController.h"

@interface FloorPlanViewController ()

@end

@implementation FloorPlanViewController
@synthesize thePDF;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Floor Plan";

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    NSString *documentsDirectory = [[NSBundle mainBundle] pathForResource:thePDF ofType:@"pdf"];
    NSData *pdfData = [NSData dataWithContentsOfFile:documentsDirectory];
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 52, screenWidth,screenHeight - 52)];
    webview.scalesPageToFit=YES;
    webview.contentMode = UIViewContentModeScaleToFill;
    webview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    
    [self.view addSubview:webview];
    [webview loadData:pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
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
