//
//  TimerStartVC.m
//  TimeTracker
//
//  Created by Norman Sutorius on 03.08.15.
//  Copyright © 2015 Norman Sutorius. All rights reserved.
//

#import "TimerStartVC.h"

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
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    timerDisplayText = _timerDisplay.text;
    NSLog(@"this is the Labeltext: %@", timerDisplayText);
    NSMutableString *timerActiveMessage = [[NSMutableString alloc] init];
    [timerActiveMessage appendString:@"Time is tracking since: \n"];
    [timerActiveMessage appendString:dateString];
    NSLog(@" %@",timerActiveMessage);
    _timerDisplay.lineBreakMode = NSLineBreakByWordWrapping;
    _timerDisplay.numberOfLines = 0;
//    _timerDisplay.numberOfLines = 1;
    _timerDisplay.text = timerActiveMessage;
    
}
- (IBAction)stop:(UIButton *)sender {
    NSLog(@"this is the Labeltext: %@",timerDisplayText);
    
    _timerDisplay.text = timerDisplayText;
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


@end
