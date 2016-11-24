//
//  inviteCandidates.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/27/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "inviteCandidates.h"

@interface inviteCandidates ()
{
    BOOL all,hot;
    NSMutableArray *invitedSelection,*hotInvited,*selectedAllUser ,*selectedFavaouriteUser;
    CGFloat heightforTableView;
    UIView *BottomView;
    int InvitedTotalPrice;
}
@end

@implementation inviteCandidates
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    invitedSelection = [[NSMutableArray alloc]init];
    hotInvited = [[NSMutableArray alloc]init];
    _allBtnArrowimg.hidden = NO;
    _favouriteBtnArrowimg.hidden = YES;
    all = YES;
    hot = NO;
    InvitedTotalPrice = 0;
    _availableCandidatesLbl.text = @"Available Candidates";
    _inviteTopLbl.text = [NSString stringWithFormat:@"Invite candidates for your \n job %@",_jobTitle];
    selectedAllUser = [[NSMutableArray alloc]init];  selectedFavaouriteUser = [[NSMutableArray alloc]init];
    [self allEmployeesList];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"Gray_right_arrow_" ];
}

-(void)viewDidAppear:(BOOL)animated
{
    _heightForAvailableTable.constant = (self.view.frame.size.height*318)/568;
    
    heightforTableView = _availableTableView.frame.origin.y + (self.view.frame.size.height*268)/568;
    
    BottomView = [[UIView alloc]initWithFrame:CGRectMake(0, heightforTableView, self.view.frame.size.width, (self.view.frame.size.height*50)/568)];
    
    CGFloat X = (self.view.frame.size.width *35)/320;
    CGFloat Y = (self.view.frame.size.height*5)/568;
    CGFloat width = (self.view.frame.size.width *250)/320;
    CGFloat height = (self.view.frame.size.height*40)/568;

    UIButton *invitedBtn = [[UIButton alloc]initWithFrame:CGRectMake(X, Y, width, height)];
    
    invitedBtn.backgroundColor = [UIColor colorWithRed:6.0/255.0 green:40.0/255.0 blue:75.0/255.0 alpha:1.0];
    [invitedBtn setTitle:@"Invite" forState:UIControlStateNormal];
    
    [invitedBtn addTarget:self action:@selector(inviteCandidate:) forControlEvents:UIControlEventTouchDown];
    
    [BottomView addSubview:invitedBtn];
    
    BottomView.hidden = YES;
    
    BottomView.backgroundColor = _availableTableView.backgroundColor;
    
    [_bottomView addSubview:BottomView];
}


#pragma mark - navigation barBackButton  -
-(void)barBackButton
{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
    {
        if ([viewControllrObj isKindOfClass:[openJobSelected class]])
        {
            [self.navigationController popToViewController:viewControllrObj animated:YES];
        }
    }
}

