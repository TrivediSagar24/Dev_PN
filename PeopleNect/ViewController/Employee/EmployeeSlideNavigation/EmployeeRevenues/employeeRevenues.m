//
//  employeeRevenues.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/7/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeRevenues.h"

@interface employeeRevenues ()
{
    NSTimer *Timer;
}
@end

@implementation employeeRevenues
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    Timer = [NSTimer scheduledTimerWithTimeInterval: 0.3 target: self selector:@selector(employeesRevenues)userInfo: nil repeats:NO];
   
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark - TableView degates -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_totalMonthWiseRevenue objectAtIndex:section]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    employeeRevenueTCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"employeeRevenueTCell" forIndexPath:indexPath];
   
    Cell.jobTitleLbl.text = [[[_totalMonthWiseRevenue objectAtIndex:indexPath.section]valueForKey:@"job_title"]objectAtIndex:indexPath.row];
    
    Cell.priceLbl.text = [NSString stringWithFormat:@"$%@/h",[[[_totalMonthWiseRevenue objectAtIndex:indexPath.section] valueForKey:@"hourly_rate"] objectAtIndex:indexPath.row]];
    
    Cell.companyNameLbl.text = @"Inexture LPP";

    Cell.totalTimeLbl.text = [[[_totalMonthWiseRevenue objectAtIndex:indexPath.section]valueForKey:@"total_hours"]objectAtIndex:indexPath.row];;
    
    Cell.amountPriceLbl.text = [NSString stringWithFormat:@"$%@/h",[[[_totalMonthWiseRevenue objectAtIndex:indexPath.section] valueForKey:@"total_amount"] objectAtIndex:indexPath.row]];
    
    return Cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _monthName.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0,tableView.frame.size.width ,25)];
    
    View.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, tableView.frame.size.width-40, 15)];
    
    label.textColor = [UIColor colorWithRed:34.0/255.0 green:34.0/255.0 blue:34.0/255.0 alpha:1.0];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    
    label.text = [NSString stringWithFormat:@"%@ ..........................................................................................................................................",[_monthName objectAtIndex:section ]];
    
    [View addSubview:label];
    
    return View;
}


#pragma mark - SlideNavigationController Methods -
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

#pragma mark - employeesRevenues -
-(void)employeesRevenues
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    _totalMonthWiseRevenue = [[NSMutableArray alloc]init];
    
    _revenuesInfo = [[NSMutableArray alloc]init];
    _monthName = [[NSMutableArray alloc]init];
    
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    
    [_param setObject:@"employeesRevenues" forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [kAppDel.progressHud hideAnimated:YES];
        
        _revenuesInfo = [[responseObject valueForKey:@"data"]mutableCopy];
        
        _monthName = [_revenuesInfo valueForKey:@"date"];
        
        _totalMonthWiseRevenue = [_revenuesInfo  valueForKey:@"revenue"];
        
        _revenueTableView.delegate = self;
        _revenueTableView.dataSource = self;
       
        [_revenueTableView reloadData];
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];
    }];
}

@end
