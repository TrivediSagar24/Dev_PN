//
//  openJob.m
//  PeopleNect
//
//  Created by Narendra Pandey on 9/23/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "openJob.h"

@interface openJob ()

@end

@implementation openJob
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    _openJobTableView.delegate = self;
    _openJobTableView.dataSource = self;
    [self openJobs];
    self.openJobTableView.rowHeight = UITableViewAutomaticDimension;
    self.openJobTableView.estimatedRowHeight = 44.0;
    self.openJobTableView.allowMultipleSectionsOpen = YES;
    [self.openJobTableView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark - <FZAccordionTableViewDelegate> -

- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
    AccordionHeaderView *customHeader = (AccordionHeaderView *)header;
    customHeader.rightArrowImg.frame = CGRectMake(customHeader.rightArrowImg.frame.origin.x, 15, 18, 12);
    
    customHeader.rightArrowImg.image=[UIImage imageNamed:@"arrow_down"];
}

- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
    AccordionHeaderView *customHeader = (AccordionHeaderView *)header;
    
    customHeader.rightArrowImg.frame = CGRectMake(customHeader.rightArrowImg.frame.origin.x, 10, 10, 19);
    
    customHeader.rightArrowImg.image=[UIImage imageNamed:@"arrow_right"];
}


#pragma mark - <UITableViewDataSource> / <UITableViewDelegate> -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        if (_currentJob.count==0) {
            return 1;
        }else
        return _currentJob.count;
    }else
        if (_guestJob.count==0) {
            return 1;
        }else
        return _guestJob.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return kDefaultAccordionHeaderViewHeight;

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return [self tableView:tableView heightForHeaderInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    openJobCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"openJobCell" forIndexPath:indexPath];
    if (indexPath.section==0) {
        if (_currentJob.count==0) {
            Cell.textLabel.textColor = Cell.jobTitleLbl.textColor;
            Cell.textLabel.text = @"no available current jobs";
            Cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }else{
        Cell.jobTitleLbl.text = [[_currentJob valueForKey:@"jobTitle"] objectAtIndex:indexPath.row];
        
        Cell.priceLbl.text = [NSString stringWithFormat:@"$ %@/h",[[_currentJob valueForKey:@"rate"] objectAtIndex:indexPath.row]];
        
        Cell.dateLbl.text = [self dateToFormatedDate:[[_currentJob valueForKey:@"startDate"] objectAtIndex:indexPath.row]];
        Cell.publishBtn.hidden = NO;
        }
        
        return Cell;
    }
//     if (indexPath.section==1)
    else{
        if (_guestJob.count==0) {
            Cell.textLabel.textColor = Cell.jobTitleLbl.textColor;
            Cell.textLabel.text = @"no available guest jobs";
        Cell.textLabel.textAlignment = NSTextAlignmentCenter;

        }else{
            Cell.jobTitleLbl.text = [[_guestJob valueForKey:@"jobTitle"] objectAtIndex:indexPath.row];
            
            Cell.priceLbl.text = [NSString stringWithFormat:@"$ %@/h",[[_guestJob valueForKey:@"rate"] objectAtIndex:indexPath.row]];
            
            Cell.dateLbl.text = [self dateToFormatedDate:[[_guestJob valueForKey:@"startDate"] objectAtIndex:indexPath.row]];
            
            Cell.publishBtn.hidden = YES;
        }
        return Cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    openJobSelected *obj_openJobSelected  = [self.storyboard instantiateViewControllerWithIdentifier:@"openJobSelected"];
    if (indexPath.section==0) {
        if (_currentJob.count>0) {
            obj_openJobSelected.jobTitle = [[_currentJob valueForKey:@"jobTitle"] objectAtIndex:indexPath.row];
            
            obj_openJobSelected.jobPrice = [NSString stringWithFormat:@"$ %@/h",[[_currentJob valueForKey:@"rate"] objectAtIndex:indexPath.row]];
            
            obj_openJobSelected.jobId = [[_currentJob valueForKey:@"job_id"] objectAtIndex:indexPath.row];
            
            [self.navigationController pushViewController:obj_openJobSelected animated:YES];
        }
    }
    else{
        if (_guestJob.count>0) {
            obj_openJobSelected.jobTitle = [[_guestJob valueForKey:@"jobTitle"] objectAtIndex:indexPath.row];
            
            obj_openJobSelected.jobPrice = [NSString stringWithFormat:@"$ %@/h",[[_guestJob valueForKey:@"rate"] objectAtIndex:indexPath.row]];
            
            obj_openJobSelected.jobId = [[_guestJob valueForKey:@"job_id"] objectAtIndex:indexPath.row];
            
            [self.navigationController pushViewController:obj_openJobSelected animated:YES];
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    AccordionHeaderView *obj = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    
    obj.headerlabel.hidden = YES;
    obj.rightArrowImg.hidden = YES;
    
    obj.topView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    obj.backView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    if (section==0) {
         obj.OpenJobLbl.text = @"Current Jobs";
        obj.openJobImage.image = [UIImage imageNamed:@"guestIcon"];
    }
    if (section==1) {
       obj.OpenJobLbl.text = @"Jobs for guest";
        obj.openJobImage.image = [UIImage imageNamed:@"CurrentJobIcon"];
    }
    return obj;
}


#pragma mark - openJobs -
 -(void)openJobs{
     if ([GlobalMethods InternetAvailability]) {
         NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
         _currentJob = [[NSMutableArray alloc]init];
         _guestJob = [[NSMutableArray alloc]init];
         kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
         [_param setObject:@"openJobs" forKey:@"methodName"];
         [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
         [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [kAppDel.progressHud hideAnimated:YES];
             
             _currentJob = [[responseObject valueForKey:@"data"] valueForKey:@"currentJobs"];
             _guestJob = [[responseObject valueForKey:@"data"]valueForKey:@"jobsForGuest"];
             
             [_openJobTableView reloadData];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [kAppDel.progressHud hideAnimated:YES];
         }];
     }else{
         [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
     }
 }


#pragma mark - SlideNavigationController Methods -
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}


- (BOOL)slideNavigationControllerShouldDisplayRightMenu{
    return NO;
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
