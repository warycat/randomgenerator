//
//  OptionViewController.m
//  randomgenerator
//
//  Created by Larry on 9/1/12.
//  Copyright (c) 2012 Group9. All rights reserved.
//

#import "OptionViewController.h"

@interface OptionViewController ()

@end

@implementation OptionViewController
@synthesize backCell;
@synthesize homeCell;


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [self setBackCell:nil];
    [self setHomeCell:nil];
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
    if (cell == self.backCell) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (cell == self.homeCell){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
