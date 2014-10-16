//
//  CustomCell.h
//  TFTableView
//
//  Created by Anoop Mohandas on 07/06/13.
//  Copyright (c) 2013 Anoop Mohandas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;
@end
