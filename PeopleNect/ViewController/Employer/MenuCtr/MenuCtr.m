//
//  MenuCtr.m
//  PeopleNect
//
//  Created by Apple on 23/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "MenuCtr.h"

static CLLocationCoordinate2D currentLocation;

@interface MenuCtr ()
{
    UITapGestureRecognizer *tap;
    NSMutableArray *arraySelectedItems,*arrayCategoryId,*arrayCategoryList;
    NSString *EmployerUserID,*selectedCategoryName,*totalRecords;
    NSInteger selectedTab,check,flag,selectedTabNumber,lastSelectedIndex,nearByCount,selectedtag;
    GMSMarker *currentMarker,*markerUserLocation;
    NSMutableArray *EmployeeDetails;
    GMSCoordinateBounds *visibleRegions;
}
@end


@implementation MenuCtr
#pragma  mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self intiallize];
    
    kAppDel.subCategoryFromInvited = [[NSMutableArray alloc]init];
    self.totalRecordEmployee.textColor = [UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0];
    self.totalRecordEmployee.font = [UIFont fontWithName:@"helvetica" size:13];
    self.totalRecordEmployee.text = @"";
    
    EmployeeDetails = [[NSMutableArray alloc]init];

    //[self showCurrentLocation];
    
    if ([GlobalMethods InternetAvailability]) {
        [self businessCategoryList];
        [self jobPostingPriceAndBalance];

    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
    
   //currentLocation = CLLocationCoordinate2DMake(23.0813, 72.5269);
    
   currentLocation = CLLocationCoordinate2DMake([kAppDel.obj_responseDataOC.employerLocationLat doubleValue], [kAppDel.obj_responseDataOC.employerLocationLat doubleValue]);
    
    markerUserLocation = [[GMSMarker alloc]init];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentLocation zoom:16.0];
    [_obj_MapView setCamera:camera];
    selectedTab = 0;
    flag = 0;
    check = 0;
    
    
    [[SlideNavigationController sharedInstance ]setEnableSwipeGesture:NO];
    
    UISwipeGestureRecognizer *swipeRightSide = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGesture:)];
    swipeRightSide.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    UISwipeGestureRecognizer *swipeLeftSide = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGesture:)];
    swipeLeftSide.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    swipeLeftSide.delegate = self;
    swipeRightSide.delegate = self;
    
    [_obj_MainTableView addGestureRecognizer:swipeRightSide];
    [_obj_MainTableView addGestureRecognizer:swipeLeftSide];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(EmployerLocationChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
    _changeLocationbtn.hidden = YES;
}


- (void)EmployerLocationChanged:(NSNotification *)notification {
    
    NSUserDefaults *defaults = (NSUserDefaults *)[notification object];
    
    if ([[defaults objectForKey:@"Location"] isEqualToString:@"EmployerLocation"]) {
        
//        currentLocation = CLLocationCoordinate2DMake([[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLat"]doubleValue], [[[NSUserDefaults standardUserDefaults]valueForKey:@"changeLong"]doubleValue]);
        
    }
}




-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    _heightOfMapView.constant =(self.view.frame.size.height*235)/568;
    _heightOfMiddleView.constant = (self.view.frame.size.height*75)/568;
    _heightOfTableView.constant = self.objScrollView.frame.size.height - self.sectionView.frame.size.height;
}

-(void)viewWillDisappear:(BOOL)animated{
    [[SlideNavigationController sharedInstance ]setEnableSwipeGesture:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[SlideNavigationController sharedInstance]setNavigationBarHidden:NO];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:32.0/255.0 green:86.0/255.0 blue:136.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.rightBarButtonItem =  [self RightBarButton];
}


#pragma mark - show Current Location  Delegates -
- (void)showCurrentLocation
{
    markerUserLocation.map  = nil;
    _obj_MapView.myLocationEnabled = YES;
    _obj_MapView.settings.myLocationButton = YES;

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
    currentLocation = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [kAppDel.progressHud hideAnimated:YES];
    [self UserLocationMarker:CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)];
}

-(void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    
    if ([visibleRegions containsCoordinate:position.target]) {
    }
}

