//
//  ConfirmViewController.m
//  randomgenerator
//
//  Created by Larry on 9/1/12.
//  Copyright (c) 2012 Group9. All rights reserved.
//

#import "ConfirmViewController.h"
#import "RollViewController.h"

@interface ConfirmViewController ()

@end

@implementation ConfirmViewController
@synthesize question;
@synthesize answer;
@synthesize backCell;
@synthesize animateCell;

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
    if ([self.category isEqualToString:kDice1]) {
        self.question.text = @"You want to roll '1' dice?";
        self.answer.text = @"Yes (Let's roll)";
    }else if ([self.category isEqualToString:kDice2]){
        self.question.text = @"You want to roll '2' dice?";
        self.answer.text = @"Yes (Let's roll)";
    }else if ([self.category isEqualToString:kDice3]){
        self.question.text = @"You want to roll '3' dice?";
        self.answer.text = @"Yes (Let's roll)";
    }else if ([self.category isEqualToString:kRPS]){
        self.question.text = @"You want to play Paper, Scissors, Stone?";
        self.answer.text = @"Yes (I've got nothing better to do)";
    }
}

- (void)viewDidUnload
{
    [self setQuestion:nil];
    [self setAnswer:nil];
    [self setBackCell:nil];
    [self setAnimateCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == self.animateCell) {
        if ([self.category isEqualToString:kRPS]) {
            [self performSegueWithIdentifier:@"GameSegue" sender:self];
        }else{
            [self performSegueWithIdentifier:@"DiceSegue" sender:self];
        }
    }else if (cell == self.backCell){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DiceSegue"]) {
        RollViewController *rvc = segue.destinationViewController;
        rvc.category = self.category;
    }
}

@end
