//
//  DetailViewController.h
//  ARSSReader
//
//  Created by Marin Todorov on 29/10/2012.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIAlertViewDelegate>
{
    UIView *subView;
}
@property (nonatomic, retain) UIView *subView;

@property (weak, nonatomic) IBOutlet UITextView *fullStory;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