-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    
    if ([visibleRegions containsCoordinate:position.target]) {
    }
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (check == 0)
    {
        currentLocation = CLLocationCoordinate2DMake([locations objectAtIndex:0].coordinate.latitude, [locations objectAtIndex:0].coordinate.longitude);
        [kAppDel.progressHud hideAnimated:YES];
        [self UserLocationMarker:currentLocation];
        GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:currentLocation zoom:16.0];
        [_obj_MapView animateWithCameraUpdate:updatedCamera];
        _obj_MapView.mapType = kGMSTypeNormal;
        check = 1;
    }
    if (currentLocation.latitude == [locations lastObject].coordinate.latitude && currentLocation.longitude == [locations lastObject].coordinate.longitude){
        [self UserLocationMarker:currentLocation];
    }
    else{
        markerUserLocation.map = nil;
        [kAppDel.progressHud hideAnimated:YES];
        currentLocation = CLLocationCoordinate2DMake([locations lastObject].coordinate.latitude, [locations lastObject].coordinate.longitude);
        GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:currentLocation zoom:16.0];
        [_obj_MapView animateWithCameraUpdate:updatedCamera];
        [self UserLocationMarker:currentLocation];
    }
}


-(void)UserLocationMarker:(CLLocationCoordinate2D )Position{
    
    //markerUserLocation.position = Position;
    
    markerUserLocation.position = CLLocationCoordinate2DMake([kAppDel.obj_responseDataOC.employerLocationLat doubleValue], [kAppDel.obj_responseDataOC.employerLocationLong doubleValue]);
    
    markerUserLocation.icon = [UIImage imageNamed:@"iconMapGreen.png"];
    
    markerUserLocation.userData = @"UserLocation";
    
    markerUserLocation.appearAnimation = kGMSMarkerAnimationPop;
    markerUserLocation.map = _obj_MapView;
}


-(void)mapMarker{
     GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    
    bounds = [bounds includingCoordinate:currentLocation];
    
    for(int i=0;i<[[EmployeeDetails valueForKey:@"name"]count];i++)
    {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([[[EmployeeDetails valueForKey:@"lat"]objectAtIndex:i]doubleValue], [[[EmployeeDetails valueForKey:@"lng"]objectAtIndex:i]doubleValue]);
        
        GMSMarker *marker= [GMSMarker markerWithPosition:position];
            bounds = [bounds includingCoordinate:marker.position];
        marker.accessibilityLabel = [NSString stringWithFormat:@"%d",i];
        
        marker.iconView = [self EmployerMarker:i];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = _obj_MapView;
    }
    [_obj_MapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:20.0f]];
}


-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
   
    if ([marker.userData isEqualToString:@"UserLocation"]) {
    }
    else{
    employerInviteForJobVC *obj_employerInviteForJobVC =[self.storyboard instantiateViewControllerWithIdentifier:@"employerInviteForJobVC"];
        
    obj_employerInviteForJobVC.employeeSelected = [marker.accessibilityLabel integerValue];
        
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:
                                obj_employerInviteForJobVC];
        
    obj_nav.definesPresentationContext = YES;
        
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
        
        [self presentViewController:obj_nav animated:YES completion:nil];
    }
    return YES;
}


-(UIView *)EmployerMarker:(int)labelTextInt{
    UIView *customMarker =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 63, 40)];
    UIImageView *imgViewCustomMarker = [[UIImageView alloc]initWithFrame:CGRectMake(0, 15, 24, 25)];
    imgViewCustomMarker.image = [UIImage imageNamed:@"iconMapUser.png"];
    [customMarker addSubview:imgViewCustomMarker];
    UIView *viewRatingCustom = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 40, 15)];
    viewRatingCustom.backgroundColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0];
    UILabel *lblRatingEmployees = [[UILabel alloc] initWithFrame:CGRectMake(8, 1, 17,8)];
    lblRatingEmployees.textColor = [UIColor colorWithRed:0.00/255.0 green:100.0/255.0 blue:150.0/255.0 alpha:1.0];
    lblRatingEmployees.text = [[EmployeeDetails valueForKey:@"rating"]objectAtIndex:labelTextInt];
    lblRatingEmployees.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
    [lblRatingEmployees sizeToFit];
    [viewRatingCustom addSubview:lblRatingEmployees];
    UIImageView *imageViewStar = [[UIImageView alloc] initWithFrame:CGRectMake(25, 3, 10, 8)];
    imageViewStar.image = [UIImage imageNamed:@"iconBlueStar.png"];
    [viewRatingCustom addSubview:imageViewStar];
    [customMarker addSubview:viewRatingCustom];
    return customMarker;
}


