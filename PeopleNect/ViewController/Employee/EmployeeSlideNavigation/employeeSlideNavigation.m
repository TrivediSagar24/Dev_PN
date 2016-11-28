//
//  employeeSlideNavigation.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/11/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeSlideNavigation.h"
#import "UserSettingCell.h"
static int count = 0;
static int employerCount = 0;
@interface employeeSlideNavigation ()
{
    NSArray *settings,*EmployerSettings;
    UILabel *labelBorderEmployer;
    UIView *findOutProfessional,*postNewJob,*openJobView,*logOut;
    UIImageView *professionalImageVw, *postImageVw , *openJobImageVw,*logOutVw;
    UILabel *professionalLbl, *postLbl , *openJobLbl, *logOutLbl;
    NSString*EmployeeUserID, *EmployerUserID;
    UITapGestureRecognizer *findOutProfessionalGesture,*postGesture,*openJobGesture,*logOutGesture;
    
    //// Employee......
    NSData *employeeUserDetailData;
    UIImage *chosenImage;
    UITapGestureRecognizer *tapGesture;
    UIImagePickerController  *imagePicker;
}
@end
@implementation employeeSlideNavigation

#pragma mark - View Life Cycle -
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.slideOutAnimationEnabled = YES;
    return [super initWithCoder:aDecoder];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [GlobalMethods dataTaskCancel];
    self.slideOutAnimationEnabled = YES;
    
    _ProfileImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnCameraClicked:)];
    
    [_ProfileImage addGestureRecognizer:tapGesture];
    
    EmployeeUserID = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"];
    
    /*
    if (EmployeeUserID.length>0) {
         settings = @[@"Pending invitation", @"On going jobs",@"Job History", @"Settings",@"Availability",@"Revenues",@"Invite Friends"];
   }
     if (EmployeeUserID.length==0){
        [self EmployerSlideDidLoad];
    }
     
     */
    _ProfileImage.layer.cornerRadius = kDEV_PROPROTIONAL_Height(96)/2;
    _ProfileImage.layer.masksToBounds = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    employeeUserDetailData= [[NSUserDefaults standardUserDefaults] objectForKey:@"employeeUserDetail"];
    if (employeeUserDetailData!=nil) {
        kAppDel.obj_responseEmployeeUserDetail = [NSKeyedUnarchiver unarchiveObjectWithData:employeeUserDetailData];
    }
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        if (!(EmployeeUserID.length==0)) {
             settings = @[@"Pending invitation", @"On going jobs",@"Job History", @"Settings",@"Availability",@"Revenues",@"Invite Friends"];
            
            [self EmployeeWillAppear];
        }
        else{
            
            [self EmployerSlideDidLoad];
            [self unarchivingData];
            [self EmployerWillApper];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
        if (!(EmployeeUserID.length==0)) {
            settings = @[@"Pending invitation", @"On going jobs",@"Job History", @"Settings",@"Availability",@"Revenues",@"Invite Friends"];
            
            [self EmployeeWillAppear];
        }
        else{
            
            [self EmployerSlideDidLoad];
            [self unarchivingData];
            [self EmployerWillApper];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
        if (!(EmployeeUserID.length==0)) {
            settings = @[@"Pending invitation", @"On going jobs",@"Job History", @"Settings",@"Availability",@"Revenues",@"Invite Friends"];
            
            [self EmployeeWillAppear];
        }
        else{
            
            [self EmployerSlideDidLoad];
            [self unarchivingData];
            [self EmployerWillApper];
        }
    }];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   
    _rightButtonTrailing.constant = (self.view.frame.size.width*90)/414 ;
    _imageTrailing.constant = (self.view.frame.size.width *79)/414;
}

-(void)viewDidLayoutSubviews
{
    if (EmployeeUserID.length==0) {
        [self employerLayoutSubView];
    }
}


