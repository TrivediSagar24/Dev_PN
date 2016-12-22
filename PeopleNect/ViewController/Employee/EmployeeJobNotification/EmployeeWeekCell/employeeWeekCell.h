//
//  employeeWeekCell.h
//  PeopleNect
//
//  Created by Narendra Pandey on 8/26/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface employeeWeekCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *WeekNameView;
@property (strong, nonatomic) IBOutlet UIButton *btnWeekAdd;
@property (strong, nonatomic) IBOutlet UIView *viewWeekUpper;
@property (strong, nonatomic) IBOutlet UILabel *lblWeekName;
@property (strong, nonatomic) IBOutlet UILabel *lblStartTime;
@property (strong, nonatomic) IBOutlet UILabel *lblNotAvailable;
@property (strong, nonatomic) IBOutlet UILabel *lblEndTime;
@property (strong, nonatomic) IBOutlet UILabel *lblBorder;
@property (strong, nonatomic) IBOutlet UILabel *lblBorderLower;

@end
