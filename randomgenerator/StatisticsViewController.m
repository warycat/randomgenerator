//
//  StatisticsViewController.m
//  randomgenerator
//
//  Created by Larry on 9/1/12.
//  Copyright (c) 2012 Group9. All rights reserved.
//

#import "StatisticsViewController.h"
#import "AppDelegate.h"
#import "ConfirmViewController.h"
#import "Sample.h"

enum kCategory {
    kCategoryDice1 = 0,
    kCategoryDice2 = 1,
    kCategoryDice3 = 2,
    kCategoryRPS = 3,
    kCategoryCount = 4,
};

@interface StatisticsViewController (){
    int d1[6];
    int d2[11];
    int d3[16];
    int d4[3];
}
@property (strong, nonatomic) NSArray *dice1;
@property (strong, nonatomic) NSArray *dice2;
@property (strong, nonatomic) NSArray *dice3;
@property (strong, nonatomic) NSArray *rps;
@end

@implementation StatisticsViewController


- (IBAction)reset:(id)sender {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sample"];
    NSArray *results = [context executeFetchRequest:request error:nil];
    for (Sample *sample in results) {
        [context deleteObject:sample];
    }
    [appDelegate saveContext];
    memset(d1, 0, 6*sizeof(int));
    memset(d2, 0, 11*sizeof(int));
    memset(d3, 0, 16*sizeof(int));
    memset(d4, 0, 3*sizeof(int));
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sample"];
    NSArray *results = [context executeFetchRequest:request error:nil];
    for (Sample *sample in results) {
        if ([sample.category isEqualToString:kDice1]) {
            int i = sample.v.intValue - 1;
            d1[i]++;
        }
        if ([sample.category isEqualToString:kDice2]) {
            int i = sample.v.intValue - 2;
            d2[i]++;
        }
        if ([sample.category isEqualToString:kDice3]) {
            int i = sample.v.intValue - 3;
            d3[i]++;
        }
        if ([sample.category isEqualToString:kRPS]) {
            int i = sample.v.intValue;
            d4[i]++;
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kCategoryCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case kCategoryDice1:
            return @"Dice 1";
        case kCategoryDice2:
            return @"Dice 2";
        case kCategoryDice3:
            return @"Dice 3";
        case kCategoryRPS:
            return @"Paper, Scissors, Stone";
        default:
            return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case kCategoryDice1:
            return 6;
        case kCategoryDice2:
            return 11;
        case kCategoryDice3:
            return 16;
        case kCategoryRPS:
            return 3;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SampleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    switch (indexPath.section) {
        case kCategoryDice1:
            cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",d1[indexPath.row]];
            break;
        case kCategoryDice2:
            cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+2];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",d2[indexPath.row]];
            break;
        case kCategoryDice3:
            cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+3];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",d3[indexPath.row]];
            break;
        case kCategoryRPS:
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[@[@"Stone",@"Paper",@"Scissors"] objectAtIndex: indexPath.row]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",d4[indexPath.row]];
            break;
        default:
            break;
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