#pragma mark - Table DataSource & Delegates -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[EmployeeDetails valueForKey:@"name"]count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    employerMainTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"employerMainTVCell"];
    
    cell.lblEmpNameMainTVC.text = [[EmployeeDetails valueForKey:@"name"]objectAtIndex:indexPath.row];
   
    cell.lblCategoryMainTVCell.text = [NSString stringWithFormat:@"%@ - %@years/ %@km",[[EmployeeDetails valueForKey:@"categoryName"] objectAtIndex:indexPath.row],[[EmployeeDetails valueForKey:@"exp_years"] objectAtIndex:indexPath.row],[[EmployeeDetails valueForKey:@"distance"] objectAtIndex:indexPath.row]];
    
    cell.lblRatingMainTVCell.text = [[EmployeeDetails valueForKey:@"rating"] objectAtIndex:indexPath.row];
   
    cell.lblEmpNameMainTVC.text = [[EmployeeDetails valueForKey:@"name"] objectAtIndex:indexPath.row];
    
    [cell.imgVwMainTVCell sd_setImageWithURL: [NSURL URLWithString:[[EmployeeDetails valueForKey:@"image_url"] objectAtIndex:indexPath.row ]]placeholderImage:[UIImage imageNamed:@"plceholder"]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [kAppDel.subCategoryFromInvited removeAllObjects];
    
    employerInviteForJobVC *obj_employerInviteForJobVC =[self.storyboard instantiateViewControllerWithIdentifier:@"employerInviteForJobVC"];
  
    obj_employerInviteForJobVC.employeeSelected = indexPath.row;
    
    NSData *EmployeeList= [[NSUserDefaults standardUserDefaults] objectForKey:@"EmployeeList"];
    
    if (EmployeeList!=nil) {
        kAppDel.obj_responseEmployeesList = [NSKeyedUnarchiver unarchiveObjectWithData:EmployeeList];
    }
    
    NSString *str=[kAppDel.obj_responseEmployeesList.employeeSubactegoryName objectAtIndex:indexPath.row];
    
    kAppDel.subCategoryFromInvited = [[NSMutableArray alloc] initWithArray:[str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]]];
    
    
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:obj_employerInviteForJobVC];
    
    obj_nav.definesPresentationContext = YES;
    
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:obj_nav animated:YES completion:nil];
}


