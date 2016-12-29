//
//  onGoingJobs.m
//  PeopleNect
//
//  Created by Narendra Pandey on 06/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "onGoingJobs.h"

@interface onGoingJobs ()
{
    NSTimer *Timer;
}
@end

@implementation onGoingJobs
#pragma mark - View Life Cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    _onGoingArrayOptions = @[@"My next jobs", @"Pending application"];
    self.onGoingTV.allowMultipleSectionsOpen = YES;
    [self.onGoingTV registerNib:[UINib nibWithNibName:@"onGoingSectionCell" bundle:nil] forCellReuseIdentifier:@"onGoingSectionCell"];
   [self.onGoingTV registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    Timer = [NSTimer scheduledTimerWithTimeInterval: 0.3 target: self selector:@selector(GetOnGoingJobs)userInfo: nil repeats:NO];
    _onGoingTV.delegate = self;
    _onGoingTV.dataSource = self;
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
        return _nextApplicationArray.count;
//        return 5;
    }else
        return _pendingApplicationArray.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _onGoingArrayOptions.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    
    onGoingSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"onGoingSectionCell" forIndexPath:indexPath];
    
    [cell.followBtn addTarget:self action:@selector(followClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPath.section==0) {
        
        [cell.followBtn setTitle:@"See Details" forState:UIControlStateNormal];
        
        cell.jobTitleLbl.text = [[_nextApplicationArray valueForKey:@"jobTitle"]objectAtIndex:indexPath.row];
        NSString *price = [[_nextApplicationArray valueForKey:@"rate"]objectAtIndex:indexPath.row];
        price = [price stringByReplacingOccurrencesOfString:@".00" withString:@""];
        cell.priceLbl.text = [NSString stringWithFormat:@"RS%@/h",price];
        cell.companyNameLbl.text = [[_nextApplicationArray valueForKey:@"companyName"]objectAtIndex:indexPath.row];
        
        NSString *distance = [[_nextApplicationArray valueForKey:@"distance"]objectAtIndex:indexPath.row];
        
        double distanceValues = [distance doubleValue];
        
        cell.kmLbl.text = [NSString stringWithFormat:@"%.02fkm",distanceValues];
        
        cell.dateLbl.text = [[_nextApplicationArray valueForKey:@"date"]objectAtIndex:indexPath.row];
        
        cell.ratingLbl.text = [[_nextApplicationArray valueForKey:@"rating"]objectAtIndex:indexPath.row];
        
        cell.jobDescriptionLbl.text = [[_nextApplicationArray valueForKey:@"description"]objectAtIndex:indexPath.row];
        cell.addressLbl.text = [NSString stringWithFormat:@"%@ %@ %@",[[_nextApplicationArray valueForKey:@"address"]objectAtIndex:indexPath.row],[[_nextApplicationArray valueForKey:@"address1"]objectAtIndex:indexPath.row],[[_nextApplicationArray valueForKey:@"street_name"]objectAtIndex:indexPath.row]];
        
        cell.timeLbl.text = [NSString stringWithFormat:@"Start hour %@ /Total hours %@ ",[[_nextApplicationArray valueForKey:@"startHour"]objectAtIndex:indexPath.row],[[_nextApplicationArray valueForKey:@"totalHours"]objectAtIndex:indexPath.row]];
        
        cell.followBtn.tag = indexPath.row;
       
    }
    if (indexPath.section==1) {
        
        [cell.followBtn setTitle:@"Follow" forState:UIControlStateNormal];
        
        cell.jobTitleLbl.text = [[_pendingApplicationArray valueForKey:@"jobTitle"]objectAtIndex:indexPath.row];
        
        NSString *price = [[_pendingApplicationArray valueForKey:@"rate"]objectAtIndex:indexPath.row];
       
        price = [price stringByReplacingOccurrencesOfString:@".00" withString:@""];
        
        cell.priceLbl.text = [NSString stringWithFormat:@"RS%@/h",price];
        
        cell.companyNameLbl.text = [[_pendingApplicationArray valueForKey:@"companyName"]objectAtIndex:indexPath.row];
        
        NSString *distance = [[_pendingApplicationArray valueForKey:@"distance"]objectAtIndex:indexPath.row];
        
        double distanceValues = [distance doubleValue];
        
        cell.kmLbl.text = [NSString stringWithFormat:@"%.02fkm",distanceValues];
        
        cell.dateLbl.text = [[_pendingApplicationArray valueForKey:@"date"]objectAtIndex:indexPath.row];
        cell.ratingLbl.text = [[_pendingApplicationArray valueForKey:@"rating"]objectAtIndex:indexPath.row];
        cell.jobDescriptionLbl.text = [[_pendingApplicationArray valueForKey:@"description"]objectAtIndex:indexPath.row];
        
        cell.addressLbl.text = [NSString stringWithFormat:@"%@ %@ %@",[[_pendingApplicationArray valueForKey:@"address"]objectAtIndex:indexPath.row],[[_pendingApplicationArray valueForKey:@"address1"]objectAtIndex:indexPath.row],[[_pendingApplicationArray valueForKey:@"street_name"]objectAtIndex:indexPath.row]];
        
        cell.timeLbl.text = [NSString stringWithFormat:@"Start hour %@ /Total hours %@ ",[[_pendingApplicationArray valueForKey:@"startHour"]objectAtIndex:indexPath.row],[[_pendingApplicationArray valueForKey:@"totalHours"]objectAtIndex:indexPath.row]];

        cell.followBtn.tag = indexPath.row;
    }
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    AccordionHeaderView *obj = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    obj.openJobImage.hidden = YES;
    obj.OpenJobLbl.hidden = YES;
    obj.topView.backgroundColor = [UIColor darkGrayColor];
    obj.backView.backgroundColor = [UIColor whiteColor];
    obj.headerlabel.text = [_onGoingArrayOptions objectAtIndex:section];
    
    if (section==0) {
        obj.totalValueLbl.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)_nextApplicationArray.count];
    }
    if (section==1) {
        obj.totalValueLbl.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)_pendingApplicationArray.count];
    }
    return obj;
}


