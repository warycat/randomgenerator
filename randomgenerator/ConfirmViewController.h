//
//  ConfirmViewController.h
//  randomgenerator
//
//  Created by Larry on 9/1/12.
//  Copyright (c) 2012 Group9. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDice1 @"DICE1"
#define kDice2 @"DICE2"
#define kDice3 @"DICE3"
#define kRPS @"RPS"

@interface ConfirmViewController : UITableViewController

@property (strong, nonatomic) NSString *category;

@property (weak, nonatomic) IBOutlet UILabel *question;

@property (weak, nonatomic) IBOutlet UILabel *answer;
@property (weak, nonatomic) IBOutlet UITableViewCell *backCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *animateCell;

@end