#pragma mark - IBAction Cycle -
/*-----Employee Logout -----------------*/
- (IBAction)ExitClicked:(id)sender
{
    [[GPPSignIn sharedInstance] signOut];
    
    kAppDel.obj_reponseGmailFacebookLogin = [[reponseGmailFacebookLogin alloc]initWithDictionary:nil];
    
    kAppDel.obj_responseEmployeeUserDetail  = [[responseEmployeeUserDetail alloc]initWithDictionary:nil];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EmployeeUserId"];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EmployeePassword"];

    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Category_id"];
   
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Setting"];
   
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EmployeeCategory"];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"FinalRegisteredEmployee"];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Available"];

    /*-----employeeRegisterSocial------- */
    
    kAppDel.obj_reponseGmailFacebookLogin = [[reponseGmailFacebookLogin alloc]initWithDictionary:nil];
    
    NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_reponseGmailFacebookLogin];
    
    [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"employeeRegisterSocial"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    kAppDel.obj_responseRegiserEmployee = [[responseRegiserEmployee alloc]initWithDictionary:nil];
    
    /*-------employeeRegister----*/
    
    NSData *registerResponse =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_responseRegiserEmployee];
    
    [[NSUserDefaults standardUserDefaults] setObject:registerResponse forKey:@"employeeRegister"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    /*-------employeeUSerDetail----*/

   
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"employeeUserDetail"];
    
    
    [FBSDKAccessToken setCurrentAccessToken:nil];
    kAppDel.EmployeeProfileImage = nil;
    
    
//    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
//    NSDictionary * dict = [defs dictionaryRepresentation];
//    for (id key in dict) {
//        [defs removeObjectForKey:key];
//    }
//    [defs synchronize];
    
//    [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
    
    ViewController *obj_ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [[SlideNavigationController sharedInstance]popAllAndSwitchToViewController:obj_ViewController withCompletion:nil];
}


- (IBAction)RightNavigateClikced:(id)sender
{
           [[SlideNavigationController sharedInstance]closeMenuWithCompletion:nil];
}


- (IBAction)SearchJobClicked:(id)sender
{
    count = 0;
 employeeJobNotification  *employeeJobNotification = [self.storyboard instantiateViewControllerWithIdentifier: @"employeeJobNotification"];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:employeeJobNotification
//    withSlideOutAnimation:NO andCompletion:nil];
//    });
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:employeeJobNotification
                                                                 withSlideOutAnimation:NO andCompletion:nil];
    
}

- (IBAction)btnCameraClicked:(id)sender
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate =self;
    imagePicker.allowsEditing = YES;
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select One" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                            {
                                [self dismissViewControllerAnimated:YES completion:^{
                                }];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                {
                                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                    
//                                    [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
                                    [self presentViewController:imagePicker animated:YES completion:nil];
                                }
                                else
                                {
                                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Camera Missing" Message:@"It seems that no camera is attached to this device" AlertMessage:@"OK"]animated:YES completion:nil];
                                }
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                               
                                //[self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
                                
                                [self presentViewController:imagePicker animated:YES completion:nil];
                                
                            }]];
    
    [self.view.window.rootViewController presentViewController:actionSheet animated:YES completion:nil];

}

