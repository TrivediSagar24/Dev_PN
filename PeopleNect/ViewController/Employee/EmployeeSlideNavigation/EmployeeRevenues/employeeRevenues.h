//
//  employeeRevenues.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/7/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "employeeRevenueTCell.h"
@interface employeeRevenues : UIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *revenuesLbl;
@property (strong, nonatomic) IBOutlet UITableView *revenueTableView;
@property(nonatomic,strong)NSMutableArray *revenuesInfo;
@property(nonatomic,strong)NSMutableArray *monthName;
@property(nonatomic,strong)NSMutableArray *totalMonthWiseRevenue;


@end
