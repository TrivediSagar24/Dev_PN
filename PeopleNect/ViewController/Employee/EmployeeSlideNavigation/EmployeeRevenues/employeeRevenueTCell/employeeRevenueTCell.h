//
//  employeeRevenueTCell.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/7/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface employeeRevenueTCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *revenueCellView;
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *totalTimeLbl;
@property (strong, nonatomic) IBOutlet UIView *amountView;
@property (strong, nonatomic) IBOutlet UIButton *amountBtn;
@property (strong, nonatomic) IBOutlet UILabel *amountLbl;
@property (strong, nonatomic) IBOutlet UILabel *amountPriceLbl;

@end