#pragma mark - Web Services -
-(void)jobPostingPriceAndBalance
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    [_param setObject:@"jobPostingPriceAndBalance" forKey:@"methodName"];
      [_param setObject:EmployerUserID forKey:@"employerId"];
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        kAppDel.obj_jobPostingPriceBalance
        = [[jobPostingPriceBalance alloc] initWithDictionary:responseObject];
        /*------Archiving the data----*/
        NSData *registerData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_jobPostingPriceBalance];
        /*------Setting user default data-----*/
        [[NSUserDefaults standardUserDefaults] setObject:registerData forKey:@"jobPostingPriceBalance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


-(void)nearByEmployeesSelected :(NSInteger) selectedCategory{
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    NSMutableDictionary *parameterDictionary= [[NSMutableDictionary alloc]  init];
    [parameterDictionary setObject:@"nearByEmployees" forKey:@"methodName"];
    [parameterDictionary setObject:EmployerUserID forKey:@"employerId"];
    [parameterDictionary setObject:[arrayCategoryId objectAtIndex:selectedCategory] forKey:@"categoryId"];
    [parameterDictionary setObject:[[NSString alloc] initWithFormat:@"%f", currentLocation.latitude] forKey:@"latitude"];
    [parameterDictionary setObject:[[NSString alloc] initWithFormat:@"%f", currentLocation.longitude] forKey:@"longitude"];
    
    [kAFClient POST:MAIN_URL parameters:parameterDictionary progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        [kAppDel.progressHud hideAnimated:YES];
        
        /*-------Setting data in response object----------*/
        
        kAppDel.obj_responseEmployeesList = [[responseEmployeesList alloc] initWithDictionary:responseObject];
       
        
        NSData *EmployeeList = [NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_responseEmployeesList];
        
        [[NSUserDefaults standardUserDefaults] setObject:EmployeeList  forKey:@"EmployeeList"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        EmployeeDetails = [[responseObject valueForKey:@"data"]mutableCopy];
        
        [self.obj_MapView clear];
        
        [self UserLocationMarker:currentLocation];
        [self mapMarker];
        
        self.obj_MainTableView.delegate = self;
        self.obj_MainTableView.dataSource = self;
        [self.obj_MainTableView reloadData];

    /*--Getting total records of particular selected data---*/
        
    totalRecords = [responseObject valueForKey:@"totalRecords"];
        selectedCategoryName = [responseObject valueForKey:@"selectedCategoryName"];
        if([selectedCategoryName isEqual:[NSNull null]])
        {
            selectedCategoryName = @"All";
            self.totalRecordEmployee.textColor = [UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0];
            self.totalRecordEmployee.font = [UIFont fontWithName:@"helvetica" size:13];
            self.totalRecordEmployee.text = [NSString stringWithFormat:@"%@ professionals in %@", totalRecords,selectedCategoryName];
        }
        else{
            self.totalRecordEmployee.textColor = [UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0];
            self.totalRecordEmployee.font = [UIFont fontWithName:@"helvetica" size:13];
           self.totalRecordEmployee.text = [NSString stringWithFormat:@"%@ professionals in %@", totalRecords,selectedCategoryName];
        }
    }
            failure:^(NSURLSessionDataTask *  task, NSError *  error) {
                [kAppDel.progressHud hideAnimated:YES];
            }];
}


-(void)businessCategoryList{
    NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc] init];
    [categoryDictionary setObject:@"categoryList" forKey:@"methodName"];
    [categoryDictionary setObject:EmployerUserID forKey:@"userId"];
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    
    [kAFClient POST:MAIN_URL parameters:categoryDictionary progress:nil success:^(NSURLSessionDataTask *  task, id responseObject){
        
        [kAppDel.progressHud hideAnimated:YES];
        kAppDel.obj_responseCategoryList =[[responseCategoryList alloc] initWithDictionary:responseObject];
        
        NSData *categoryData =[NSKeyedArchiver archivedDataWithRootObject:kAppDel.obj_responseCategoryList ];
        
        [[NSUserDefaults standardUserDefaults] setObject:categoryData forKey:@"categoryData"] ;
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSInteger count =[[[responseObject valueForKey:@"categoryList"] valueForKey:@"categoryName"] count];
        
        [arrayCategoryList addObject:@"All"];
        [arrayCategoryId addObject:@""];
        
        for(int i =0 ;count > 0 ; i++ ){
        [arrayCategoryList addObject:[[[responseObject valueForKey:@"categoryList"] valueForKey:@"categoryName"] objectAtIndex:i]];
        [arrayCategoryId addObject:[[[responseObject valueForKey:@"categoryList"] valueForKey:@"categoryId"] objectAtIndex:i]];
                    count --;
        }
        if ([GlobalMethods InternetAvailability]) {
            [self nearByEmployeesSelected:0];
        }else{
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
        }
        [ self topTabCreate];
    }
    failure:^(NSURLSessionDataTask *  task, NSError *  error) {
                [kAppDel.progressHud hideAnimated:YES];
            }
        ];
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


#pragma mark - IBActions -

- (IBAction)changeLocationClicked:(id)sender {
    employeeChangeLoc *obj_employeeChangeLoc = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeChangeLoc"];
    
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:obj_employeeChangeLoc];
    
    obj_nav.definesPresentationContext = YES;
    
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self presentViewController:obj_nav animated:YES completion:nil];
}

- (IBAction)ButtonAddClicked:(id)sender {
    
    repostJobEmployerCtr *obj_repostJobEmployerCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"repostJobEmployerCtr"];
    
    [self.navigationController pushViewController:obj_repostJobEmployerCtr animated:YES];
}


