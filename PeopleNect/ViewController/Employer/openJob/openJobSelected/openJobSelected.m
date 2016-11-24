//
//  openJobSelected.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/26/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "openJobSelected.h"

@interface openJobSelected ()
{
    int jobPostingPrice,jobInvitationPrice,TotalBalance,jobInvitationFavouritePrice;
}
@end

@implementation openJobSelected
#pragma mark - ViewLifecycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    _candidatesImage.hidden = NO;
    _inviteImag.hidden = YES;
    _jobTitleLbl.text = _jobTitle;
    _priceLabel.text = _jobPrice;
   
    _postJobView.hidden = YES;
    
     _CandidateArrayOptions = @[@"Hired", @"Selected", @"Applicants",@"Refuse"];
    
    self.candidatesTableView.allowMultipleSectionsOpen = YES;
   
    [self.candidatesTableView registerNib:[UINib nibWithNibName:@"OpenJobCandidatesCell" bundle:nil] forCellReuseIdentifier:@"OpenJobCandidatesCell"];
    
    [self.candidatesTableView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    
    NSData *PriceBalance = [[NSUserDefaults standardUserDefaults] objectForKey:@"jobPostingPriceBalance"];
    
    if (PriceBalance!=nil) {
         kAppDel.obj_jobPostingPriceBalance = [NSKeyedUnarchiver unarchiveObjectWithData:PriceBalance];
    }
    jobPostingPrice = [kAppDel.obj_jobPostingPriceBalance.jobPostingPrice intValue] ;
    jobInvitationPrice = [kAppDel.obj_jobPostingPriceBalance.jobInvitationPrice intValue];
    TotalBalance = [kAppDel.obj_jobPostingPriceBalance.balance intValue];
    jobInvitationFavouritePrice = [kAppDel.obj_jobPostingPriceBalance.jobInvitationFavouritePrice intValue];
    _candidatesTableView.delegate = self;
    _candidatesTableView.dataSource =self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"arrow" ];
    [self jobUsersList];

}


#pragma mark - navigation barBackButton  -
-(void)barBackButton
{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
    {
    if ([viewControllrObj isKindOfClass:[openJob class]])
        {
            [self.navigationController popToViewController:viewControllrObj animated:YES];
        }
    }
}
#pragma mark - IBAction -
- (IBAction)postJobClicked:(id)sender {
    
    if (jobPostingPrice<=TotalBalance) {
        [self publishJob];
    }
    else{
        noBalance *noBalance = [self.storyboard instantiateViewControllerWithIdentifier:@"noBalance"];
        UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:noBalance];
        obj_nav.definesPresentationContext = YES;
        obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:obj_nav animated:YES completion:nil];
    }
}

- (IBAction)btnCandidatesClicked:(id)sender {
    _candidatesImage.hidden = NO;
    _inviteImag.hidden = YES;
    _candidatesTableView.delegate = self;
    _candidatesTableView.dataSource =self;
    _candidatesTableView.hidden = NO;
    [_candidatesTableView reloadData];

}


- (IBAction)btnInvitesClicked:(id)sender {
    inviteCandidates *inviteCandidates = [self.storyboard instantiateViewControllerWithIdentifier:@"inviteCandidates"];
    inviteCandidates.jobId = _jobId;
    inviteCandidates.jobTitle = _jobTitle;
    inviteCandidates.jobPostingPrice  = jobPostingPrice;
    inviteCandidates.jobInvitationPrice = jobInvitationPrice;
    inviteCandidates.TotalBalance = TotalBalance;
    inviteCandidates.jobInvitationFavouritePrice = jobInvitationFavouritePrice;
    [self.navigationController pushViewController:inviteCandidates animated:YES];
}


-(void)hiredBtnClicked:(UIButton*)sender
{
    NSString *type = [self typeAcceptRefuse:sender acceptHire:@"Hire"];
     NSString *userId = [[_selectedArray valueForKey:@"userId"]objectAtIndex:sender.tag];
    
    [self hireEmployee:userId type:type];
    
}


