//
//  employeeJobNotification.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/9/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeJobNotification.h"
#import "CustomClusterIconGenerator.h"


@interface POIItem : NSObject<GMUClusterItem>

@property(nonatomic, readonly) CLLocationCoordinate2D position;
@property(nonatomic, readonly) NSString *name;

- (instancetype)initWithPosition:(CLLocationCoordinate2D)position name:(NSString *)name;

@end


@implementation POIItem

- (instancetype)initWithPosition:(CLLocationCoordinate2D)position name:(NSString *)name {
    if ((self = [super init])) {
        _position = position;
        _name = [name copy];
    }
    return self;
}

- (instancetype)initWithMapView:(GMSMapView *)mapView clusterIconGenerator:(id<GMUClusterIconGenerator>)iconGenerator
{
    if ((self = [super init])) {
        
        GMSMarker *marker= [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(24.0, 75.30)];
        
        UIView *customMarker =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 63, 40)];
        customMarker.backgroundColor = [UIColor blueColor];
        marker.iconView = customMarker;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = mapView;
    }
    return self;
}


@end


static int count = 0;
static CLLocationCoordinate2D currentLocation;
static NSInteger currentSelection,selected=-1;
@interface employeeJobNotification ()
{
NSMutableArray *latitude,*longitude,*responseSelectedAvailibility,*endTimeFrames ,*startTimeFrames,*selectedFollowUp,*selectedWeekAvailibility;
GMSMarker *markerUserLocation;
int check;
NSArray *WeekDays,*progreeWeekDays;
NSString *selectedWeekDays,*startTime ,*endTime;
CERangeSlider* _rangeSlider;
UILabel * StatTimelbl,*endTimelbl;
NSInteger cellSelected;
NSString *BoolSelectedSwitch;
NSData *employeeUserDetailData;
CGRect sliderFrame;
    GMUClusterManager *_clusterManager;
}

@end

@implementation employeeJobNotification

#pragma mark - View Life Cycle -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initialWeek];
    
    markerUserLocation = [[GMSMarker alloc]init];
    
    _mapView.indoorEnabled = NO;

    [self showCurrentLocation];

   // currentLocation = CLLocationCoordinate2DMake(23.0813, 72.5269);
    
    _TurnOnLable.hidden = YES;
    
    _mapView.delegate = self;

       // [self areaWiseJob];
    
    
    _totalVisibleJobs = [[NSMutableArray alloc]init];
    
    id<GMUClusterAlgorithm> algorithm = [[GMUNonHierarchicalDistanceBasedAlgorithm alloc] init];
    
    CustomClusterIconGenerator *iconGenerator = [[CustomClusterIconGenerator alloc]init];
    
    
    id<GMUClusterRenderer> renderer =
    [[GMUDefaultClusterRenderer alloc] initWithMapView:_mapView
                                  clusterIconGenerator:iconGenerator];
    
    _clusterManager =
    [[GMUClusterManager alloc] initWithMap:_mapView algorithm:algorithm renderer:renderer];

    
    
    
        [self section];
        [self getUserAvailibility];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentLocation zoom:6];
        [_mapView setCamera:camera];
    
        _employeeWeekCollection.backgroundColor = [UIColor clearColor];
    
        employeeUserDetailData= [[NSUserDefaults standardUserDefaults] objectForKey:@"employeeUserDetail"];
   
    _viewAdvanceOptions.hidden = YES;
    _settingWeekView.hidden = NO;
    _settinOptionalView.hidden = YES;
    
    _EmployeeAvailabilityView.hidden = YES;
    
    
    _freeButton.hidden = YES;
    
//    _settingWeekView.hidden = YES;
//    
//    _settinOptionalView.hidden = NO;
    
    _ProgressSaveEmployeeView.hidden = YES;
    
    if (employeeUserDetailData == nil) {
            [self EmployeeuserDetail];
        }
        else{
            
            if (employeeUserDetailData!=nil) {
                 kAppDel.obj_responseEmployeeUserDetail = [NSKeyedUnarchiver unarchiveObjectWithData:employeeUserDetailData];
            }
            
            NSData *LoginEmployee = [[NSUserDefaults standardUserDefaults]objectForKey:@"employeeRegisterSocial"];
            if (LoginEmployee!=nil) {
                kAppDel.obj_reponseGmailFacebookLogin = [NSKeyedUnarchiver unarchiveObjectWithData:LoginEmployee];
                kAppDel.EmployeeProfileImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:kAppDel.obj_reponseGmailFacebookLogin.Employee_jobseeker_profile_pic]]];
                
                 [[[SlideNavigationController sharedInstance ]profileImage]setImage:kAppDel.EmployeeProfileImage forState:UIControlStateNormal];
            }
        }
    kAppDel.subCategorymap = [[NSMutableArray alloc]init];
    
    _employeeWeekCollection.delegate = self;
    _employeeWeekCollection.dataSource= self;
    
    [self allJob];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:32.0/255.0 green:86.0/255.0 blue:136.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.rightBarButtonItem =  [self RightBarButton];
    
//    _EmployeeAvailabilityView.hidden  = NO;
//      _TopAvailabilityView.hidden = NO;
 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(defaultsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
//    
//    [[[SlideNavigationController sharedInstance ]profileImage]setImage:kAppDel.EmployeeProfileImage forState:UIControlStateNormal];
  
    [[SlideNavigationController sharedInstance ]setEnableSwipeGesture:NO];
}


