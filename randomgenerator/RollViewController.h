//
//  RollViewController.h
//  randomgenerator
//
//  Created by Larry on 9/1/12.
//  Copyright (c) 2012 Group9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RollViewController : UIViewController
@property (strong, nonatomic) NSString *category;
@property (weak, nonatomic) IBOutlet UIImageView *diceImage1;
@property (weak, nonatomic) IBOutlet UIImageView *diceImage2;
@property (weak, nonatomic) IBOutlet UIImageView *diceImage3;
@property (weak, nonatomic) IBOutlet UILabel *diceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *diceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *diceLabel3;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@end