-(void)acceptBtnClicked:(UIButton*)sender
{
    NSString *type = [self typeAcceptRefuse:sender acceptHire:@"accept"];
    NSString *userId = [[_applicantArray valueForKey:@"userId"]objectAtIndex:sender.tag];
    
    [self acceptRefuseEmployee:@"1" userID:userId type:type];
}


-(void)refuseBtnClicked:(UIButton*)sender
{
 NSString *type = [self typeAcceptRefuse:sender acceptHire:@"accept"];    NSString *userId = [[_applicantArray valueForKey:@"userId"]objectAtIndex:sender.tag];
    
    [self acceptRefuseEmployee:@"0" userID:userId type:type];
}


#pragma mark - Class Overrides -
- (BOOL)prefersStatusBarHidden {
    return NO;
}


#pragma mark - <UITableViewDataSource> / <UITableViewDelegate> -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return _hiredArray.count;
    }
    if (section==1) {
        return _selectedArray.count;
    }
if (section==2){
    return _applicantArray.count;
}
    else
        return _rejectedArray.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _CandidateArrayOptions.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
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
    
    OpenJobCandidatesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OpenJobCandidatesCell" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        
        cell.hiredBtn.hidden = YES;
        cell.rejectedLbl.hidden = YES;
        cell.rejectedImage.hidden = YES;
        cell.xrejectedLbl.hidden = YES;
        cell.multiplyImage.hidden = YES;
        cell.AcceptedLbl.hidden = YES;
        cell.arrowImage.hidden = YES;
    cell.acceptRefuseView.hidden = YES;
        
        cell.ratingLbl.hidden = NO;
        cell.ratingImage.hidden = NO;

        cell.employerName.text = [[_hiredArray valueForKey:@"userName"]objectAtIndex:indexPath.row];
        cell.categoryLbl.text = [NSString stringWithFormat:@"%@ - ",[[_hiredArray valueForKey:@"categoryName"]objectAtIndex:indexPath.row]];
        
        NSString *exp = [[_hiredArray valueForKey:@"experience"]objectAtIndex:indexPath.row];
        exp = [exp stringByReplacingOccurrencesOfString:@".00" withString:@""];
        
        cell.experienceLbl.text = [NSString stringWithFormat:@"%@ year/",exp];
        
        cell.distanceLbl.text = [NSString stringWithFormat:@"%@km",[[_hiredArray valueForKey:@"distance"]objectAtIndex:indexPath.row]];
        
        NSString *rating = [[_hiredArray valueForKey:@"userRating"]objectAtIndex:indexPath.row];

        rating = [rating substringToIndex:[rating length]-1];
        
        cell.ratingLbl.text = rating;
        
        NSString *url_Img = [[_hiredArray valueForKey:@"proifilePicUrl"]objectAtIndex:indexPath.row];
        
        [cell.profilePic sd_setImageWithURL:[NSURL URLWithString:url_Img] placeholderImage:[UIImage imageNamed:@"plceholder"]];

        
        return cell;
    }
    
    if (indexPath.section==1) {
    cell.xrejectedLbl.hidden = YES;
    cell.rejectedImage.hidden = YES;
    cell.ratingLbl.hidden = YES;
    cell.ratingImage.hidden = YES;
    cell.acceptRefuseView.hidden = YES;
    cell.rejectedLbl.hidden = YES;
    cell.multiplyImage.hidden = YES;
    cell.hiredBtn.hidden = YES;
    cell.AcceptedLbl.hidden = YES;
    cell.arrowImage.hidden = YES;
        
    cell.rejectedImage.image = [UIImage imageNamed:@"clock_"];
    cell.rejectedLbl.text = @"Waiting";
        
        
    NSString *eStaus = [[_selectedArray valueForKey:@"employer_status"]objectAtIndex:indexPath.row];
        
    NSString *jStatus = [[_selectedArray valueForKey:@"jobseeker_status"]objectAtIndex:indexPath.row];
    
    if ([eStaus isEqualToString:@"1"] && [jStatus isEqualToString:@"0"] ) {
        cell.hiredBtn.hidden = NO;
        }

    if ([jStatus isEqualToString:@"1"]) {
        
    if ([eStaus isEqualToString:@"0"] || [eStaus isEqualToString:@"5"]) {
        cell.hiredBtn.hidden = NO;
        cell.AcceptedLbl.hidden = NO;
        cell.arrowImage.hidden = NO;
        }
    }
       
        
    if ([jStatus isEqualToString:@"0"] && [eStaus isEqualToString:@"0"]){
        cell.rejectedImage.hidden = NO;
        cell.rejectedLbl.hidden = NO;
        }

        
    cell.hiredBtn.tag = indexPath.row;
        
    [cell.hiredBtn addTarget:self action:@selector(hiredBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        cell.employerName.text = [[_selectedArray valueForKey:@"userName"]objectAtIndex:indexPath.row];
        
        cell.categoryLbl.text = [NSString stringWithFormat:@"%@ - ",[[_selectedArray valueForKey:@"categoryName"]objectAtIndex:indexPath.row]];
        
        NSString *exp = [[_selectedArray valueForKey:@"experience"]objectAtIndex:indexPath.row];
        exp = [exp stringByReplacingOccurrencesOfString:@".00" withString:@""];
        
        cell.experienceLbl.text = [NSString stringWithFormat:@"%@ year/",exp];
        cell.distanceLbl.text = [NSString stringWithFormat:@"%@km",[[_selectedArray valueForKey:@"distance"]objectAtIndex:indexPath.row]];
        
        NSString *url_Img = [[_selectedArray valueForKey:@"proifilePicUrl"]objectAtIndex:indexPath.row];
        
        [cell.profilePic sd_setImageWithURL:[NSURL URLWithString:url_Img] placeholderImage:[UIImage imageNamed:@"plceholder"]];

        return cell;
    }
    
    if (indexPath.section==2) {
        
        cell.hiredBtn.hidden = YES;
        cell.rejectedLbl.hidden = YES;
        cell.rejectedImage.hidden = YES;
        cell.xrejectedLbl.hidden = YES;
        cell.ratingLbl.hidden = YES;
        cell.ratingImage.hidden = YES;
        cell.multiplyImage.hidden = YES;
        cell.AcceptedLbl.hidden = YES;
        cell.arrowImage.hidden = YES;
        
        cell.acceptRefuseView.hidden = NO;
        
    cell.acceptBtn.tag = indexPath.row;
    cell.refuseBtn.tag = indexPath.row;
        
      [cell.acceptBtn addTarget:self action:@selector(acceptBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    [cell.refuseBtn addTarget:self action:@selector(refuseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.employerName.text = [[_applicantArray valueForKey:@"userName"]objectAtIndex:indexPath.row];
        
        cell.categoryLbl.text = [NSString stringWithFormat:@"%@ - ",[[_applicantArray valueForKey:@"categoryName"]objectAtIndex:indexPath.row]];
        
        NSString *exp = [[_applicantArray valueForKey:@"experience"]objectAtIndex:indexPath.row];
        exp = [exp stringByReplacingOccurrencesOfString:@".00" withString:@""];
        
        cell.experienceLbl.text = [NSString stringWithFormat:@"%@ year/",exp];
        cell.distanceLbl.text = [NSString stringWithFormat:@"%@km",[[_applicantArray valueForKey:@"distance"]objectAtIndex:indexPath.row]];
        
        NSString *url_Img = [[_applicantArray valueForKey:@"proifilePicUrl"]objectAtIndex:indexPath.row];
        [cell.profilePic sd_setImageWithURL:[NSURL URLWithString:url_Img] placeholderImage:[UIImage imageNamed:@"plceholder"]];
        
        return cell;
    }
    if (indexPath.section==3) {
        
        cell.hiredBtn.hidden = YES;
        cell.xrejectedLbl.hidden = YES;
        cell.ratingLbl.hidden = YES;
        cell.ratingImage.hidden = YES;
        cell.multiplyImage.hidden = YES;
        cell.AcceptedLbl.hidden = YES;
        cell.arrowImage.hidden = YES;
        cell.acceptRefuseView.hidden =YES;
        cell.rejectedLbl.hidden = YES;
        cell.rejectedImage.hidden = YES;
        
//cell.xrejectedLbl.text = @"X Rejected";
        
        cell.rejectedImage.image = [UIImage imageNamed:@"rejected_"];
        
        cell.rejectedLbl.text = @"Rejected";
        
    NSString *eStaus = [[_rejectedArray valueForKey:@"employer_status"]objectAtIndex:indexPath.row];
        
    NSString *jStatus = [[_rejectedArray valueForKey:@"jobseeker_status"]objectAtIndex:indexPath.row];
        
    if ([jStatus isEqualToString:@"0"] && [eStaus isEqualToString:@"2"]) {
        cell.xrejectedLbl.hidden = NO;
        }

        if ([jStatus isEqualToString:@"2"] && [eStaus isEqualToString:@"0"]) {
        cell.rejectedImage.hidden = NO;
        cell.rejectedLbl.hidden = NO;
        }
        
        cell.employerName.text = [[_rejectedArray valueForKey:@"userName"]objectAtIndex:indexPath.row];
        
        cell.categoryLbl.text = [NSString stringWithFormat:@"%@ - ",[[_rejectedArray valueForKey:@"categoryName"]objectAtIndex:indexPath.row]];
        
        NSString *exp = [[_rejectedArray valueForKey:@"experience"]objectAtIndex:indexPath.row];
        exp = [exp stringByReplacingOccurrencesOfString:@".00" withString:@""];
        
        cell.experienceLbl.text = [NSString stringWithFormat:@"%@ year/",exp];
        cell.distanceLbl.text = [NSString stringWithFormat:@"%@km",[[_rejectedArray valueForKey:@"distance"]objectAtIndex:indexPath.row]];
        
        NSString *url_Img = [[_rejectedArray valueForKey:@"proifilePicUrl"]objectAtIndex:indexPath.row];
        
        [cell.profilePic sd_setImageWithURL:[NSURL URLWithString:url_Img] placeholderImage:[UIImage imageNamed:@"plceholder"]];

        return cell;
    }
    return nil;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    AccordionHeaderView *obj = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    obj.OpenJobLbl.hidden = YES;
    obj.openJobImage.hidden = YES;
    obj.headerlabel.text = [_CandidateArrayOptions objectAtIndex:section];
    
    if (section==0) {
         obj.totalValueLbl.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)_hiredArray.count];
    }
    if (section==1) {
         obj.totalValueLbl.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)_selectedArray.count];
    }
    if (section==2) {
         obj.totalValueLbl.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)_applicantArray.count];
    }
    if (section==3) {
         obj.totalValueLbl.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)_rejectedArray.count];
    }
    return obj;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     selectedEmployeeInfo *selectedEmployeeInfo = [self.storyboard instantiateViewControllerWithIdentifier:@"selectedEmployeeInfo"];
    
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:selectedEmployeeInfo];
    
    obj_nav.definesPresentationContext = YES;
    
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    if (indexPath.section==0) {
        
        [self presentViewController:obj_nav animated:YES completion:nil];
    }
    if (indexPath.section==1) {
        
        [self presentViewController:obj_nav animated:YES completion:nil];
    }
    if (indexPath.section==2) {
        
        [self presentViewController:obj_nav animated:YES completion:nil];
    }
    if (indexPath.section==3) {
        
        [self presentViewController:obj_nav animated:YES completion:nil];
    }
}
#pragma mark - <FZAccordionTableViewDelegate> -

- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}


#pragma mark - jobUsersList -
-(void)jobUsersList{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    _selectedArray = [[NSMutableArray alloc]init];
    _hiredArray = [[NSMutableArray alloc]init];
    _rejectedArray = [[NSMutableArray alloc]init];
    _applicantArray = [[NSMutableArray alloc]init];
    
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    [_param setObject:@"jobUsersList" forKey:@"methodName"];
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    [_param setObject:_jobId forKey:@"jobId"];
    
   [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
       NSLog(@"job user list %@",responseObject);
       
       [kAppDel.progressHud hideAnimated:YES];
       
       NSString *publishStatus = [responseObject valueForKey:@"publish_status"];
       
       if ([publishStatus isEqualToString:@"1"]) {
           _postJobView.hidden = YES;
            _tableViewHeight.constant = (self.view.frame.size.height*332)/568+_postJobView.frame.size.height;
       }
       else{

           _postJobViewHeight.constant = (self.view.frame.size.height*91)/568;
           _tableViewHeight.constant = (self.view.frame.size.height*332)/568;
           _postJobView.hidden = NO;
       }
       
       _hiredArray  = [[responseObject valueForKey:@"data"]valueForKey:@"hired"];
       _selectedArray = [[responseObject valueForKey:@"data"]valueForKey:@"selected"];
       _applicantArray = [[responseObject valueForKey:@"data"]valueForKey:@"applicants"];
       _rejectedArray = [[responseObject valueForKey:@"data"]valueForKey:@"rejected"];
       
       _candidatesTableView.hidden = NO;
       
       [_candidatesTableView reloadData];
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [kAppDel.progressHud hideAnimated:YES];
   }];
}