- (void)defaultsChanged:(NSNotification *)notification {
  
    NSUserDefaults *defaults = (NSUserDefaults *)[notification object];
    
    if ([[defaults objectForKey:@"Location"] isEqualToString:@"changeLocation"]) {
        
    if ([[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] != nil) {
            
            currentLocation = CLLocationCoordinate2DMake([[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLat"]doubleValue], [[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLong"]doubleValue]);
        }
    }
    
//    [[NSUserDefaults standardUserDefaults ]setObject:@"available" forKey:@"Availability"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    if ([[defaults objectForKey:@"Availability"]isEqualToString:@"available"]){
        
        NSLog(@"Availability");
        
        BoolSelectedSwitch = [NSString stringWithFormat:@"%i",_switchSelected.selected];
        
        if ([BoolSelectedSwitch isEqualToString:@"1"]){
            self.EmployeeAvailabilityView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            [[SlideNavigationController sharedInstance ]setEnableSwipeGesture:NO];
            
            [self.view addSubview:self.EmployeeAvailabilityView];
            
            _EmployeeAvailabilityView.hidden = NO;
            _availableLbl.text = @"I am Available";
        }else{
//            BOOL doesContain = [self.view.subviews containsObject:self.EmployeeAvailabilityView];
//          
//            if (doesContain==YES) {
//                [[self.view.subviews objectAtIndex:(self.view.subviews.count - 1)]removeFromSuperview];
//            }else{
//                [self.view addSubview:self.EmployeeAvailabilityView];
//            }

            NSLog(@"Not Available");

            [[SlideNavigationController sharedInstance ]setEnableSwipeGesture:NO];
            
            [self.view addSubview:self.EmployeeAvailabilityView];
            _EmployeeAvailabilityView.hidden = NO;
            _availableLbl.text = @"I am Unavailable";
        }
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [GlobalMethods dataTaskCancel];
    [[SlideNavigationController sharedInstance ]setEnableSwipeGesture:YES];
    
    [[NSUserDefaults standardUserDefaults ]setObject:@"not available" forKey:@"Availability"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    self.TopFreelbl.constant = (self.view.frame.size.height*15)/568;
    self.bottomFreelbl.constant = (self.view.frame.size.height*16)/568;
    self.TopFreeView.constant = (self.view.frame.size.height*25)/568;
    _heightforTableCategoryView.constant = self.scrollView.frame.size.height - self.sectionView.frame.size.height;
    self.EmployeeAvailabilityView.frame  = self.view.frame;
     self.ProgressSaveEmployeeView.frame = self.view.frame;
    
//    self.FreeView.layer.borderWidth = 1.0;
//    self.FreeView.layer.borderColor = [UIColor colorWithRed:90.0/255.0 green:126.0/255.0 blue:164.0/255.0 alpha:1.0].CGColor;
    
    self.EmployeeAvailabilityView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.EmployeeAvailabilityView];
    
//    _TopAvailabilityView.hidden = YES;
    /*
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Available"]isEqualToString:@"Slider"]) {
        _EmployeeAvailabilityView.hidden  = NO;
    }else{
        _EmployeeAvailabilityView.hidden  = YES;
    }
     */
    
//    BoolSelectedSwitch = [NSString stringWithFormat:@"%i",_switchSelected.selected];
//    if ([BoolSelectedSwitch isEqualToString:@"1"]){
//        _availableLbl.text = @"I am Available";
//    }
//    if ([BoolSelectedSwitch isEqualToString:@"0"]){
//        _availableLbl.text = @"I am Unavailable";
//    }
    
    /*
    if (_switchSelected.selected) {
        _availableLbl.text = @"I am Available";
    }
    else{
        _availableLbl.text = @"I am Unavailable";
    }
     */
    
    [self ProgressSlider];
}


#pragma mark- IBAction -
- (IBAction)btnAllClikced:(id)sender
{
    [GlobalMethods dataTaskCancel];
    
    if (_btnAreaBorder.hidden==NO) {
        
        _btnAreaBorder.hidden = YES;
        _btnAllBorder.hidden = NO;
        [self allJob];
        [_btnInMyArea setTitleColor:[UIColor colorWithRed:142.0/255.0 green:142.0/255.0 blue:142.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btnAll setTitleColor:[UIColor colorWithRed:55.0/255.0 green:99.0/255.0 blue:145.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    
    if (count==0)
    {
       
        count = 1;
    }
}


- (IBAction)btnInMyAreaClicked:(id)sender
{
    [GlobalMethods dataTaskCancel];
    
    if (_btnAllBorder.hidden==NO) {
        _btnAreaBorder.hidden = NO;
        _btnAllBorder.hidden = YES;
        [self areaWiseJob];
        [_btnAll setTitleColor:[UIColor colorWithRed:142.0/255.0 green:142.0/255.0 blue:142.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btnInMyArea setTitleColor:[UIColor colorWithRed:55.0/255.0 green:99.0/255.0 blue:145.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    
    
    if (count==1)
    {
        
        count = 0;
    }
}


- (IBAction)advancedOptionClicked:(id)sender
{
    _settingWeekView.hidden = NO;
    _settinOptionalView.hidden = YES;
}


- (IBAction)freeButtonClicked:(id)sender
{
    _freeButton.selected = !_freeButton.selected;
    NSString *Str = [NSString stringWithFormat:@"%i",_freeButton.selected];
    if ([Str isEqualToString:@"1"])
    {
        _viewAdvanceOptions.hidden = NO;
    }
    if ([Str isEqualToString:@"0"])
    {
        _viewAdvanceOptions.hidden = YES;
        _settingWeekView.hidden = YES;
        _settinOptionalView.hidden = NO;
        _ProgressSaveEmployeeView.hidden = YES;
    }
}


- (IBAction)settingCloseClicked:(id)sender
{
//    _settinOptionalView.hidden = NO;
//    _settingWeekView.hidden = YES;
//    _ProgressSaveEmployeeView.hidden = YES;
    
    _viewAdvanceOptions.hidden = YES;
    _settingWeekView.hidden = NO;
    _settinOptionalView.hidden = YES;
    
    _EmployeeAvailabilityView.hidden = YES;
    
    _freeButton.hidden = YES;
    _ProgressSaveEmployeeView.hidden = YES;

    

}


- (IBAction)btnSaveProgressClicked:(id)sender
{
    _ProgressSaveEmployeeView.hidden = YES;
    
    employeeWeekCell * Cell = (employeeWeekCell*)[_employeeWeekCollection cellForItemAtIndexPath:[NSIndexPath indexPathForItem:cellSelected inSection:0]];
  
//    startTime =  [startTime stringByReplacingOccurrencesOfString:@".00" withString:@""];
    
    if (startTime.length==0) {
        startTime = @"0.00";
    }
    if (endTime.length==0) {
        endTime = @"24.00";
    }

//    Cell.lblStartTime.text = [startTime stringByReplacingOccurrencesOfString:@":00" withString:@""];
    
    Cell.lblStartTime.text = startTime;
    Cell.lblEndTime.text = endTime;
    
//    endTime = [endTime stringByReplacingOccurrencesOfString:@".00" withString:@""];
//    
//    Cell.lblEndTime.text = [endTime stringByReplacingOccurrencesOfString:@":00" withString:@""];
    
    //NSLog(@"Start time end time %@ %@",startTime, endTime);

    
  [self saveUserAvailability];
}

- (IBAction)changeLocationClicked:(id)sender
{
    employeeChangeLoc *obj_employeeChangeLoc = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeChangeLoc"];
   
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:obj_employeeChangeLoc];
    
    obj_nav.definesPresentationContext = YES;
    
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:obj_nav animated:YES completion:nil];
  
  /*
    
    employeeRatings *employeeRatings = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeRatings"];
    
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:employeeRatings];
    
    obj_nav.definesPresentationContext = YES;
    
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:obj_nav animated:YES completion:nil];
   */
    
    /*
    gotInvitation *gotInvitation = [self.storyboard instantiateViewControllerWithIdentifier:@"gotInvitation"];
    
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:gotInvitation];
    
    obj_nav.definesPresentationContext = YES;
    
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:obj_nav animated:YES completion:nil];
     */
}

-(void)chatClicked
{
    [[NSUserDefaults standardUserDefaults ]setObject:@"Employee" forKey:@"Chat"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
   
    employeeChat *obj_employeeChat = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeChat"];
    [self.navigationController pushViewController:obj_employeeChat animated:YES];
}

- (IBAction)closedAvailabilityClicked:(id)sender {
    _viewAdvanceOptions.hidden = YES;
    _settingWeekView.hidden = NO;
    _settinOptionalView.hidden = YES;
    
    _EmployeeAvailabilityView.hidden = YES;
    
    _freeButton.hidden = YES;
    _ProgressSaveEmployeeView.hidden = YES;

}

-(void)switchedClicked
{
//    [[NSUserDefaults standardUserDefaults ]setObject:@"SwitchClicked" forKey:@"Available"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
    _switchSelected.selected = !_switchSelected.selected;
   BoolSelectedSwitch = [NSString stringWithFormat:@"%i",_switchSelected.selected];
    if ([BoolSelectedSwitch isEqualToString:@"1"])
    {
//    self.FreeView.layer.borderWidth = 1.0;
        
//    self.FreeView.layer.borderColor = [UIColor colorWithRed:90.0/255.0 green:126.0/255.0 blue:164.0/255.0 alpha:1.0].CGColor;
//        
    self.EmployeeAvailabilityView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [[SlideNavigationController sharedInstance ]setEnableSwipeGesture:NO];
        
        
        
        BOOL doesContain = [self.view.subviews containsObject:self.EmployeeAvailabilityView];
        
        if (doesContain==YES) {
            //[[self.view.subviews objectAtIndex:(self.view.subviews.count - 1)]removeFromSuperview];
        }else{
            [self.view addSubview:self.EmployeeAvailabilityView];
        }
        
        _EmployeeAvailabilityView.hidden = NO;
        _availableLbl.text = @"I am Available";
    }
    if ([BoolSelectedSwitch isEqualToString:@"0"])
    {
        BOOL doesContain = [self.view.subviews containsObject:self.EmployeeAvailabilityView];
        
        if (doesContain==YES) {
            //[[self.view.subviews objectAtIndex:(self.view.subviews.count - 1)]removeFromSuperview];
        }else{
            [self.view addSubview:self.EmployeeAvailabilityView];
        }
    [[SlideNavigationController sharedInstance ]setEnableSwipeGesture:YES];
        _availableLbl.text = @"I am Unavailable";

    }
}


#pragma mark- TableView Delegates and Datasource -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_totalVisibleJobs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchTableViewCell *mapCell = [tableView dequeueReusableCellWithIdentifier:@"searchTableViewCell"];
    if ([[selectedFollowUp objectAtIndex:indexPath.row]isEqualToString:@"1"]){
        
        [self labelChangeColor:mapCell Color:[UIColor purpleColor]];
        
        mapCell.mapImage.image = [UIImage imageNamed:@"maPurple"];
        
        mapCell.middleMapImage.image = [UIImage imageNamed:@"maPurple"];
        
        if ([mapCell.btnCanditatureClicked.titleLabel.text isEqualToString:@"Apply"]) {
             [mapCell.btnCanditatureClicked setTitle:@"Already Applied" forState:UIControlStateNormal];
        }
    }
    else{
        if ([[[_totalVisibleJobs valueForKey:@"applicationStatus"] objectAtIndex:indexPath.row] isEqual:@0]) {
        [mapCell.btnCanditatureClicked setTitle:@"Apply" forState:UIControlStateNormal];
        }
        if ([[[_totalVisibleJobs valueForKey:@"applicationStatus"] objectAtIndex:indexPath.row] isEqual:@1]) {
        [mapCell.btnCanditatureClicked setTitle:@"Follow up" forState:UIControlStateNormal];
        }
        if ([[[_totalVisibleJobs valueForKey:@"userInvitedStatus"]objectAtIndex:indexPath.row]isEqual:@1]) {
             [mapCell.btnCanditatureClicked setTitle:@"Already invited" forState:UIControlStateNormal];
        }
        if ([[[_totalVisibleJobs valueForKey:@"userSelectedStatus"]objectAtIndex:indexPath.row] isEqual:@1] && [[[_totalVisibleJobs valueForKey:@"userInvitedStatus"] objectAtIndex:indexPath.row]isEqual:@0]) {
            
            [self labelChangeColor:mapCell Color:[UIColor greenColor]];
            
            mapCell.mapImage.image = [UIImage imageNamed:@"map_green_"];
            mapCell.middleMapImage.image = [UIImage imageNamed:@"map_green_"];
        }
        if ([[[_totalVisibleJobs valueForKey:@"userSelectedStatus"]objectAtIndex:indexPath.row] isEqual:@0] && [[[_totalVisibleJobs valueForKey:@"userInvitedStatus"] objectAtIndex:indexPath.row]isEqual:@0]){
            
            [self labelChangeColor:mapCell Color:[UIColor colorWithRed:32.0/255.0 green:88.0/255.0 blue:140.0/255.0 alpha:1.0]];
            
            mapCell.mapImage.image = [UIImage imageNamed:@"map_"];
            mapCell.middleMapImage.image = [UIImage imageNamed:@"map_"];
        }
        if ([[[_totalVisibleJobs valueForKey:@"userInvitedStatus"]objectAtIndex:indexPath.row] isEqual:@1] || [[[_totalVisibleJobs valueForKey:@"applicationStatus"]objectAtIndex:indexPath.row]isEqual:@1]) {
            
            [self labelChangeColor:mapCell Color:[UIColor purpleColor]];
            mapCell.mapImage.image = [UIImage imageNamed:@"maPurple"];
            mapCell.middleMapImage.image = [UIImage imageNamed:@"maPurple"];
        }
    }
    mapCell.btnCanditatureClicked.tag = indexPath.row;
    
    [ mapCell.btnCanditatureClicked addTarget:self action:@selector(ApplyForJob:) forControlEvents:UIControlEventTouchUpInside];
    
    mapCell.lblJobTitle.text = [[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"jobTitle"];
    
    mapCell.middleViewCompanyName.text = [[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"companyName"];
    
    mapCell.lblCompanyName.text = [[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"companyName"];
    
    mapCell.lblKM.text = [NSString stringWithFormat:@"%@km",[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"distance"]];
    
    mapCell.middleViewLBLKM.text = [NSString stringWithFormat:@"%@ km",[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"distance"]];
    
    mapCell.lblRatings.text = [[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"rating"];
    
  mapCell.middleStartDate.text = [self dateToFormatedDate:[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"start_date"]];
    
    mapCell.lblSecondJobDescription.text = [[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"jobDescription"];
   
    [self label:mapCell.lblPricetag];
    
    mapCell.lblPricetag.text =  [NSString stringWithFormat:@"$%@ \n/hr",[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"hours_per_day"]];
    
    [self label:mapCell.lblSecondPricetag];
    
    mapCell.lblSecondPricetag.text = [NSString stringWithFormat:@"%@ at %@ \n | \n %@ at %@ ",[self dateToFormatedDate:[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"start_date"]],[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"hours_per_day"],[self dateToFormatedDate:[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"end_date"]],[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"hours_per_day"]];
    
    mapCell.lblStartDate.text = [self dateToFormatedDate:[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"start_date"]];
    
    mapCell.lblthirdPricetag.text = @"Only Working days";
    
    [self label:mapCell.lblthirdPricetag];
    
    if (currentSelection == indexPath.row)
    {
        NSString * totalHour = [[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"total_hours"];
        totalHour = [totalHour stringByReplacingOccurrencesOfString:@".00" withString:@" h"];
        
        [self label:mapCell.lblPricetag];
        
         mapCell.lblPricetag.text = [NSString stringWithFormat:@"Total Hours\n%@",totalHour];
        
        mapCell.middleView.hidden = NO;
        
        mapCell.bottomView.hidden = NO;
        
        mapCell.lblKM.hidden = YES;
        
        mapCell.mapImage.hidden = YES;
        
        mapCell.lblCompanyName.hidden = YES;
        
        mapCell.lblStartDate.hidden = YES;
        
        mapCell.lblBlueBorder.hidden = YES;

        if (indexPath.row == [_totalVisibleJobs count]-1) {
            
            mapCell.BorderLblStraight.hidden = YES;
            
            mapCell.BorderLblStraightSelected.hidden = YES;
            
            mapCell.toplLblStraight.hidden = YES;
        }
        else{
            mapCell.BorderLblStraight.hidden = YES;
            
            mapCell.BorderLblStraightSelected.hidden = NO;
            
            mapCell.toplLblStraight.hidden = NO;
        }
        
    [mapCell.ExpandCellClidked setImage:[UIImage imageNamed:@"Rarrow"] forState:UIControlStateNormal];
        
        return mapCell;
    }
    else
    [mapCell.ExpandCellClidked setImage:[UIImage imageNamed:@"down_arrow_"] forState:UIControlStateNormal];
    
        mapCell.middleView.hidden = YES;
    
        mapCell.bottomView.hidden = YES;
    
    mapCell.mapImage.hidden = NO;
    mapCell.lblCompanyName.hidden = NO;
    mapCell.lblStartDate.hidden = NO;
    
    mapCell.lblBlueBorder.hidden = NO;
    
    if (indexPath.row == [_totalVisibleJobs count]-1) {
       
        mapCell.BorderLblStraight.hidden = YES;
        
        mapCell.BorderLblStraightSelected.hidden = YES;
        
        mapCell.toplLblStraight.hidden = YES;
    }
    else{
        mapCell.BorderLblStraight.hidden = NO;
        
        mapCell.BorderLblStraightSelected.hidden = YES;
        
        mapCell.toplLblStraight.hidden = NO;

    }
    
    return mapCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentSelection == indexPath.row)
    {
        return  290;
    }
    else
        return 80;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [kAppDel.subCategorymap removeAllObjects];
    
    kAppDel.subCategorymap  = [[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"category"];
    
    kAppDel.userSelectedStatus = [NSString stringWithFormat:@"%@",[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"userSelectedStatus"]];
    
    kAppDel.userInvitedStatus = [NSString stringWithFormat:@"%@",[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"userInvitedStatus"]];
    
    kAppDel.applicationStatus = [NSString stringWithFormat:@"%@",[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"applicationStatus"]];

    NSString *str=[[_totalVisibleJobs objectAtIndex:indexPath.row]valueForKey:@"category"];
    
    kAppDel.subCategorymap = [[NSMutableArray alloc] initWithArray:[str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]]];
    
    selected = indexPath.row;
    
    [_mapView clear];
    
    [self mapMarker];
    
    currentSelection = indexPath.row;
    
    for(int i = 0;i<[_totalVisibleJobs count]; i++)
    {
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    //NSLog(@"Did Select");
}


-(void)ApplyForJob:(UIButton*)sender
{
    kAppDel.SelectedFollowUp = @"0";
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"reload"];
    
    if ([sender.titleLabel.text isEqualToString:@"Follow up"]) {
        
        [self applyFollowJob:@"followUp" jobId:[[_totalVisibleJobs valueForKey:@"jobId"] objectAtIndex:sender.tag] SenderButton:sender];

    }
    if ([sender.titleLabel.text isEqualToString:@"Apply"]) {
        [self applyFollowJob:@"applyForJob" jobId:[[_totalVisibleJobs valueForKey:@"jobId"] objectAtIndex:sender.tag] SenderButton:sender];

    }
   
    if ([sender.titleLabel.text isEqualToString:@"Already Applied"]) {
        
    [self applyFollowJob:@"followUp" jobId:[[_totalVisibleJobs valueForKey:@"jobId"] objectAtIndex:sender.tag] SenderButton:sender];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"Already invited"]) {
        
        [self applyFollowJob:@"followUp" jobId:[[_totalVisibleJobs valueForKey:@"jobId"] objectAtIndex:sender.tag] SenderButton:sender];
    }
    
    if ([[selectedFollowUp objectAtIndex:sender.tag]isEqualToString:@"0"]) {
        [selectedFollowUp replaceObjectAtIndex:sender.tag withObject:@"1"];
        kAppDel.SelectedFollowUp = @"1";
        [[NSUserDefaults standardUserDefaults] setObject:@"collectionReload"   forKey:@"reload"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        kAppDel.SelectedFollowUp = @"0";
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"reload"];
    }
   
    [_categoryTableView reloadData];
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


#pragma mark - Section Button -


-(void)section
{
[_btnAll setTitleColor:[UIColor colorWithRed:55.0/255.0 green:99.0/255.0 blue:145.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    _btnAllBorder.hidden= NO;
    _btnAreaBorder.hidden = YES;
   // _btnInMyArea.hidden = NO;
}


#pragma mark - AreaWise Job -


-(void)areaWiseJob
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    [selectedFollowUp removeAllObjects];
    [_param setObject:@"jobsNearBy" forKey:@"methodName"];
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
    [_param setObject:[[NSString alloc] initWithFormat:@"%f", currentLocation.latitude]  forKey:@"latitude"];
    [_param setObject:[[NSString alloc] initWithFormat:@"%f", currentLocation.longitude]forKey:@"longitude"];
    [_param setObject:@"excat match" forKey:@"serachType"];
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        
        NSLog(@"response object %@",responseObject);
        
        kAppDel.obj_EmployeeAreWiseJob = [[EmployeeAreWiseJob alloc]initWithDictionary:responseObject];
        
    if ([[responseObject valueForKey:@"status"] isEqual:@1])
        {
            
        _totalJobs = [[NSMutableArray alloc]init];
        latitude = [[NSMutableArray alloc]init];
        longitude = [[NSMutableArray alloc]init];
        _totalJobs = [[responseObject valueForKey:@"data"]valueForKey:@"allJobs"];
            
            for (int i=0; i<_totalJobs.count; i++) {
                [selectedFollowUp addObject:@"0"];
            }
            
        latitude = [_totalJobs valueForKey:@"latitude"];
            
            longitude = [_totalJobs valueForKey:@"longitude"];
            
            selected = -1;
          markerUserLocation.map  = nil;
           
           [_mapView clear];
            
            [self mapMarker];
            
            
            [self SetVisibleJobs];

//            _categoryTableView.delegate = self;
//            _categoryTableView.dataSource = self;
            [_categoryTableView reloadData];
    }
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
{

}];
}


#pragma mark - All Job -
-(void)allJob
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    [selectedFollowUp removeAllObjects];

    [_param setObject:@"jobsNearBy" forKey:@"methodName"];
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
    [_param setObject:[[NSString alloc] initWithFormat:@"%f", currentLocation.latitude]  forKey:@"latitude"];
    [_param setObject:[[NSString alloc] initWithFormat:@"%f", currentLocation.longitude]forKey:@"longitude"];
    [_param setObject:@"brader match" forKey:@"serachType"];
    
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {

         kAppDel.obj_EmployeeAllJob = [[EmployeeAllJob alloc]initWithDictionary:responseObject];
          if ([[responseObject valueForKey:@"status"] isEqual:@1])
          {
              _totalJobs = [[NSMutableArray alloc]init];
              latitude = [[NSMutableArray alloc]init];
              longitude = [[NSMutableArray alloc]init];
            _totalJobs = [[responseObject valueForKey:@"data"]valueForKey:@"allJobs"];
              latitude = [_totalJobs valueForKey:@"latitude"];
              longitude = [_totalJobs valueForKey:@"longitude"];
            selected = -1;
             
              markerUserLocation.map  = nil;
             [_mapView clear];
              [self mapMarker];
              
              [self SetVisibleJobs];

//              _categoryTableView.delegate = self;
//              _categoryTableView.dataSource = self;
//              currentSelection = [_totalJobs count]+1;
             // [_categoryTableView reloadData];
          }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
     }];
}


#pragma mark - UILabel Text and date -
-(void)label:(UILabel*)label
{
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    label.numberOfLines = 0;
   label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
}


-(NSString *)dateToFormatedDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    [dateFormatter setDateFormat:@"dd/yy"];
    return [dateFormatter stringFromDate:date];
}

-(void)labelChangeColor:(searchTableViewCell*)mapCell Color:(UIColor*)color{
    mapCell.lblPricetag.backgroundColor = color;
    mapCell.lblSecondPricetag.backgroundColor = color;
    mapCell.lblthirdPricetag.backgroundColor = color;
    mapCell.lblBlueBorder.backgroundColor = color;
    mapCell.BorderLblStraight.backgroundColor = color;
    mapCell.BorderLblStraightSelected.backgroundColor = color;
    mapCell.btnCanditatureClicked.backgroundColor = color;
    mapCell.borderBottomLyingLbl.backgroundColor = color;
    
    mapCell.middleTopLbl.backgroundColor = [UIColor grayColor];
    mapCell.bottomTopLbl.backgroundColor = [UIColor grayColor];
}

#pragma mark - MapView Delegates -
-(BOOL) mapView:(GMSMapView *) mapView didTapMarker:(GMSMarker *)marker
{
    selected = [marker.accessibilityLabel intValue];

    currentSelection = [marker.accessibilityLabel intValue];
    
    markerUserLocation.map  = nil;
    
    [mapView clear];
    
    [self mapMarker];
    
    for(int i = 0;i<[_totalVisibleJobs count]; i++)
    {
    [_categoryTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
    return YES;
}

-(void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture{
    
    [self SetVisibleJobs];

}

-(void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    
    [self SetVisibleJobs];
    
}

-(void)SetVisibleJobs{
    
    [_totalVisibleJobs removeAllObjects];

    GMSVisibleRegion visibleRegion = _mapView.projection.visibleRegion;
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithRegion: visibleRegion];
    int count = 0;
    for (int i = 0; i<latitude.count; i++) {
        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([[latitude objectAtIndex:i]doubleValue],[[longitude objectAtIndex:i]doubleValue]);
        
        if ([bounds containsCoordinate:position]) {
            count++;
            [_totalVisibleJobs addObject:[_totalJobs objectAtIndex:i]];
        }
    }
    _lblJobCategoryInfo.text = [NSString stringWithFormat:@"%d jobs in %@",count,kAppDel.obj_responseEmployeeUserDetail.Employee_category_name];
    
    for (int i=0; i<_totalVisibleJobs.count; i++) {
        [selectedFollowUp addObject:@"0"];
    }
    
    currentSelection = [_totalVisibleJobs count]+1;
    
    
    _categoryTableView.delegate = self;
    _categoryTableView.dataSource = self;
    [_categoryTableView reloadData];
}

-(UIView *)BlueViewMarker:(NSUInteger)labelTextInt markerCount:(NSUInteger)markerCount
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 69, 60)];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 30, 21)];
    
    label.text = [NSString stringWithFormat:@"%lu",(unsigned long)markerCount];
    
    label.font = [UIFont systemFontOfSize:10];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:24.0/255.0 green:59.0/255.0 blue:91.0/255.0 alpha:1.0];
    label.backgroundColor = [UIColor colorWithRed:177.0/255.0 green:177.0/255.0 blue:177.0/255.0 alpha:1.0];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 21, 69, 38)];
    [btn setImage:[UIImage imageNamed:@"map2_"] forState:UIControlStateNormal];
    [view addSubview:label];
    [view addSubview:btn];
    return view;
}


-(UIView *)GreenViewMarker:(NSUInteger)accessbilityLabel markerCount:(NSUInteger)markerCount
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 69, 73)];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 30, 21)];
    
    label.text = [NSString stringWithFormat:@"%lu",(unsigned long)markerCount];
    
    label.font = [UIFont systemFontOfSize:10];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor whiteColor];
    
    label.backgroundColor = [UIColor colorWithRed:32.0/255.0 green:139.0/255.0 blue:58.0/255.0 alpha:1.0];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 21, 69, 38)];
    
     [btn setImage:[UIImage imageNamed:@"map3_"] forState:UIControlStateNormal];
    
     UIButton *Green = [[UIButton alloc]initWithFrame:CGRectMake(10, 50, 50, 10)];
    
    [Green setImage:[UIImage imageNamed:@"map_location_"] forState:UIControlStateNormal];
    
    [view addSubview:label];
    [view addSubview:Green];
    [view addSubview:btn];
    return view;
}


