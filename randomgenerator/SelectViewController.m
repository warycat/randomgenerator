//
//  SelectViewController.m
//  randomgenerator
//
//  Created by Larry on 9/1/12.
//  Copyright (c) 2012 Group9. All rights reserved.
//

#import "SelectViewController.h"
#import "ConfirmViewController.h"

@interface SelectViewController ()
@property (strong, nonatomic) NSString *category;
@end

@implementation SelectViewController
@synthesize dice1Cell;
@synthesize dice2Cell;
@synthesize dice3Cell;
@synthesize backCell;

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

- (void)viewDidUnload
{
    [self setDice1Cell:nil];
    [self setDice2Cell:nil];
    [self setDice3Cell:nil];
    [self setBackCell:nil];
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
    if (cell == self.dice1Cell){
        self.category = kDice1;
        [self performSegueWithIdentifier:@"SelectSegue" sender:nil];
    }else if(cell == self.dice2Cell){
        self.category = kDice2;
        [self performSegueWithIdentifier:@"SelectSegue" sender:nil];
    }else if(cell == self.dice3Cell) {
        self.category = kDice3;
        [self performSegueWithIdentifier:@"SelectSegue" sender:nil];
    }else if (cell == self.backCell){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SelectSegue"]) {
        ConfirmViewController *cvc = segue.destinationViewController;
        cvc.category = self.category;
    }
}

@end