-(void)transactionClicked{
    
    [[NSUserDefaults standardUserDefaults ]setObject:@"Navigation" forKey:@"Transaction"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    employerTransaction *obj_employerTransaction = [self.storyboard instantiateViewControllerWithIdentifier:@"employerTransaction"];
    [self.navigationController pushViewController:obj_employerTransaction animated:YES];
}


-(void)chatClicked
{
    [[NSUserDefaults standardUserDefaults ]setObject:@"Employer" forKey:@"Chat"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    employeeChat *obj_employeeChat = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeChat"];
    [self.navigationController pushViewController:obj_employeeChat animated:YES];
}

-(UIBarButtonItem *) RightBarButton
{
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
    _transaction = [[UIButton alloc]initWithFrame:CGRectMake(0, 6, 35, 24)];
    [_transaction setImage:[UIImage imageNamed:@"trans"] forState:UIControlStateNormal];
    [_transaction addTarget:self action: @selector(transactionClicked) forControlEvents:UIControlEventTouchUpInside];
    _chatSelected = [[UIButton alloc]initWithFrame:CGRectMake(55, 4, 32, 28)];
    [_chatSelected setImage:[UIImage imageNamed:@"chat_.png"] forState:UIControlStateNormal];
    _chatSelected.layer.masksToBounds = YES;
    
    [_chatSelected addTarget:self action:@selector(chatClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _chatBadge = [JSCustomBadge customBadgeWithString:@"" withStringColor:[UIColor redColor] withInsetColor:[UIColor redColor] withBadgeFrame:NO withBadgeFrameColor:[UIColor blueColor] withScale:1.0 withShining:NO withShadow:NO];
    
    _chatBadge.frame = CGRectMake(_chatSelected.frame.size.width+_chatSelected.frame.origin.x-15, _chatSelected.frame.origin.y, 20, 20);
    
    [rightView addSubview:_transaction];
    [rightView addSubview:_chatSelected];
    //[rightView addSubview:_chatBadge];
    
    return [[UIBarButtonItem alloc]initWithCustomView:rightView];
}

#pragma mark - Initialize -
-(void)intiallize{
    EmployerUserID   = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"];
    arraySelectedItems= [[NSMutableArray alloc] init];
    arrayCategoryList = [[NSMutableArray alloc] init];
    arrayCategoryId  = [[NSMutableArray alloc] init];
    self.btnAdd.layer.cornerRadius = self.btnAdd.frame.size.height /2;
    self.btnAdd.layer.masksToBounds = YES;
    [self unarchivingData];
   

    self.obj_MapView.myLocationEnabled = YES;
    self.obj_MapView.delegate = self;
}


#pragma mark - Unarchiving data -
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

- (void)checkPath:(GMSPath*)path {
    GMSVisibleRegion visibleRegion = _obj_MapView.projection.visibleRegion;
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithRegion: visibleRegion];
    
    for(int i = 0; i < path.count; i++) {
        CLLocationCoordinate2D coordinate=[path coordinateAtIndex:i];
        if([bounds containsCoordinate:coordinate]) {
            NSLog(@"Visible");
        }
    }
}

#pragma mark - topTapCreate -
-(void)topTabCreate
{
    int scrollWidh = 0;
    int distX = 10;
    int spacer = 10;
    
    nearByCount = 0;
    
    for(int i=0 ;i<[arrayCategoryList count];i++)
    {
        
        NSString *str_uppercase = [arrayCategoryList objectAtIndex:i];
        
        UIButton *btnAddTemp = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        [btnAddTemp setTitle:str_uppercase forState:UIControlStateNormal];
        
        [btnAddTemp sizeToFit];
        
        UIButton *btnAddActual = [[UIButton alloc]initWithFrame:CGRectMake(distX, 0, btnAddTemp.frame.size.width, 40)];
        [btnAddActual setTitle:str_uppercase forState:UIControlStateNormal];
        
        [btnAddActual setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        
        UIImageView *lineimage = [[UIImageView alloc]initWithFrame:CGRectMake(btnAddActual.frame.origin.x-spacer, 37, (btnAddTemp.frame.size.width+spacer*2)+1, 3)];
        
        
        lineimage.backgroundColor = [UIColor blueColor];
        
        UILabel *separatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(btnAddActual.frame.origin.x-spacer, 10, 1.0, 20)];
        separatorLabel.backgroundColor = [UIColor lightGrayColor];
        
        btnAddActual.tag =i;
        lineimage.tag =i;
        
        lineimage.hidden = YES;
        [btnAddActual addTarget:self action:@selector(tabSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_categoryScrollView addSubview:lineimage];
        [_categoryScrollView addSubview:btnAddActual];
        [_categoryScrollView addSubview:separatorLabel];
        
        if (i==arrayCategoryList.count-1)
        {
            UIButton *btnAddActualTemp = [[UIButton alloc]initWithFrame:CGRectMake(distX, 0, btnAddTemp.frame.size.width, 40)];
            [btnAddActualTemp setTitle:str_uppercase forState:UIControlStateNormal];
            
            [btnAddActualTemp addTarget:self action:@selector(btnActualTempForTagsPressed:) forControlEvents:UIControlEventTouchUpInside];
            btnAddActualTemp.tag =i;
            
            [_categoryScrollView addSubview:btnAddActualTemp];
        }
        distX += btnAddActual.frame.size.width+spacer*2;
    }
    
    UILabel *separatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(distX-spacer-1, 10, 1.0, 20)];
    separatorLabel.backgroundColor = [UIColor lightGrayColor];
    [_categoryScrollView addSubview:separatorLabel];
    
    scrollWidh = distX-spacer;
    
    _categoryScrollView.contentSize = CGSizeMake(scrollWidh, 40);
    
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = selectedTabNumber;
    [self tabSelectAction:btn];
}

#pragma mark btnAddActualTemp -
- (void)btnActualTempForTagsPressed:(UIButton *)sender
{
    [self performSelector:@selector(tabSelectAction:) withObject:sender afterDelay:0.01];
    
}
#pragma mark - tabSelect Method -
-(IBAction)tabSelectAction:(UIButton*)sender
{
    nearByCount = nearByCount+1;
    
    if(self.view.userInteractionEnabled == NO)
    {
        return;
    }
    
    lastSelectedIndex = selectedTabNumber;
    
    selectedtag = ((UIButton *)sender).tag;
    
    
    for(UIView * subView in _categoryScrollView.subviews )
    {
        if([subView isKindOfClass:[UIImageView class]])
        {
            if(selectedtag == subView.tag)
            {
                subView.hidden = NO;
                
                selectedTabNumber= selectedtag;
            }
            else
            {
                subView.hidden = YES;
            }
        }
        
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton*)subView;
            
            if(selectedtag == subView.tag){
                
                [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                subView.hidden = NO;
            }
            else{
                [btn setTitleColor:[UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            }
        }
    }
    
    if (lastSelectedIndex>selectedTabNumber)
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        [_obj_MainTableView beginUpdates];
        [_obj_MainTableView.layer addAnimation:transition forKey:nil];
        [_obj_MainTableView endUpdates];
        
        [_obj_MainTableView reloadData];
    }
    else if (lastSelectedIndex<selectedTabNumber)
    {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [_obj_MainTableView beginUpdates];
        [_obj_MainTableView.layer addAnimation:transition forKey:nil];
        [_obj_MainTableView endUpdates];
        
        [_obj_MainTableView reloadData];
    }
    
    int spacer= 10;
    for(UIButton * subView in _categoryScrollView.subviews)
    {
        if([subView isKindOfClass:[UIButton class]])
        {
            if(selectedtag == subView.tag)
            {
                CGRect visibleRect = CGRectMake(subView.frame.origin.x-spacer, subView.frame.origin.y, subView.frame.size.width+2*spacer, subView.frame.size.height);
                [_categoryScrollView scrollRectToVisible:visibleRect animated:YES];
            }
            else
            {
                [subView setTitleColor:[UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            }
            
        }
    }
    
    if (nearByCount>1) {
        if ([GlobalMethods InternetAvailability]) {
            [self nearByEmployeesSelected:selectedtag];
        }else{
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
        }
    }
}

#pragma mark - swipe gesture to slide between view -
-(void)slideToRightWithGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if(selectedTabNumber == 0)
    {
        
    }
    else
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = selectedTabNumber-1;
        [self tabSelectAction:btn];
        
    }
}

-(void)slideToLeftWithGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if(selectedTabNumber == [arrayCategoryList count]-1)
    {
        
    }
    else
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = selectedTabNumber+1;
        [self tabSelectAction:btn];
        
        
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(self.view.userInteractionEnabled == NO)
    {
        return NO;
    }
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    
    if ([touch.view isKindOfClass:[UIControl class]])
    {
        return NO;
    }
    return YES;
}
-(void)enableUserInteractionForView:(id)sender
{
    self.view.userInteractionEnabled = YES;
}



@end
