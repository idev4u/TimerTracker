//
//  TimerStartVC.m
//  TimeTracker
//
//  Created by Norman Sutorius on 03.08.15.
//  Copyright © 2015 Norman Sutorius. All rights reserved.
//

#import "TimerStartVC.h"
#import "TimeLapse.h"
#import "AppDelegate.h"

@interface TimerStartVC ()
@property (weak, nonatomic) IBOutlet UILabel *timerDisplay;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIButton *btnStop;


@end

@implementation TimerStartVC{
    NSString *timerDisplayText;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupButton:_btnStart];
    [self setupButton:_btnStop];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(UIButton *)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    TimeLapse *timeLapse = [NSEntityDescription insertNewObjectForEntityForName:@"TimeLapse" inManagedObjectContext:managedObjectContext];
    if(timeLapse != nil){
        timeLapse.recordDay = [[NSDate alloc] init]; //now
        timeLapse.recordState = @"time is tracking";
        timeLapse.startTimestamp = [[NSDate alloc] init];
        NSError *persitError = nil;
        
        if ([managedObjectContext save:&persitError]) {
            NSLog(@"persitentsSucces");
        }else{
            NSLog(@"persitentsError: %@", persitError);
        }
    } else {
        NSLog(@"persitentsError: No TimeLapse Object was created.");
    }
    
    _timerDisplay.numberOfLines = 0;
    _timerDisplay.lineBreakMode = NSLineBreakByWordWrapping;
    
    _timerDisplay.text = [self statusTextAtTimeLapseRunning];
    
}
- (IBAction)stop:(UIButton *)sender {
    // Fetch from CoreData
    NSFetchRequest *timeFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TimeLapse"];
    NSError *fetchError = nil;
    
    //global ?
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSArray *allTimeLapse = [managedObjectContext executeFetchRequest:timeFetchRequest error:&fetchError];
    if ([allTimeLapse count] > 0){
        NSUInteger counter = 0;
        for (TimeLapse *timeLapseItem in allTimeLapse) {
            NSLog(@"timelapse Obejct: %lu = %@, %@",counter, timeLapseItem.startTimestamp, timeLapseItem.recordState);
            counter++;
        }
    }else{
        NSLog(@"There are no TimeLapse Items");
    }
    
    
    //---end
    NSLog(@"this is the Labeltext: %@",timerDisplayText);
    if ([timerDisplayText length]!= 0) {
        _timerDisplay.text = timerDisplayText;
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setupButton:(UIButton *) sender{
    
    CGFloat btnHeight = sender.frame.size.height;
    sender.layer.cornerRadius = btnHeight/2.0f;
    //sender.layer.cornerRadius = 50/2.0f;
    sender.layer.borderColor=[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor;
    sender.layer.borderWidth=1.0f;
}

- (NSString*)statusTextAtTimeLapseRunning{
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    timerDisplayText = _timerDisplay.text;
    NSLog(@"this is the Labeltext: %@", timerDisplayText);
    NSMutableString *timerActiveMessage = [[NSMutableString alloc] init];
    [timerActiveMessage appendString:@"Time is tracking since: "];
    [timerActiveMessage appendString:dateString];
    NSLog(@" %@",timerActiveMessage);
    return timerActiveMessage;
}

@end
