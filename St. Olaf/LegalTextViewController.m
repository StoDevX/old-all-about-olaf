//
//  LegalTextViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 8/12/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "LegalTextViewController.h"

@interface LegalTextViewController ()

@end

@implementation LegalTextViewController
@synthesize toolbar;
@synthesize navBar;

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
    
    // size up the toolbar and set its frame
    // please note that it will work only for views without Navigation toolbars.
    CGFloat toolbarHeight = [toolbar frame].size.height;
    
    CGRect mainViewBounds = self.view.bounds;
    [toolbar setFrame:CGRectMake(CGRectGetMinX(mainViewBounds),
                                 CGRectGetMinY(mainViewBounds) + CGRectGetHeight(mainViewBounds) - (toolbarHeight),
                                 CGRectGetWidth(mainViewBounds),
                                 toolbarHeight)];
    
    
    
    UITextView *myUITextView = [[UITextView alloc] initWithFrame:CGRectMake(10, -60, CGRectGetWidth(mainViewBounds) - 50, CGRectGetHeight(mainViewBounds) - 50)];
    myUITextView.text = @"iPhone, iPod Touch, iPad are trademarks of Apple, Inc. registered in the US and other countries.\n\nThe Maps module in this app is provided by Apple, and by using it you agree to be bound by Apple's Terms of use, which can be found here: http://gspa21.ls.apple.com/html/attribution.html\n\nAll About Olaf's Terms of Use:\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE\n";
    
    myUITextView.textColor = [UIColor blackColor];
    myUITextView.font = [UIFont systemFontOfSize:16];
    [myUITextView setBackgroundColor:[UIColor clearColor]];
    myUITextView.editable = NO;
    myUITextView.scrollEnabled = YES;
    [_legalText addSubview:myUITextView];
    

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
