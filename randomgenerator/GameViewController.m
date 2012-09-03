//
//  GameViewController.m
//  randomgenerator
//
//  Created by Larry on 9/1/12.
//  Copyright (c) 2012 Group9. All rights reserved.
//

#import "GameViewController.h"
#import "AppDelegate.h"
#import "ConfirmViewController.h"
#import "Sample.h"

@interface GameViewController ()
@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSNumber *v;
@end

@implementation GameViewController
@synthesize iconImage;
@synthesize iconLabel;
@synthesize resultLabel;
@synthesize continueButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.resultLabel.alpha = 0;
    self.continueButton.alpha = 0;
    self.results = @[@"Stone",@"Paper",@"Scissors"];
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
    [self setIconImage:nil];
    [self setIconLabel:nil];
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
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        Sample *sample = [NSEntityDescription insertNewObjectForEntityForName:@"Sample" inManagedObjectContext:context];
        sample.category = kRPS;
        sample.v = self.v;
        [appDelegate saveContext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sample"];
        request.resultType = NSCountResultType;
        request.predicate = [NSPredicate predicateWithFormat:@"category == %@",kRPS];
        NSUInteger total = [context countForFetchRequest:request error:nil];
        request.predicate = [NSPredicate predicateWithFormat:@"category == %@ && v == %@",kRPS,self.v];
        NSUInteger count = [context countForFetchRequest:request error:nil];
        self.resultLabel.text = [NSString stringWithFormat:@"Probability = %5.2f%%",(double)count / total * 100.0];
        
    }else{
        int r = rand()%3;
        self.v = [NSNumber numberWithInt:r];
        NSString *result = [self.results objectAtIndex:r];
        self.iconLabel.text = result;
        self.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",result]];
    }
}


@end
