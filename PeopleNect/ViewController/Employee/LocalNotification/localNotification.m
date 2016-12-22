//
//  localNotification.m
//  PeopleNect
//
//  Created by Narendra Pandey on 13/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "localNotification.h"

@interface localNotification ()
{
    NSDate *firedDateTime;
}
@end

@implementation localNotification
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _jobTitle.text = _jobTitleStr;
    _companyName.text = _companyNameStr;
    
     _datePicker.backgroundColor = [UIColor whiteColor];
    
    [_datePicker setMinimumDate:[NSDate date]];
    
//    [_datePicker setMaximumDate:_lastDate];
    
    _dateTimeLbl.text = [NSString stringWithFormat:@"Remainder Time is %@",[self DateFormat:self.datePicker.date]];
    
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}


#pragma mark - Picker UIControlEventValueChanged -
- (void)dateChanged:(id)sender{
    _dateTimeLbl.text = [NSString stringWithFormat:@"Remainder Time is %@",[self DateFormat:self.datePicker.date]];
    firedDateTime = self.datePicker.date;
}


#pragma mark - IBActions -
- (IBAction)closedClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)scheduleClicked:(id)sender {
    
    /*
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = firedDateTime;
    
    localNotification.alertBody = [NSString stringWithFormat:@" %@ at %@",_jobTitle.text,_companyName.text];
    
//    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
//    localNotification.applicationIconBadgeNumber = localNotification.applicationIconBadgeNumber+1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Dismiss the view controller
 */   [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - DateFormat -
-(NSString*)DateFormat:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [dateFormatter stringFromDate:date];
    return currentTime;
}
@end