-(void)UserLocationMarker:(CLLocationCoordinate2D )Position
{
    markerUserLocation.position = Position;
        markerUserLocation.icon = [UIImage imageNamed:@"map_user_"];
    markerUserLocation.userData = @"UserLocation";
    markerUserLocation.appearAnimation = kGMSMarkerAnimationPop;
    markerUserLocation.map = _mapView;
}

#pragma mark - Marker
-(void)mapMarker{
    

   // GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
   // bounds = [bounds includingCoordinate:currentLocation];
    
    [_clusterManager clearItems];
    
    for (int i = 0; i<latitude.count; i++) {
       
        id<GMUClusterItem> itemCluster =
        
        [[POIItem alloc]initWithPosition:CLLocationCoordinate2DMake([[latitude objectAtIndex:i]doubleValue], [[longitude objectAtIndex:i]doubleValue]) name:@"Name"];
        
        
        [_clusterManager addItem:itemCluster];
        
        [_clusterManager cluster];
        [_clusterManager setDelegate:self mapDelegate:self];
    }
    
    NSArray *latit = [[NSSet setWithArray: latitude] allObjects];
    NSCountedSet *setLat = [[NSCountedSet alloc] initWithArray:latitude];
    [setLat addObject:@"latLast"];
    
    NSArray *longit = [[NSSet setWithArray: longitude] allObjects];
    NSCountedSet *setLong = [[NSCountedSet alloc] initWithArray:longitude];
    [setLong addObject:@"longLast"];
    
    
    NSUInteger markerCount,count = 0;
    
    for (id item in setLong) {
        
      
        markerCount = (unsigned long)[setLong countForObject:item];
        
        
        if ([item isEqualToString:@"longLast"]) {
            markerUserLocation.map = nil;
            markerUserLocation.position = currentLocation;
            markerUserLocation.icon = [UIImage imageNamed:@"map_user_"];
            markerUserLocation.userData = @"UserLocation";
            markerUserLocation.appearAnimation = kGMSMarkerAnimationPop;
            markerUserLocation.map = _mapView;
            count--;
        }
        else{
            if (count==-1) {
                count=0;
            }
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake([[latit objectAtIndex:count]doubleValue],[[longit objectAtIndex:count]doubleValue]);
            
             count++;
            
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            
           // bounds = [bounds includingCoordinate:marker.position];

            marker.accessibilityLabel = [NSString stringWithFormat:@"%lu",(unsigned long)count];
            
            if (selected == [marker.accessibilityLabel intValue]){
                GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:CLLocationCoordinate2DMake([[latitude objectAtIndex:count]doubleValue],[[longitude objectAtIndex:count]doubleValue])zoom:6.0];
                [_mapView animateWithCameraUpdate:updatedCamera];
                marker.iconView = [self GreenViewMarker:count markerCount:markerCount];
            }
            else{
                marker.iconView = [self BlueViewMarker:count markerCount:markerCount];
            }
            marker.appearAnimation = kGMSMarkerAnimationPop;
            //[_mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];

            //marker.map = _mapView;
        }
    }
}