#pragma mark - ImagePicker Delegates.

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    chosenImage = info[UIImagePickerControllerEditedImage];
    
    _ProfileImage.image = chosenImage;
    kAppDel.EmployeeProfileImage = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table View Delegates and DataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (EmployeeUserID.length>0){
        return settings.count;
    }
    else
    return EmployerSettings.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserSettingCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"UserSettingCell"];
    if (EmployeeUserID.length>0){
         Cell.SettingTypelbl.text = [settings objectAtIndex:indexPath.row];
        if (indexPath.row==0) {
//            Cell.userSettingsBadge.hidden = NO;
        }
        else if (indexPath.row==1){
//            Cell.userSettingsBadge.hidden = NO;
        }
    }
   else
    Cell.SettingTypelbl.text = [EmployerSettings objectAtIndex:indexPath.row];
    
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (EmployeeUserID.length>0) {
        if (indexPath.row==0)
        {
            count = 4;
            employeePendingInvitation *employeePendingInvitation = [self.storyboard instantiateViewControllerWithIdentifier:@"employeePendingInvitation"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:employeePendingInvitation withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
        }
        if (indexPath.row==1) {
            
            onGoingJobs *onGoingJobs = [self.storyboard instantiateViewControllerWithIdentifier:@"onGoingJobs"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:onGoingJobs withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
        }
        if (indexPath.row==2)
        {
            count = 1;
            employeeJobHistory *employeeJobHistory = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeJobHistory"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:employeeJobHistory withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
        }
        if (indexPath.row == 3 )
        {
            count = 2;
            EmployeeSettings  *EmployeeSettings = [self.storyboard instantiateViewControllerWithIdentifier: @"EmployeeSettings"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:EmployeeSettings
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
        if (indexPath.row==4) {
            
            [[NSUserDefaults standardUserDefaults ]setObject:@"Slider" forKey:@"Available"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            employeeJobNotification  *employeeJobNotification = [self.storyboard instantiateViewControllerWithIdentifier: @"employeeJobNotification"];
            
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:employeeJobNotification
                                                                         withSlideOutAnimation:NO andCompletion:nil];
            
        }
        if (indexPath.row == 5 )
        {
            count = 3;
            employeeRevenues  *employeeRevenues = [self.storyboard instantiateViewControllerWithIdentifier: @"employeeRevenues"];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:employeeRevenues
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
        if (indexPath.row==6)
        {
            NSString *textToShare =  @"Look at this awesome PeopleNect App for aspiring Job!";
            
            NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
            
            NSArray *objectsToShare = @[textToShare, myWebsite];
            
            UIActivityViewController *Invite = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
            
            NSArray *excludeActivities =
            @[UIActivityTypeAirDrop,UIActivityTypePrint,UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo];
            
            Invite.excludedActivityTypes = excludeActivities;
            
            [self.view.window.rootViewController presentViewController:Invite animated:YES completion:nil];
        }
    }
    else if (EmployeeUserID.length==0)
    {
        if (indexPath.row == 0){
            employerCount = 4;
            [[NSUserDefaults standardUserDefaults ]setObject:@"Slider" forKey:@"Transaction"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            employerTransaction *obj_employerTransaction = [self.storyboard instantiateViewControllerWithIdentifier:@"employerTransaction"];
            
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj_employerTransaction
        withSlideOutAnimation:self.slideOutAnimationEnabled
    andCompletion:nil];
            
        }
    if (indexPath.row==1) {
        employerCount=5;
        EmployerJobHistory *EmployerJobHistory = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployerJobHistory"];

        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:EmployerJobHistory withSlideOutAnimation:self.slideOutAnimationEnabled andCompletion:nil];
    }
    if (indexPath.row==2) {
        employerCount=6;
        employerSettings *obj_employerSettings = [self.storyboard instantiateViewControllerWithIdentifier:@"employerSettings"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj_employerSettings
            withSlideOutAnimation:self.slideOutAnimationEnabled
            andCompletion:nil];
    }
    if (indexPath.row==3)
    {
        NSString *textToShare = @"Look at this awesome PeopleNect App for aspiring Job!";
        
        NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
        
        NSArray *objectsToShare = @[textToShare, myWebsite];
        
        UIActivityViewController *Invite = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
        
        NSArray *excludeActivities =
        @[UIActivityTypeAirDrop,UIActivityTypePrint,UIActivityTypeAssignToContact,
          UIActivityTypeSaveToCameraRoll,
          UIActivityTypeAddToReadingList,
          UIActivityTypePostToFlickr,
          UIActivityTypePostToVimeo];
        
        Invite.excludedActivityTypes = excludeActivities;
        
        [self.view.window.rootViewController presentViewController:Invite animated:YES completion:nil];
    }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE_4)
    {
        if ([[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"].length>0) {
                 return 45.0;
    }
        else
        return 45.0;
    }
    else
       return 55.0;
}


#pragma mark - JobSeeker Slide navigation -
-(void)EmployeeWillAppear
{
    if (kAppDel.EmployeeProfileImage==nil) {
        _ProfileImage.image = [UIImage imageNamed:@"plceholder"];
    }
    else{
        _ProfileImage.image = kAppDel.EmployeeProfileImage;
    }
    
    _lblUserName.text = [NSString stringWithFormat:@"%@ %@",kAppDel.obj_responseEmployeeUserDetail.Employee_first_name, kAppDel.obj_responseEmployeeUserDetail.Employee_last_name];
    _lblUserExperience.text =[NSString stringWithFormat:@"%@ Years of experience",[kAppDel.obj_responseEmployeeUserDetail.Employee_exp_years stringByReplacingOccurrencesOfString:@".00" withString:@""]];
    _lblUserCategory.text = kAppDel.obj_responseEmployeeUserDetail.Employee_category_name;
}

-(void)EmployeeRightNavigation
{
    if (count ==0)
    {
        employeeJobNotification  *employeeJobNotification = [self.storyboard instantiateViewControllerWithIdentifier: @"employeeJobNotification"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:employeeJobNotification
                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
    }
    if (count ==1)
    {
        employeeJobHistory  *employeeJobHistory = [self.storyboard instantiateViewControllerWithIdentifier: @"employeeJobHistory"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:employeeJobHistory withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
    }
    else if (count==2)
    {
        EmployeeSettings  *EmployeeSettings = [self.storyboard instantiateViewControllerWithIdentifier: @"EmployeeSettings"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:EmployeeSettings withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
    }
    if (count ==3)
    {
        employeeRevenues  *employeeRevenues = [self.storyboard instantiateViewControllerWithIdentifier: @"employeeRevenues"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:employeeRevenues
                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
    }
    if (count==4) {
        employeePendingInvitation  *employeePendingInvitation = [self.storyboard instantiateViewControllerWithIdentifier: @"employeePendingInvitation"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:employeePendingInvitation
                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
    }
}
#pragma mark - EmployerSlide -
-(void)EmployerSlideDidLoad{
    EmployerSettings = @[@"Balance", @"Job History", @"Settings",@"Invite Friends"];
    _lblUserCategory.hidden = YES;
    _lblUserExperience.hidden = YES;
    _searchView.hidden = YES;
    _LableBorder.hidden = YES;
    _ExitView.hidden = YES;
    _BotomView.hidden = YES;
    labelBorderEmployer = [[UILabel alloc]init];
    labelBorderEmployer.backgroundColor = _LableBorder.backgroundColor;
    labelBorderEmployer.text = _LableBorder.text;
    [self.view addSubview:labelBorderEmployer];
    findOutProfessional = [[UIView alloc]init];
    professionalImageVw = [[UIImageView alloc]init];
    professionalImageVw.image = [UIImage imageNamed:@"search_location"];
    professionalLbl = [[UILabel alloc]init];
    professionalLbl.text = @"Find out professionals";
    findOutProfessional.userInteractionEnabled = YES;
    findOutProfessionalGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(findOutProfessionalClicked)];
    [findOutProfessional addGestureRecognizer:findOutProfessionalGesture];
    [self label:professionalLbl];
    [findOutProfessional addSubview:professionalLbl];
    [findOutProfessional addSubview:professionalImageVw];
    [self.view addSubview:findOutProfessional];
    
    postNewJob  =  [[UIView alloc]init];
    postImageVw = [[UIImageView alloc]init];
    postImageVw.image = [UIImage imageNamed:@"post_new_job"];
    postLbl = [[UILabel alloc]init];
    postLbl.text = @"Post new job";
    
    postNewJob.userInteractionEnabled = YES;
    postGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(postNewJobClicked)];
    [postNewJob addGestureRecognizer:postGesture];
    
    
    [self label:postLbl];
    [postNewJob addSubview:postLbl];
    [postNewJob addSubview:postImageVw];
    [self.view addSubview:postNewJob];
    
    
    openJobView  =  [[UIView alloc]init];
    openJobImageVw = [[UIImageView alloc]init];
    openJobImageVw.image = [UIImage imageNamed:@"Open_jobs"];
    openJobLbl = [[UILabel alloc]init];
    openJobLbl.text = @"Current jobs";
    
    openJobView.userInteractionEnabled = YES;
    openJobGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(openJobClicked)];
    [openJobView addGestureRecognizer:openJobGesture];
    
    [self label:openJobLbl];
    [openJobView addSubview:openJobLbl];
    [openJobView addSubview:openJobImageVw];
    [self.view addSubview:openJobView];
    
    logOut  =  [[UIView alloc]init];
    logOutVw = [[UIImageView alloc]init];
    logOutVw.image = [UIImage imageNamed:@"extit"];
    logOutLbl = [[UILabel alloc]init];
    logOutLbl.text = @"Log out";
    logOut.userInteractionEnabled = YES;
    logOutGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(logOutClicked)];
    [logOut addGestureRecognizer:logOutGesture];
    [self label:logOutLbl];
    [logOut addSubview:logOutLbl];
    [logOut addSubview:logOutVw];
    [self.view addSubview:logOut];
}



-(void)EmployerWillApper
{
    if (kAppDel.EmployerProfileImage==nil) {
        _ProfileImage.image = [UIImage imageNamed:@"profile"];
    }
    else{
    _ProfileImage.image = kAppDel.EmployerProfileImage;
    }
    _lblUserName.text = [NSString stringWithFormat:@"%@ %@",kAppDel.obj_responseDataOC.employerName, kAppDel.obj_responseDataOC.employerSurname];
}

-(void)label:(UILabel*)label
{
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
}


-(void)employerLayoutSubView
{
    labelBorderEmployer.frame =CGRectMake(_LableBorder.frame.origin.x, _lblUserName.frame.origin.y+_lblUserName.frame.size.height+20, _LableBorder.frame.size.width, _LableBorder.frame.size.height);
    
    float  topHeight =  (self.view.frame.size.height * 15)/568;
    float viewHeight = (self.view.frame.size.height * 17)/568;
    
    findOutProfessional.frame = CGRectMake(_ProfileImage.frame.origin.x/2, labelBorderEmployer.frame.origin.y+labelBorderEmployer.frame.size.height+topHeight, 174, viewHeight);
    
    professionalImageVw.frame = CGRectMake(0, 0, 15, 15);
    
    professionalLbl.frame = CGRectMake(20, 0, 154, 15);
    
    postNewJob.frame = CGRectMake(findOutProfessional.frame.origin.x, findOutProfessional.frame.origin.y+findOutProfessional.frame.size.height +topHeight, findOutProfessional.frame.size.width, findOutProfessional.frame.size.height);
    
    postImageVw.frame = CGRectMake(0, 0, 15, 15);
    postLbl.frame = CGRectMake(20, 0, 154, 15);
    
    
    openJobView.frame = CGRectMake(postNewJob.frame.origin.x, postNewJob.frame.origin.y+postNewJob.frame.size.height + topHeight, postNewJob.frame.size.width, postNewJob.frame.size.height);
    
    openJobImageVw.frame = CGRectMake(0, 0, 15, 15);
    openJobLbl.frame = CGRectMake(20, 0, 154, 15);
    
    _MiddleView.frame  = CGRectMake(_MiddleView.frame.origin.x, openJobView.frame.origin.y+openJobView.frame.size.height + topHeight, _MiddleView.frame.size.width, _BotomView.frame.origin.y-openJobView.frame.origin.y+openJobView.frame.size.height + 15);
    
    _userSettingTable.frame = CGRectMake(_userSettingTable.frame.origin.x, _userSettingTable.frame.origin.y, _userSettingTable.frame.size.width, _MiddleView.frame.size.height);
    
    logOut.frame = CGRectMake(findOutProfessional.center.x/2, _BotomView.frame.origin.y+10, 100, openJobView.frame.size.height);
    
    logOutVw.frame = CGRectMake(0, 0, 15, 15);
    logOutLbl.frame = CGRectMake(20, 0, 154, 15);
}
-(void)EmployerRightNavigation
{
    if (employerCount==0) {
        MenuCtr  *MenuCtr = [self.storyboard instantiateViewControllerWithIdentifier: @"MenuCtr"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:MenuCtr
         withSlideOutAnimation:self.slideOutAnimationEnabled
        andCompletion:nil];
    }
    if (employerCount==1) {
        MenuCtr  *MenuCtr = [self.storyboard instantiateViewControllerWithIdentifier: @"MenuCtr"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:MenuCtr
                                                    withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];

    }
    if (employerCount==2) {
        NSLog(@" Put Screen of postNewJob");
    }
    if (employerCount==3) {
        NSLog(@" Put Screen of openJob");
    }
    if (employerCount == 4){
        NSLog(@"Put Screen of Transaction");
    }
 if (employerCount == 5){
     NSLog(@"Put Screen of job History");
 }
    if (employerCount == 6){
     NSLog(@"Put Screen of Employer Settings")
        ;
    }
}


#pragma mark - Employer data -
-(void)unarchivingData{
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Update"]isEqualToString:@"Login"])
    {
        NSData *loginData= [[NSUserDefaults standardUserDefaults] objectForKey:@"employerLogin"];
        if (loginData!=nil) {
            kAppDel.obj_responseDataOC = [NSKeyedUnarchiver unarchiveObjectWithData:loginData];
        }
    }
    else{
        NSData *registerData= [[NSUserDefaults standardUserDefaults] objectForKey:@"employerRegister"];
        if (registerData!=nil) {
             kAppDel.obj_responseDataOC = [NSKeyedUnarchiver unarchiveObjectWithData:registerData];
        }
    }
}


#pragma mark - Employer IBActions-
-(void)findOutProfessionalClicked
{
    employerCount = 1;
    MenuCtr  *MenuCtr = [self.storyboard instantiateViewControllerWithIdentifier: @"MenuCtr"];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:MenuCtr
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
}
-(void)postNewJobClicked
{    employerCount = 2;

    [[NSUserDefaults standardUserDefaults ]setObject:@"Slider" forKey:@"PostJob"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    CategoryEmployeeCtr *obj_CategoryEmployeeCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj_CategoryEmployeeCtr
        withSlideOutAnimation:self.slideOutAnimationEnabled
        andCompletion:nil];
    
}
-(void)openJobClicked
{
    employerCount = 3;

    openJob *obj_openJob = [self.storyboard instantiateViewControllerWithIdentifier:@"openJob"];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj_openJob
    withSlideOutAnimation:self.slideOutAnimationEnabled
    andCompletion:nil];
    
}
-(void)logOutClicked
{
//    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
//    NSDictionary * dict = [defs dictionaryRepresentation];
//    for (id key in dict) {
//        [defs removeObjectForKey:key];
//    }
//    [defs synchronize];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EmployerUserID"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EmployerPassword"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"employerRegister"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"employerLogin"];
   
    kAppDel.EmployerProfileImage = nil;
    
    SplashEmployerCtr *obj_SplashEmployerCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"SplashEmployerCtr"];
    [[SlideNavigationController sharedInstance]popAllAndSwitchToViewController:obj_SplashEmployerCtr withCompletion:nil];
    
}
@end
