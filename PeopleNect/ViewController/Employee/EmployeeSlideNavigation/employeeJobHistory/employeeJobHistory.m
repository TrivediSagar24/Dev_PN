//
//  employeeJobHistory.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/7/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeJobHistory.h"

@interface employeeJobHistory ()
{
    NSTimer *Timer;
    
}
@end

@implementation employeeJobHistory
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    
        Timer = [NSTimer scheduledTimerWithTimeInterval: 0.3 target: self selector:@selector(employeesJobsHistory)userInfo: nil repeats:NO];
    
    _jobHistoryOptions = @[@"Working history", @"Declined jobs",@"Other jobs"];
    
    self.JobHistoryTV.allowMultipleSectionsOpen = YES;
    
    [self.JobHistoryTV registerNib:[UINib nibWithNibName:@"onGoingSectionCell" bundle:nil] forCellReuseIdentifier:@"onGoingSectionCell"];
    
    
     [self.JobHistoryTV registerNib:[UINib nibWithNibName:@"workhistoryCell" bundle:nil] forCellReuseIdentifier:@"workhistoryCell"];
    
    [self.JobHistoryTV registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    
    _JobHistoryTV.delegate = self;
    _JobHistoryTV.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
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

#pragma mark - Class Overrides -
- (BOOL)prefersStatusBarHidden {
    return NO;
}


#pragma mark - <UITableViewDataSource> / <UITableViewDelegate> -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        if (section==0) {
            
            return _WorkhistoryArray.count;
        }
    if (section==1) {
        return _declineJobArray.count;
    }else
        return _otherJobArray.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _jobHistoryOptions.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 85;
    }else
    return 230;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return kDefaultAccordionHeaderViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return [self tableView:tableView heightForHeaderInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
         workhistoryCell *workCell = [tableView dequeueReusableCellWithIdentifier:@"workhistoryCell" forIndexPath:indexPath];
        return workCell;
    }
    if (indexPath.section==1) {
        onGoingSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"onGoingSectionCell" forIndexPath:indexPath];
        
        cell.followBtn.hidden = YES;
        return cell;
    }
    else if (indexPath.section==2){
        onGoingSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"onGoingSectionCell" forIndexPath:indexPath];
        
        cell.followBtn.hidden = YES;
        return cell;
    }
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    AccordionHeaderView *obj = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    obj.OpenJobLbl.hidden = YES;
    obj.openJobImage.hidden = YES;
    obj.topView.backgroundColor = [UIColor darkGrayColor];
    obj.backView.backgroundColor = [UIColor whiteColor];
    obj.headerlabel.text = [_jobHistoryOptions objectAtIndex:section];
    if (section==0) {
        obj.totalValueLbl.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)_WorkhistoryArray.count];
    }
    if (section==1) {
        obj.totalValueLbl.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)_declineJobArray.count];
    }
    if (section==2) {
         obj.totalValueLbl.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)_otherJobArray.count];
    }
    return obj;
}



#pragma mark - employeesJobsHistory -
-(void)employeesJobsHistory
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    _WorkhistoryArray = [[NSMutableArray alloc]init];
    _declineJobArray = [[NSMutableArray alloc]init];
    _otherJobArray = [[NSMutableArray alloc]init];

    if ([GlobalMethods InternetAvailability]) {
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        [_param setObject:@"JobHistory" forKey:@"methodName"];
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [kAppDel.progressHud hideAnimated:YES];
            
            _WorkhistoryArray = [[responseObject valueForKey:@"data"]valueForKey:@"jobHistory"];
            _declineJobArray = [[responseObject valueForKey:@"data"]valueForKey:@"rejectedInvitation"];
            _otherJobArray = [[responseObject valueForKey:@"data"]valueForKey:@"otherInvitation"];
            [_JobHistoryTV reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
        
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];

    }
}

#pragma mark - Date Formatter -
-(NSString *)dateToFormatedDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    [dateFormatter setDateFormat:@"dd/yy"];
    return [dateFormatter stringFromDate:date];
}

@end