- (void)showCurrentLocation
{  _mapView.myLocationEnabled = YES;
    _mapView.settings.myLocationButton = YES;
    _mapView.delegate = self;
    markerUserLocation.map  = nil;
    _mapView.myLocationEnabled = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    markerUserLocation.map = nil;
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Location"] isEqualToString:@"changeLocation"]) {
        
        currentLocation = CLLocationCoordinate2DMake([[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLat"]doubleValue], [[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLong"]doubleValue]);
    }
    else{
    currentLocation = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    }
    
    [kAppDel.progressHud hideAnimated:YES];
    [self UserLocationMarker:currentLocation];
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (check == 0)
    {
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Location"] isEqualToString:@"changeLocation"]) {
            
            currentLocation = CLLocationCoordinate2DMake([[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLat"]doubleValue], [[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLong"]doubleValue]);        }
        
        else{

        currentLocation = CLLocationCoordinate2DMake([locations objectAtIndex:0].coordinate.latitude, [locations objectAtIndex:0].coordinate.longitude);
        }
        [kAppDel.progressHud hideAnimated:YES];
        
        [self UserLocationMarker:currentLocation];
        
        GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:currentLocation zoom:6];
        
        [_mapView animateWithCameraUpdate:updatedCamera];
        _mapView.mapType = kGMSTypeNormal;
        
        check = 1;
    }
    if (currentLocation.latitude == [locations lastObject].coordinate.latitude && currentLocation.longitude == [locations lastObject].coordinate.longitude)
    {
    }
    else{
        
        [kAppDel.progressHud hideAnimated:YES];

        CLLocationCoordinate2D changeLocation = CLLocationCoordinate2DMake([[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLat"]doubleValue], [[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLong"]doubleValue]);
        
        if (currentLocation.latitude == changeLocation.latitude && currentLocation.longitude== changeLocation.longitude ) {
            
            if (kAppDel.changeCount==1) {
               
                currentLocation = CLLocationCoordinate2DMake([[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLat"]doubleValue], [[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLong"]doubleValue]);
                
                markerUserLocation.map = nil;
                
                if (_btnAreaBorder.hidden == NO) {
                    [self areaWiseJob];
                }
                
                if (_btnAllBorder.hidden == NO) {
                    [self allJob];
                }
                
//                if (count==0)
//                {
//                    [self allJob];
//                }
//                if (count==1)
//                {
//                    [self areaWiseJob];
//                }
                GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:currentLocation zoom:6];
                
                [_mapView animateWithCameraUpdate:updatedCamera];
                
                [self UserLocationMarker:currentLocation];
                kAppDel.changeCount = 2;
            }
        }
        else{

            currentLocation = CLLocationCoordinate2DMake([locations lastObject].coordinate.latitude, [locations lastObject].coordinate.longitude);
 
            markerUserLocation.map = nil;
            if (count==0)
            {
                [self allJob];
            }
            if (count==1)
            {
                [self areaWiseJob];
            }
            GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:currentLocation zoom:6];
            
            [_mapView animateWithCameraUpdate:updatedCamera];
            
            [self UserLocationMarker:currentLocation];

        }
    }
}

