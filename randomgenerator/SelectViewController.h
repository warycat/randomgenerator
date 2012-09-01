//
//  SelectViewController.h
//  randomgenerator
//
//  Created by Larry on 9/1/12.
//  Copyright (c) 2012 Group9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *dice1Cell;
@property (weak, nonatomic) IBOutlet UITableViewCell *dice2Cell;
@property (weak, nonatomic) IBOutlet UITableViewCell *dice3Cell;
@property (weak, nonatomic) IBOutlet UITableViewCell *backCell;

@end