#pragma mark - tableView DataSource  -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (all==YES) {
        return _allEmployeeArray.count;
    }
    else{
    return _hotEmployeeArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    inviteCandidatesCell *inviteCandidatesCell = [tableView dequeueReusableCellWithIdentifier:@"inviteCandidatesCell" forIndexPath:indexPath];
    
    if (all==YES) {
        
        if (_allEmployeeArray.count>0) {
            NSString *Name = [[_allEmployeeArray valueForKey:@"first_name"]objectAtIndex:indexPath.row];
            
            NSString *lastName = [[_allEmployeeArray valueForKey:@"last_name"]objectAtIndex:indexPath.row];
            
            Name = [NSString stringWithFormat:@"%@ %@",Name,lastName];
            
            inviteCandidatesCell.EmployerName.text = Name;
            
            inviteCandidatesCell.categoryLbl.text = [NSString stringWithFormat:@"%@ - ",[[_allEmployeeArray valueForKey:@"categoryName"]objectAtIndex:indexPath.row]];
            
            NSString *exp = [[_allEmployeeArray valueForKey:@"exp_years"]objectAtIndex:indexPath.row];
            
            exp = [exp stringByReplacingOccurrencesOfString:@".00" withString:@""];
            
            inviteCandidatesCell.expLbl.text = [NSString stringWithFormat:@"%@ year/",exp];
            
            inviteCandidatesCell.distanceLbl.text = [NSString stringWithFormat:@"%@km",[[_allEmployeeArray valueForKey:@"distance"]objectAtIndex:indexPath.row]];
            
            NSString *rating = [[_allEmployeeArray valueForKey:@"userRating"]objectAtIndex:indexPath.row];
            
            if ( rating != (NSString *)[NSNull null] ){
                rating = [rating substringToIndex:[rating length]-1];
                inviteCandidatesCell.ratingLbl.text = rating;
            }
            else{
                inviteCandidatesCell.ratingLbl.text = @"0.0";
            }
            
            NSString *url_Img = [[_allEmployeeArray valueForKey:@"jobseeker_profile_pic"]objectAtIndex:indexPath.row];
            
            [inviteCandidatesCell.profilePic sd_setImageWithURL:[NSURL URLWithString:url_Img]];
            
            [inviteCandidatesCell.profilePic sd_setImageWithURL:[NSURL URLWithString:url_Img] placeholderImage:[UIImage imageNamed:@"plceholder"]];
            
        inviteCandidatesCell.addSelected.tag = indexPath.row;
            
            [inviteCandidatesCell.addSelected addTarget:self action:@selector(allEmployeeAddClicked:) forControlEvents:UIControlEventTouchUpInside];
            
             if ([[selectedAllUser objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
                 [inviteCandidatesCell.addSelected setImage:[UIImage imageNamed:@"arrow_"] forState:UIControlStateNormal];
             }
            if ([[selectedAllUser objectAtIndex:indexPath.row]isEqualToString:@"0"]) {
                [inviteCandidatesCell.addSelected setImage:[UIImage imageNamed:@"Whiteplus_"] forState:UIControlStateNormal];
            }
        }
        return inviteCandidatesCell;

    }
    if (hot == YES) {
        
        if (_hotEmployeeArray.count>0) {
            
            if ([[selectedFavaouriteUser objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
                [inviteCandidatesCell.addSelected setImage:[UIImage imageNamed:@"arrow_"] forState:UIControlStateNormal];
            }
            if ([[selectedFavaouriteUser objectAtIndex:indexPath.row]isEqualToString:@"0"]) {
                
                [inviteCandidatesCell.addSelected setImage:[UIImage imageNamed:@"Whiteplus_"] forState:UIControlStateNormal];
            }
            NSString *Name = [[_hotEmployeeArray valueForKey:@"first_name"]objectAtIndex:indexPath.row];
            NSString *lastName = [[_hotEmployeeArray valueForKey:@"last_name"]objectAtIndex:indexPath.row];
            
            Name = [NSString stringWithFormat:@"%@ %@",Name,lastName];
            
            inviteCandidatesCell.EmployerName.text = Name;
            
            inviteCandidatesCell.categoryLbl.text = [NSString stringWithFormat:@"%@ - ",[[_hotEmployeeArray valueForKey:@"categoryName"]objectAtIndex:indexPath.row]];
            
            NSString *exp = [[_hotEmployeeArray valueForKey:@"exp_years"]objectAtIndex:indexPath.row];
            
            exp = [exp stringByReplacingOccurrencesOfString:@".00" withString:@""];
            
            inviteCandidatesCell.expLbl.text = [NSString stringWithFormat:@"%@ year/",exp];
            
            inviteCandidatesCell.distanceLbl.text = [NSString stringWithFormat:@"%@km",[[_allEmployeeArray valueForKey:@"distance"]objectAtIndex:indexPath.row]];
            
            NSString *rating = [[_hotEmployeeArray valueForKey:@"userRating"]objectAtIndex:indexPath.row];
            
            if ( rating != (NSString *)[NSNull null] )
            {
                rating = [rating substringToIndex:[rating length]-1];
                
                inviteCandidatesCell.ratingLbl.text = rating;
            }
            else{
                inviteCandidatesCell.ratingLbl.text = @"0.0";
            }
            
            NSString *url_Img = [[_hotEmployeeArray valueForKey:@"jobseeker_profile_pic"]objectAtIndex:indexPath.row];
            
            [inviteCandidatesCell.profilePic sd_setImageWithURL:[NSURL URLWithString:url_Img] placeholderImage:[UIImage imageNamed:@"plceholder"]];
            
            inviteCandidatesCell.addSelected.tag = indexPath.row;
            [ inviteCandidatesCell.addSelected addTarget:self action:@selector(hotEmployeeClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        return inviteCandidatesCell;
    }
    
    return nil;
}

#pragma mark - IBActions  -

- (IBAction)allBtnClicked:(id)sender {
    _allBtnArrowimg.hidden = NO;
    _favouriteBtnArrowimg.hidden = YES;
    all = YES;
    hot = NO;
     _availableCandidatesLbl.text = @"Available Candidates";
    if (invitedSelection.count==0) {
        BottomView.hidden = YES;
         _heightForAvailableTable.constant= (self.view.frame.size.height*318)/568;
    }
    [self allEmployeesList];
}


- (IBAction)favouriteBtnClicked:(id)sender{
    _allBtnArrowimg.hidden = YES;
    _favouriteBtnArrowimg.hidden = NO;
    hot = YES;
    all = NO;
     _availableCandidatesLbl.text = @"Favourite Candidates";
    
    [self employeesHotList];
}

- (IBAction)inviteCandidate:(id)sender {
    
    if (InvitedTotalPrice <=_TotalBalance) {
        [self inviteEmployees];
    }
    else{
        noBalance *noBalance = [self.storyboard instantiateViewControllerWithIdentifier:@"noBalance"];
        UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:noBalance];
        obj_nav.definesPresentationContext = YES;
        obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:obj_nav animated:YES completion:nil];
    }

}


-(void)allEmployeeAddClicked:(UIButton*)sender{
    if (invitedSelection.count==0) {
            BottomView.hidden = YES;
            _heightForAvailableTable.constant= (self.view.frame.size.height*318)/568;
        }
    if([[selectedAllUser objectAtIndex:sender.tag] isEqualToString:@"0"]){
    [selectedAllUser replaceObjectAtIndex:sender.tag withObject:@"1"];
    [invitedSelection addObject:[[_allEmployeeArray valueForKey:@"jobseekerId"]objectAtIndex:sender.tag]];
    BottomView.hidden = NO;
    InvitedTotalPrice = InvitedTotalPrice +_jobInvitationPrice;
    _heightForAvailableTable.constant= (self.view.frame.size.height*268)/568;
    }
   else{
    [selectedAllUser replaceObjectAtIndex:sender.tag withObject:@"0"];
    [invitedSelection removeObject:[[_allEmployeeArray valueForKey:@"jobseekerId"]objectAtIndex:sender.tag]];
       InvitedTotalPrice = InvitedTotalPrice- _jobInvitationPrice;
    }
    [_availableTableView reloadData];
}


-(void)hotEmployeeClicked:(UIButton*)sender{
    if (hotInvited.count==0) {
        BottomView.hidden = YES;
        _heightForAvailableTable.constant= (self.view.frame.size.height*318)/568;
    }
    if([[selectedFavaouriteUser objectAtIndex:sender.tag] isEqualToString:@"0"]){
        [selectedFavaouriteUser replaceObjectAtIndex:sender.tag withObject:@"1"];
        [hotInvited addObject:[[_hotEmployeeArray valueForKey:@"jobseekerId"]objectAtIndex:sender.tag]];
        BottomView.hidden = NO;
        _heightForAvailableTable.constant= (self.view.frame.size.height*268)/568;
        InvitedTotalPrice = InvitedTotalPrice +_jobInvitationFavouritePrice;
    }
    else{
        [selectedFavaouriteUser replaceObjectAtIndex:sender.tag withObject:@"0"];
         [hotInvited removeObject:[[_hotEmployeeArray valueForKey:@"jobseekerId"]objectAtIndex:sender.tag]];
        InvitedTotalPrice = InvitedTotalPrice -_jobInvitationFavouritePrice;
    }
    [_availableTableView reloadData];
}


#pragma mark - allEmployeesList -
-(void)allEmployeesList{
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    _allEmployeeArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    [_param setObject:@"allEmployeesList" forKey:@"methodName"];
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    
    [_param setObject:_jobId forKey:@"jobId"];
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [kAppDel.progressHud hideAnimated:YES];
        
        _allEmployeeArray = [responseObject valueForKey:@"data"];
        _availableTableView.delegate = self;
        _availableTableView.dataSource = self;
        if (selectedAllUser.count==0) {
            for (int i = 0; i<_allEmployeeArray.count; i++) {
                [selectedAllUser addObject:@"0"];
            }
        }
        [_availableTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];
    }];
}


#pragma mark - employeesHotList -
-(void)employeesHotList
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    _hotEmployeeArray = [[NSMutableArray alloc]init];
    
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    
    [_param setObject:@"employeesHotList" forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    
    [_param setObject:_jobId forKey:@"jobId"];
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [kAppDel.progressHud hideAnimated:YES];
    _hotEmployeeArray = [responseObject valueForKey:@"data"];
        _availableTableView.delegate = self;
        _availableTableView.dataSource = self;
        if (_hotEmployeeArray.count==0) {
            _availableCandidatesLbl.text = @"No Favourite Candidates Found";
        }
        if (selectedFavaouriteUser.count==0) {
            for (int i = 0; i<_hotEmployeeArray.count; i++) {
                [selectedFavaouriteUser addObject:@"0"];
            }
        }
        [_availableTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];
    }];
}


#pragma mark - inviteEmployees -
-(void)inviteEmployees
{
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    NSString *AllId,*Favouriteid;
    if (invitedSelection.count>0) {
    AllId= [invitedSelection  componentsJoinedByString:@","];
    }
    else if (hotInvited.count>0){
    Favouriteid = [hotInvited componentsJoinedByString:@","];
    }
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    [_param setObject:@"inviteEmployees" forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    
    [_param setObject:_jobId forKey:@"jobId"];
    
    if (AllId.length==0) {
        AllId = @"";
    }
    [_param setObject:AllId forKey:@"allIds"];
    
    if (Favouriteid.length==0) {
        Favouriteid = @"";
    }
    [_param setObject:Favouriteid forKey:@"favIds"];
    
[kAFClient POST:MAIN_URL parameters:_param  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    [kAppDel.progressHud hideAnimated:YES];
    for (int i =0; i<selectedAllUser.count; i++) {
        [selectedAllUser replaceObjectAtIndex:i withObject:@"0"];
    }
    for (int i = 0; i<selectedFavaouriteUser.count; i++) {
        [selectedFavaouriteUser replaceObjectAtIndex:i withObject:@"0"];
    }
    if ([[responseObject valueForKey:@"status"]isEqual:@1]) {
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Success" Message:[responseObject valueForKey:@"message"] AlertMessage:@"OK"] animated:YES completion:nil];
    }
    BottomView.hidden = YES;
    _heightForAvailableTable.constant= (self.view.frame.size.height*318)/568;
    [invitedSelection removeAllObjects];
    [hotInvited removeAllObjects];
    [_availableTableView reloadData];
    
    _TotalBalance = _TotalBalance - _jobInvitationPrice;
    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
    for (int i =0; i<selectedAllUser.count; i++) {
        [selectedAllUser replaceObjectAtIndex:i withObject:@"0"];
    }for (int i = 0; i<selectedFavaouriteUser.count; i++) {
        [selectedFavaouriteUser replaceObjectAtIndex:i withObject:@"0"];
    }
    [invitedSelection removeAllObjects];
    [hotInvited removeAllObjects];
    [_availableTableView reloadData];
    [kAppDel.progressHud hideAnimated:YES];
}];
}
@end