#pragma mark GMUClusterManagerDelegate

- (void)clusterManager:(GMUClusterManager *)clusterManager didTapCluster:(id<GMUCluster>)cluster {
    
    NSLog(@"called cluster count %lu ",(unsigned long)cluster.count);
 
    for(int i = 0;i<[_totalVisibleJobs count]; i++)
    {
        [_categoryTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (void)clusterManager:(GMUClusterManager *)clusterManager
     didTapClusterItem:(id<GMUClusterItem>)clusterItem{
    NSLog(@"called");
}

#pragma mark - navigationBarButton navigation -
-(UIBarButtonItem *) RightBarButton
{
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    _switchSelected = [[UIButton alloc]initWithFrame:CGRectMake(0, 6, 35, 24)];
    [_switchSelected setImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
    [_switchSelected setImage:[UIImage imageNamed:@"on_off_"] forState:UIControlStateSelected];
    [_switchSelected addTarget:self action: @selector(switchedClicked) forControlEvents:UIControlEventTouchUpInside];
    _chatSelected = [[UIButton alloc]initWithFrame:CGRectMake(55, 4, 32, 28)];
    [_chatSelected setImage:[UIImage imageNamed:@"chat_.png"] forState:UIControlStateNormal];
    _chatSelected.layer.masksToBounds = YES;
    [_chatSelected addTarget:self action:@selector(chatClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _chatBadge = [JSCustomBadge customBadgeWithString:@"" withStringColor:[UIColor redColor] withInsetColor:[UIColor redColor] withBadgeFrame:NO withBadgeFrameColor:[UIColor blueColor] withScale:1.0 withShining:NO withShadow:NO];
    
    _chatBadge.frame = CGRectMake(_chatSelected.frame.size.width+_chatSelected.frame.origin.x-15, _chatSelected.frame.origin.y, 20, 20);
    
    [rightView addSubview:_switchSelected];
    [rightView addSubview:_chatSelected];
    
    //[rightView addSubview:_chatBadge];
    
    return [[UIBarButtonItem alloc]initWithCustomView:rightView];

}


#pragma mark - Week Collection DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [WeekDays count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    employeeWeekCell *obj_employeeWeekCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"employeeWeekCell" forIndexPath:indexPath];
    
   // NSArray *Str;
    
    obj_employeeWeekCell.lblWeekName.text = [WeekDays objectAtIndex:indexPath.row];
    
    obj_employeeWeekCell.btnWeekAdd.tag = indexPath.item;
    
    [ obj_employeeWeekCell.btnWeekAdd addTarget:self action:@selector(btnWeekAddClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (responseSelectedAvailibility.count>0) {
        
         NSArray *startTimeArray = [[responseSelectedAvailibility valueForKey:@"start_time"]objectAtIndex:0];
        
         NSArray *endTimeArray = [[responseSelectedAvailibility valueForKey:@"end_time"]objectAtIndex:0];
        
        for (int i = 0; i<[[responseSelectedAvailibility firstObject]count]; i++) {
            
            obj_employeeWeekCell.lblStartTime.text = [startTimeArray objectAtIndex:i];
            
            obj_employeeWeekCell.lblEndTime.text = [endTimeArray objectAtIndex:i];
        }
    }
    
    if ([[selectedWeekAvailibility objectAtIndex:indexPath.row]isEqualToString:@"0"]) {
        
        [self collectionBorderLbl:obj_employeeWeekCell];
    }
   if ([[selectedWeekAvailibility objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
      
        [self SelectedCell:obj_employeeWeekCell];
    }
    
    /*
    if (responseSelectedAvailibility.count>0) {
        
     Str = [[[responseSelectedAvailibility valueForKey:@"data"]valueForKey:@"day"]objectAtIndex:0];
    }
    
    if ([Str count]==0)
    {
        [self collectionBorderLbl:obj_employeeWeekCell];
    }
    
    else
    {
        for (int i = 0; i<[[[responseSelectedAvailibility valueForKey:@"data"]objectAtIndex:0]count]; i++)
        {
            if ([[[[[responseSelectedAvailibility objectAtIndex:0] valueForKey:@"data"]objectAtIndex:i]valueForKey:@"day"] isEqualToString:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]])
            {
                
                [self SelectedCell:obj_employeeWeekCell];
                
                NSString  * str =[[[[responseSelectedAvailibility objectAtIndex:0]valueForKey:@"data"]objectAtIndex:i]valueForKey:@"start_time"];
                str = [str stringByReplacingOccurrencesOfString:@":00" withString:@""];
                
              str =   [str stringByReplacingOccurrencesOfString:@".00" withString:@""];
                
            obj_employeeWeekCell.lblStartTime.text = str;
                
                str = [[[[responseSelectedAvailibility objectAtIndex:0]valueForKey:@"data"]objectAtIndex:i]valueForKey:@"end_time"];
                
                str = [str stringByReplacingOccurrencesOfString:@":00" withString:@""];
                str =   [str stringByReplacingOccurrencesOfString:@".00" withString:@""];
                
                obj_employeeWeekCell.lblEndTime.text = str;
                
                break;
            }
            else{
                [self collectionBorderLbl:obj_employeeWeekCell];
            }
        }

    }
   */
    return obj_employeeWeekCell;
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height/7);
//}


-(void)collectionBorderLbl:(employeeWeekCell*)obj_employeeWeekCell
{
    obj_employeeWeekCell.lblStartTime.hidden = YES;
    
    obj_employeeWeekCell.lblBorder.hidden = YES;
    
    obj_employeeWeekCell.lblEndTime.hidden = YES;
    
    obj_employeeWeekCell.lblBorderLower.hidden = YES;
    
    obj_employeeWeekCell.lblWeekName.textColor = [UIColor whiteColor];
    
    obj_employeeWeekCell.btnWeekAdd.backgroundColor = [UIColor clearColor];
    
    obj_employeeWeekCell.viewWeekUpper.backgroundColor = [UIColor clearColor];
    
    obj_employeeWeekCell.lblNotAvailable.hidden = NO;
    
     [obj_employeeWeekCell.btnWeekAdd setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
}



-(void)btnWeekAddClicked:(UIButton*)sender
{
    cellSelected = sender.tag;
    
    _ProgressSaveEmployeeView.hidden = NO;
    
    selectedWeekDays = [NSString stringWithFormat:@"%ld",(long)sender.tag+1];
    
     _lblProgressWeekNames.text = [progreeWeekDays objectAtIndex:sender.tag];
    
    if([[selectedWeekAvailibility objectAtIndex:sender.tag] isEqualToString:@"0"]){
        
        [selectedWeekAvailibility replaceObjectAtIndex:sender.tag withObject:@"1"];
        }
    else{
       // [selectedWeekAvailibility replaceObjectAtIndex:sender.tag withObject:@"0"];
    }
    
    [_employeeWeekCollection reloadData];
}


-(void)SelectedCell:(employeeWeekCell*)Cell
{
    Cell.lblWeekName.textColor = [UIColor colorWithRed:139.0/255.0 green:155.0/255.0 blue:178.0/255.0 alpha:1.0];
    
    [Cell.btnWeekAdd setImage:[UIImage imageNamed:@"Multiply"] forState:UIControlStateNormal];
    
    Cell.btnWeekAdd.backgroundColor = [UIColor whiteColor];
    
    Cell.lblStartTime.hidden = NO;
    Cell.lblEndTime.hidden = NO;
    
    Cell.lblNotAvailable.hidden = YES;
    
    Cell.viewWeekUpper.backgroundColor = [UIColor whiteColor];
    
    Cell.lblBorder.hidden = NO;
    
    Cell.lblBorderLower.hidden = NO;
}

#pragma mark - Save User Availibility -


-(void)saveUserAvailability
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    [_param setObject:@"saveUserAvailability" forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
    
    if (_switchSelected.selected) {
        [_param setObject:@"1" forKey:@"availabilityStatus"];
    }
    else{
        [_param setObject:@"0" forKey:@"availabilityStatus"];
    }

    [_param setObject:selectedWeekDays forKey:@"daysOfWeek"];

    [_param setObject:startTime forKey:@"start_time"];

    [_param setObject:endTime forKey:@"end_time"];
    
    [_param setObject:@"" forKey:@"type"];
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Success!" Message:@"Availability detail updated" AlertMessage:@"OK"] animated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Get User Availibility -
-(void)getUserAvailibility
{
    responseSelectedAvailibility = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    [_param setObject:@"getUserAvailability" forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        [responseSelectedAvailibility addObject:[responseObject valueForKey:@"data"] ];
        
         NSArray *dayArray = [[responseSelectedAvailibility valueForKey:@"day"] objectAtIndex:0];
        
        for (int i = 0; i<[[responseSelectedAvailibility firstObject]count]; i++) {
       
        NSString *dayIndexString = [dayArray objectAtIndex:i];
            
        int dayIndex = [dayIndexString intValue];
            
        dayIndex = dayIndex-1;
          
        [selectedWeekAvailibility replaceObjectAtIndex:dayIndex withObject:@"1"];
        }
        
        [_employeeWeekCollection reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Progress Slider -
-(void) ProgressSlider{
    float start = _startTimeOnelbl.frame.origin.x+_startTimeOnelbl.frame.size.width;
    
    float end = _endTimeTwlvLbl.frame.size.width+14;
    
    float width = self.view.frame.size.width - (start+end);

     sliderFrame = CGRectMake(_startTimeOnelbl.frame.origin.x+_startTimeOnelbl.frame.size.width+5, _lblProgressWeekNames.frame.origin.y+_lblProgressWeekNames.frame.size.height+40,width-7 , 20);

    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(sliderFrame.origin.x, sliderFrame.origin.y+10, sliderFrame.size.width, 1)];
    
    lbl.backgroundColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1.0];

    _TopstartTimeLbl.constant = sliderFrame.origin.y;
    _TopEndTimelbl.constant = sliderFrame.origin.y;
    _HeightstartTimeLbl.constant = sliderFrame.size.height;
    _HeightEndTimelbl.constant = sliderFrame.size.height;
    
    _rangeSlider = [[CERangeSlider alloc] initWithFrame:sliderFrame];
    
    StatTimelbl = [[UILabel alloc]init];
    
    StatTimelbl.text = @"00:00";
    
    StatTimelbl.textColor = _lblProgressWeekNames.textColor;
    
    StatTimelbl.frame = CGRectMake(sliderFrame.origin.x, sliderFrame.size.height+sliderFrame.origin.y+10, [self widthForLabel:StatTimelbl withText:StatTimelbl.text], _endTimeTwlvLbl.frame.size.height);
    
    endTimelbl = [[UILabel alloc]init];
    
    endTimelbl.text = @"24:00";
    
    endTimelbl.textColor = _lblProgressWeekNames.textColor;
    
//    endTimelbl.frame = CGRectMake(sliderFrame.size.width+sliderFrame.origin.x, StatTimelbl.frame.origin.y, [self widthForLabel:endTimelbl withText:endTimelbl.text], 20);
    
    endTimelbl.frame = CGRectMake(sliderFrame.size.width+sliderFrame.origin.x, StatTimelbl.frame.origin.y, [self widthForLabel:endTimelbl withText:endTimelbl.text], _endTimeTwlvLbl.frame.size.height);

    [_ProgressSaveEmployeeView addSubview:lbl];

     [_ProgressSaveEmployeeView addSubview:StatTimelbl];
    
     [_ProgressSaveEmployeeView addSubview:endTimelbl];
    
    [_ProgressSaveEmployeeView addSubview:_rangeSlider];
    
    [_rangeSlider addTarget:self
                     action:@selector(slideValueChanged:)
           forControlEvents:UIControlEventValueChanged];
}


- (void)slideValueChanged:(id)control
{
 
    CGFloat lowerValue = round(_rangeSlider.lowerValue * 100) / 100;
    CGFloat upperValue = round(_rangeSlider.upperValue * 100) / 100;
    
    
//    StatTimelbl.text = [NSString stringWithFormat:@"%.2f ",lowerValue];
//    
//    endTimelbl.text = [NSString stringWithFormat:@"%.2f ",upperValue];
//
//    startTime = [NSString stringWithFormat:@"%.2f",lowerValue];
//    endTime = [NSString stringWithFormat:@"%.2f",upperValue];
    
    StatTimelbl.text = [self minHourConversionFromString:[NSString stringWithFormat:@"%.2f ",lowerValue]];
    endTimelbl.text = [self minHourConversionFromString:[NSString stringWithFormat:@"%.2f ",upperValue]];

    startTime = [self minHourConversionFromString:[NSString stringWithFormat:@"%.2f ",lowerValue]];
    endTime = [self minHourConversionFromString:[NSString stringWithFormat:@"%.2f ",upperValue]];
    
    
    
    if (_rangeSlider.lowerTouchPointValue.x>sliderFrame.origin.x) {
        
        if ( [StatTimelbl.text isEqualToString:endTimelbl.text]) {
            
        }
        
        StatTimelbl.frame = CGRectMake(_rangeSlider.lowerTouchPointValue.x, StatTimelbl.frame.origin.y, 60, _endTimeTwlvLbl.frame.size.height);

    }
    if (_rangeSlider.upperTouchPointValue.x>sliderFrame.origin.x && _rangeSlider.upperTouchPointValue.x<sliderFrame.origin.x+sliderFrame.size.width) {
//        CGFloat width =   [self widthForLabel:endTimelbl  withText:endTimelbl.text];
       
            endTimelbl.frame = CGRectMake(_rangeSlider.upperTouchPointValue.x, endTimelbl.frame.origin.y, 60, _endTimeTwlvLbl.frame.size.height);
        
    }
}


-(NSString *)minHourConversionFromString :(NSString *)Value{
   
    NSString *Min =Value;
    
    NSRange range = [Min rangeOfString:@"."];
    
    NSString *hour = [Min substringToIndex:range.location];
    
   int HOUR = [hour intValue];
    
    Min = [Min substringFromIndex:range.location+1];
    
   int min = [Min intValue];
    
    if (min>=60) {
        min = min-60;
        HOUR = HOUR+1;
    }
    return [NSString stringWithFormat:@"%d:%d",HOUR,min];
}

#pragma mark - User Detail -
-(void)EmployeeuserDetail
{
    
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        
        [_param setObject:@"userDetails" forKey:@"methodName"];
        
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
        
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            [kAppDel.progressHud hideAnimated:YES];
            
            
            kAppDel.obj_responseEmployeeUserDetail = [[responseEmployeeUserDetail alloc]initWithDictionary:responseObject];
            
            /*-------Archiving the data----*/
            
            employeeUserDetailData =[NSKeyedArchiver archivedDataWithRootObject: kAppDel.obj_responseEmployeeUserDetail];
            
            [[NSUserDefaults standardUserDefaults] setObject:employeeUserDetailData forKey:@"employeeUserDetail"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            NSData *LoginEmployee = [[NSUserDefaults standardUserDefaults]objectForKey:@"employeeUserDetail"];
            if (LoginEmployee!=nil) {
                kAppDel.obj_responseEmployeeUserDetail = [NSKeyedUnarchiver unarchiveObjectWithData:LoginEmployee];
                kAppDel.EmployeeProfileImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:kAppDel.obj_responseEmployeeUserDetail.Employee_jobseeker_profile_pic]]];
                _lblJobCategoryInfo.text = [NSString stringWithFormat:@"%lu jobs in %@",(unsigned long)[_totalJobs count],kAppDel.obj_responseEmployeeUserDetail.Employee_category_name];
                
                [[[SlideNavigationController sharedInstance ]profileImage]setImage:kAppDel.EmployeeProfileImage forState:UIControlStateNormal];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [kAppDel.progressHud hideAnimated:YES];
             
         }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}

-(CGFloat)widthForLabel:(UILabel *)label withText:(NSString *)text
{
    if (text.length > 0)
    {
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:label.font}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){label.frame.size.width, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        
        return ceil(rect.size.width);
        
    }
    
    return 0;
}

- (NSString *) printSecond:(NSInteger) seconds {
    
    if (seconds < 60) {
        return [NSString stringWithFormat:@"00:%02ld",(long)seconds];
    }
    
    if (seconds >= 60) {
        
        int minutes = floor(seconds/60);
        int rseconds = trunc(seconds - minutes * 60);
        
        return [NSString stringWithFormat:@"%02d:%02d",minutes,rseconds];
        
    }
    return @"";
}

#pragma mark - Apply and Follow job -
-(void)applyFollowJob:(NSString*)Method jobId:(NSString*)jobId SenderButton:(UIButton*)Sender
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    [_param setObject:Method forKey:@"methodName"];
    
    if ([Method isEqualToString:@"applyForJob"]) {
        
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
        [_param setObject:jobId forKey:@"jobId"];

    }else{
         [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"jobseeker_id"];
        [_param setObject:jobId forKey:@"job_id"];
    }
    if ([GlobalMethods InternetAvailability]) {
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [kAppDel.progressHud hideAnimated:YES];
            
            NSString *eStatus = [[responseObject valueForKey:@"data"]valueForKey:@"employerStatus"];
            NSString *jStatus = [[responseObject valueForKey:@"data"]valueForKey:@"jobseekerStatus"];
            
            EmployeeApplyForJob *obj_EmployeeApplyForJob = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeApplyForJob"];
            
            obj_EmployeeApplyForJob.companyName = [[_totalVisibleJobs objectAtIndex:Sender.tag]valueForKey:@"companyName"];
            
            obj_EmployeeApplyForJob.jobTitle = [[_totalVisibleJobs objectAtIndex:Sender.tag]valueForKey:@"jobTitle"];
            
            obj_EmployeeApplyForJob.applicationSent = @"Application Sent";
            obj_EmployeeApplyForJob.applicationWaiting = @"Waiting for hiring manager to check your application";
            obj_EmployeeApplyForJob.applicationFeedback = @"Waiting feedback";
            
            if ([eStatus isEqual:@0] && [jStatus isEqual:@0]) {
            }
            else if ([eStatus isEqual:@5] && [jStatus isEqual:@0]) {
                
                obj_EmployeeApplyForJob.applicationWaiting = @"Hiring manager received your application";
                obj_EmployeeApplyForJob.wait = @"wait";
            }
            else if ([eStatus isEqual:@4] && [jStatus isEqual:@0]) {
                obj_EmployeeApplyForJob.applicationWaiting = @"Hiring manager received your application";
                obj_EmployeeApplyForJob.applicationFeedback = @"You were selected!";
                
                obj_EmployeeApplyForJob.result = @"selected";
            }
            else if ([eStatus isEqual:@2] && [jStatus isEqual:@0]) {
                obj_EmployeeApplyForJob.applicationWaiting = @"Hiring manager received your application";
                obj_EmployeeApplyForJob.applicationFeedback = @"You were relected!";
                obj_EmployeeApplyForJob.result = @"rejected";
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


-(void)initialWeek{
    startTimeFrames = [[NSMutableArray alloc]init];
    endTimeFrames = [[NSMutableArray alloc]init];
    selectedWeekAvailibility = [[NSMutableArray alloc]init];
    check = 0;
    selectedFollowUp = [[NSMutableArray alloc]init];
    WeekDays = @[@"Sun",@"Mon", @"Tues", @"Wed",@"Thurs",@"Fri",@"Sat"];
    progreeWeekDays = @[@"Sunday",@"Monday", @"Tuesday", @"Wednesday",@"Thursday",@"Friday",@"Saturday"];
    for (int i = 0; i<WeekDays.count; i++) {
        [selectedWeekAvailibility addObject:@"0"];
    }
}

@end