#pragma mark - publishJob -
-(void)publishJob{
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    [_param setObject:@"publishJob" forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    
    [_param setObject:_jobId forKey:@"jobId"];
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [kAppDel.progressHud hideAnimated:YES];
        
        _postJobView.hidden = YES;
        _tableViewHeight.constant = (self.view.frame.size.height*332)/568+_postJobView.frame.size.height;
        
        TotalBalance = TotalBalance - jobPostingPrice;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];
    }];
}


#pragma mark - acceptRefuseEmployee -
-(void)acceptRefuseEmployee:(NSString *)Accept userID:(NSString *)userID type: (NSString *)type
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];

    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    
    [_param setObject:@"acceptEmployee" forKey:@"methodName"];
    
    [_param setObject:Accept forKey:@"accept"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    
    [_param setObject:userID forKey:@"userId"];

    [_param setObject:_jobId forKey:@"jobId"];
    
    [_param setObject:type forKey:@"type"];
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [kAppDel.progressHud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];
    }];
}

#pragma mark - TypeAcceptRefuse -

-(NSString *)typeAcceptRefuse:(UIButton *)sender acceptHire:(NSString *)acceptHire
{
    NSString *type,*eStaus,*jStatus;
    
    if ([acceptHire isEqualToString:@"accept"]) {
        type = @"1";
    }
    if ([acceptHire isEqualToString:@"Hire"]) {
        eStaus = [[_selectedArray valueForKey:@"employer_status"]objectAtIndex:sender.tag];
        
        jStatus = [[_selectedArray valueForKey:@"jobseeker_status"]objectAtIndex:sender.tag];
    }
    
    if ([jStatus isEqualToString:@"1"]) {
        
        if ([eStaus isEqualToString:@"0"] || [eStaus isEqualToString:@"5"]) {
            type = @"1";
        }
    }
    
    if ([eStaus isEqualToString:@"1"] && [jStatus isEqualToString:@"0"]) {
        type = @"0";
    }
    return type;
}

#pragma mark - hireEmployee -
-(void)hireEmployee:(NSString *)userId type:(NSString *)type
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
     [_param setObject:@"hireEmployee"forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    
    [_param setObject:userId forKey:@"userId"];
    
    [_param setObject:_jobId forKey:@"jobId"];
    
    [_param setObject:type forKey:@"type"];

    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [kAppDel.progressHud hideAnimated:YES];
        NSLog(@"Hired response %@",responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];
    }];
    
    
}

@end
