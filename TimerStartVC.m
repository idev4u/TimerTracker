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

@implementation TimerStartVC


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
    self.timerDisplay.text = @"start";
    
}
- (IBAction)stop:(UIButton *)sender {
    self.timerDisplay.text = @"stop";
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
