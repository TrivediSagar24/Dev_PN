//
//  localNotification.h
//  PeopleNect
//
//  Created by Apple on 13/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface localNotification : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property(strong,nonatomic)NSString *jobTitleStr;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property(strong,nonatomic)NSString *companyNameStr;
@property(strong,nonatomic)NSDate *lastDate;
@property(strong,nonatomic)NSString *endDate;
@property(strong,nonatomic)NSString *endTime;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLbl;


- (IBAction)closedClicked:(id)sender;
- (IBAction)scheduleClicked:(id)sender;

@end
