//
//  RollViewController.m
//  randomgenerator
//
//  Created by Larry on 9/1/12.
//  Copyright (c) 2012 Group9. All rights reserved.
//

#import "RollViewController.h"
#import "ConfirmViewController.h"
#import "AppDelegate.h"
#import "Sample.h"

@interface RollViewController ()
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSNumber *v;
@property (strong, nonatomic) NSNumber *v1;
@property (strong, nonatomic) NSNumber *v2;
@property (strong, nonatomic) NSNumber *v3;
@end

@implementation RollViewController
@synthesize diceImage1;
@synthesize diceImage2;
@synthesize diceImage3;
@synthesize diceLabel1;
@synthesize diceLabel2;
@synthesize diceLabel3;
@synthesize resultLabel;
@synthesize continueButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.resultLabel.alpha = 0;
    self.continueButton.alpha = 0;
    if ([self.category isEqualToString:kDice1]) {
        self.diceImage1.alpha = 0;
        self.diceImage3.alpha = 0;
        self.diceLabel1.alpha = 0;
        self.diceLabel3.alpha = 0;
        self.resultLabel.alpha = 0;
    }else if ([self.category isEqualToString:kDice2]){
        self.diceImage2.alpha = 0;
        self.diceLabel2.alpha = 0;
    }else if ([self.category isEqualToString:kDice3]){
        ;
    }
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.resultLabel.alpha = 0;
    self.continueButton.alpha = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(tick:) userInfo:@{@"start_time":[NSDate date]} repeats:YES];
}

- (void)viewDidUnload
{
    [self setDiceImage1:nil];
    [self setDiceImage2:nil];
    [self setDiceImage3:nil];
    [self setDiceLabel1:nil];
    [self setDiceLabel2:nil];
    [self setDiceLabel3:nil];
    [self setResultLabel:nil];
    [self setContinueButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tick:(NSTimer *)timer
{
    NSDictionary *info = timer.userInfo;
    NSDate *start_time = [info objectForKey:@"start_time"];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:start_time];
    if (timeInterval > 3.0) {
        [self.timer invalidate];
        //self.resultLabel.alpha = 1;
        self.continueButton.alpha = 1;
        if ([self.category isEqualToString:kDice1]) {
            self.v = [NSNumber numberWithInt: self.v2.intValue];
        }else if ([self.category isEqualToString:kDice2]){
            self.v = [NSNumber numberWithInt: self.v1.intValue + self.v3.intValue];
        }else if ([self.category isEqualToString:kDice3]){
            self.v = [NSNumber numberWithInt: self.v1.intValue + self.v2.intValue + self.v3.intValue];
        }
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        Sample *sample = [NSEntityDescription insertNewObjectForEntityForName:@"Sample" inManagedObjectContext:context];
        sample.category = self.category;
        sample.v = self.v;
        [appDelegate saveContext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sample"];
        request.resultType = NSCountResultType;
        request.predicate = [NSPredicate predicateWithFormat:@"category == %@",self.category];
        NSUInteger total = [context countForFetchRequest:request error:nil];
        request.predicate = [NSPredicate predicateWithFormat:@"category == %@ && v == %@",self.category,self.v];
        NSUInteger count = [context countForFetchRequest:request error:nil];
        self.resultLabel.text = [NSString stringWithFormat:@"Probability = %5.2f%%",(double)count / total * 100.0];
        
    }else{
        int r1 = rand()%6 + 1;
        int r2 = rand()%6 + 1;
        int r3 = rand()%6 + 1;
        self.v1 = [NSNumber numberWithInt:r1];
        self.v2 = [NSNumber numberWithInt:r2];
        self.v3 = [NSNumber numberWithInt:r3];
        self.diceLabel1.text = [NSString stringWithFormat:@"%d",r1];
        self.diceLabel2.text = [NSString stringWithFormat:@"%d",r2];
        self.diceLabel3.text = [NSString stringWithFormat:@"%d",r3];
        self.diceImage1.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",r1]];
        self.diceImage2.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",r2]];
        self.diceImage3.image = [UIImage imageNamed:[NSString stringWithFormat:@"dice%d.png",r3]];
    }
}


@end