#pragma mark - GetOnGoingJobs -
-(void)GetOnGoingJobs{
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        [_param setObject:@"getOngoingJobs" forKey:@"methodName"];
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [kAppDel.progressHud hideAnimated:YES];
            
            _nextApplicationArray = [[responseObject valueForKey:@"data"]valueForKey:@"nextJobCollection"];
            _pendingApplicationArray = [[responseObject valueForKey:@"data"]valueForKey:@"acceptedInvitation"];
            [_onGoingTV reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}

#pragma mark - IBActions -
-(void)followClicked:(UIButton*)Sender
{
    CGPoint touchPoint = [Sender convertPoint:CGPointZero toView:_onGoingTV];
    
    NSIndexPath *clickedButtonIndexPath = [_onGoingTV indexPathForRowAtPoint:touchPoint];
    
//    NSLog(@"index path.section ==%ld",(long)clickedButtonIndexPath.section);
//    
//    NSLog(@"index path.row ==%ld",(long)clickedButtonIndexPath.row);

    if (clickedButtonIndexPath.section==1) {
        
        NSString *type = [[_pendingApplicationArray valueForKey:@"type"]objectAtIndex:Sender.tag];
        
        NSString *jobId = [[_pendingApplicationArray valueForKey:@"jobId"]objectAtIndex:Sender.tag];
        if ([type isEqual:@0]) {
            
            [self FollowJob:@"followUpInvitations" jobId:jobId SenderButton:Sender];
        }
        if ([type isEqual:@1]) {
             [self FollowJob:@"followUp" jobId:jobId SenderButton:Sender];
        }
    }
    if (clickedButtonIndexPath.section==0) {
        
        seeDetailsNotification *obj_seeDetailsNotification = [self.storyboard instantiateViewControllerWithIdentifier:@"seeDetailsNotification"];
        
        obj_seeDetailsNotification.jobId = [[_nextApplicationArray valueForKey:@"jobId"]objectAtIndex:Sender.tag];
        
        obj_seeDetailsNotification.ratings = [[_nextApplicationArray valueForKey:@"rating"]objectAtIndex:Sender.tag];
        
        obj_seeDetailsNotification.jobDescription = [[_nextApplicationArray valueForKey:@"description"]objectAtIndex:Sender.tag];
        
       obj_seeDetailsNotification.bottomAddress = [NSString stringWithFormat:@"%@ %@ %@",[[_nextApplicationArray valueForKey:@"address"]objectAtIndex:Sender.tag],[[_nextApplicationArray valueForKey:@"address1"]objectAtIndex:Sender.tag],[[_nextApplicationArray valueForKey:@"street_name"]objectAtIndex:Sender.tag]];
        
        UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:obj_seeDetailsNotification];
        
        obj_nav.definesPresentationContext = YES;
        
        obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
        
        [self presentViewController:obj_nav animated:YES completion:nil];
    }
}
#pragma mark - Apply and Follow job -
-(void)FollowJob:(NSString*)Method jobId:(NSString*)jobId SenderButton:(UIButton*)Sender
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    [_param setObject:Method forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"jobseeker_id"];
    
    [_param setObject:jobId forKey:@"job_id"];
    
    if ([GlobalMethods InternetAvailability]) {
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [kAppDel.progressHud hideAnimated:YES];
            
            EmployeeApplyForJob *obj_EmployeeApplyForJob = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeApplyForJob"];
            
            NSString *eStatus= [[responseObject valueForKey:@"data"]valueForKey:@"employerStatus"];
            
            NSString*jStatus= [[responseObject valueForKey:@"data"]valueForKey:@"jobseekerStatus"];
            
            obj_EmployeeApplyForJob.companyName = [[_pendingApplicationArray objectAtIndex:Sender.tag]valueForKey:@"companyName"];
            
            obj_EmployeeApplyForJob.jobTitle = [[_pendingApplicationArray objectAtIndex:Sender.tag]valueForKey:@"jobTitle"];
            
            obj_EmployeeApplyForJob.applicationSent = @"Application Sent";
            obj_EmployeeApplyForJob.applicationWaiting = @"Waiting for hiring manager to check your application";
            obj_EmployeeApplyForJob.applicationFeedback = @"Waiting feedback";
            
            if ([Method isEqualToString:@"followUp"]) {
                if ([eStatus isEqual:@0] &&   [jStatus isEqual:@0]) {
                }
                else if ([eStatus isEqual:@5] &&   [jStatus isEqual:@0]) {
                    obj_EmployeeApplyForJob.applicationWaiting = @"Hiring manager received your application";
                    obj_EmployeeApplyForJob.wait = @"wait";
                    
                    
                }
                else if ([eStatus isEqual:@4] &&   [jStatus isEqual:@0]) {
                    obj_EmployeeApplyForJob.applicationWaiting = @"Hiring manager received your application";
                    obj_EmployeeApplyForJob.applicationFeedback = @"You were selected!";
                    obj_EmployeeApplyForJob.result = @"selected";
                    
                }
                else if ([eStatus isEqual:@2] &&   [jStatus isEqual:@0]) {
                    obj_EmployeeApplyForJob.applicationWaiting = @"Hiring manager received your application";
                    obj_EmployeeApplyForJob.applicationFeedback = @"You were rejected!";
                    obj_EmployeeApplyForJob.result = @"rejected";
                    
                }
            }
            if ([Method isEqualToString:@"followUpInvitations"]) {
                
                if ([eStatus isEqual:@0] &&   [jStatus isEqual:@1]) {
                    obj_EmployeeApplyForJob.applicationSent = @"You accepted an invitation";
                }
                else if ([eStatus isEqual:@5] &&   [jStatus isEqual:@1]) {
                    obj_EmployeeApplyForJob.applicationWaiting = @"Hiring manager aware of your application";
                    obj_EmployeeApplyForJob.wait = @"wait";
                    
                }
                else if ([eStatus isEqual:@4] &&   [jStatus isEqual:@1]) {
                    obj_EmployeeApplyForJob.applicationWaiting = @"Hiring manager aware of your application";
                    obj_EmployeeApplyForJob.applicationFeedback = @"You were selected!";
                    obj_EmployeeApplyForJob.result = @"selected";
                    
                }
                else if ([eStatus isEqual:@2] &&   [jStatus isEqual:@0]) {
                    obj_EmployeeApplyForJob.applicationWaiting = @"Hiring manager aware of your application";
                    obj_EmployeeApplyForJob.applicationFeedback = @"You were rejected!";
                    obj_EmployeeApplyForJob.result = @"rejected";
                }
            }
            
            UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:obj_EmployeeApplyForJob];
            
            obj_nav.definesPresentationContext = YES;
            
            obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
            
            [self presentViewController:obj_nav animated:YES completion:nil];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}

@end
