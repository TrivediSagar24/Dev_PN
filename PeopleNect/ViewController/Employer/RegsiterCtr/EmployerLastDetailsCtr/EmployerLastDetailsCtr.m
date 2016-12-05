//
//  EmployerLastDetailsCtr.m
//  PeopleNect
//
//  Created by Apple on 11/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "EmployerLastDetailsCtr.h"

@interface EmployerLastDetailsCtr (){
    UIToolbar *obj_ToolBar;
    UIDatePicker *obj_StartDatePicker,*obj_EndDatePicker,*obj_StartHourPicker, *obj_EndHourPicker;
    NSMutableDictionary *parameterDictionary;
    NSInteger workingDay,sameLocation;
    float totalhours,totalAmount;
    NSDateFormatter *dateFormatter,*hourFormatter;
    int count,diff,hourDay ;
    BOOL flagImg1,LAST;
    NSString *startDate,*endDate,*fordatePickerStart ,*fordatePickerEnd,*totalHourMessage;
    NSInteger excludingWeekDay,includingWeekDay,noEndDate;
    NSArray *json;
    CLLocationCoordinate2D Location;
    CGFloat addressViewHeight,containerHeight;
}
@end

@implementation EmployerLastDetailsCtr
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
   
    dispatch_async(dispatch_get_main_queue(), ^{
    [self Initial];
    });
    
    workingDay = 0;
    noEndDate=0;
    sameLocation = 1;
    
    self.tfTotallPay.text = [NSString stringWithFormat:@"$0"];
    self.btnCheckBox2.selected = YES;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"PostJob"] isEqualToString:@"last"]){
        
//        _tfJobTitle.enabled = NO;
//        _tvJobDescription.userInteractionEnabled = NO;
//        _btnCheckBox1.userInteractionEnabled = NO;
//        _btnCheckBox2.userInteractionEnabled  = NO;
//        _tfHoursPerDay.enabled = NO;
//        _tfMoneyPerHour.enabled = NO;
//        _addBtn.userInteractionEnabled = NO;
//        _subtractBtn.userInteractionEnabled = NO;
        
        [self jobDetailbyId];
       
        LAST = YES;
    }
    
    [self unarchivingData];
    
    _companyAddresslbl.text = kAppDel.obj_responseDataOC.employerCompanyAddress;
    
    _tfStreetName.placeSearchDelegate = self;
    _tfStreetName.delegate = self;
    _tfStreetName.strApiKey = @"AIzaSyB9U-Ssv6A9Tt2keQtZyWMuadHoELYeGlk";
    
    _tfStreetName.superViewOfList = self.view;
    _tfStreetName.autoCompleteShouldHideOnSelection = YES;
    _tfStreetName.maximumNumberOfAutoCompleteRows = 5;
    
    _addressView.hidden = YES;
    
    _addressViewHeightConstraints.constant = 0;
    
    [self.view layoutIfNeeded];

    addressViewHeight = kDEV_PROPROTIONAL_Height(244);
    
    _profileImage.layer.cornerRadius = kDEV_PROPROTIONAL_Height(96)/2;
    
    _profileImage.layer.masksToBounds = YES;
    
    if (_isFrominVitedScreen == YES) {
        [_profileImage sd_setImageWithURL:[NSURL URLWithString:_employeeProfielImage] placeholderImage:[UIImage imageNamed:@"profile"]] ;
        _lastDetailsLbl.text = _employeeName;
        _starView.hidden = NO;
    }else{
        _lastDetailsLbl.text = @"Last Details";
        _starView.hidden = YES;

        if (LAST==YES) {
            
        [_profileImage sd_setImageWithURL:[NSURL URLWithString:_repostProfileURL] placeholderImage:[UIImage imageNamed:@"profile"]];
        }
        else{
            
            if (kAppDel.EmployerProfileImage==nil) {
                _profileImage.image = [UIImage imageNamed:@"profile"];
            }
            else{
                _profileImage.image = kAppDel.EmployerProfileImage;
            }
        }
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"Gray_right_arrow_"];
}




-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _tfStreetName.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    _tfStreetName.autoCompleteBoldFontName = @"HelveticaNeue";
    _tfStreetName.autoCompleteTableCornerRadius=0.0;
    _tfStreetName.autoCompleteRowHeight=35;
    _tfStreetName.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    _tfStreetName.autoCompleteFontSize=14;
    _tfStreetName.autoCompleteTableBorderWidth=1.0;
    _tfStreetName.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    _tfStreetName.autoCompleteShouldHideOnSelection=YES;
    _tfStreetName.autoCompleteShouldHideClosingKeyboard=YES;
    _tfStreetName.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    _tfStreetName.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_tfStreetName.frame.size.width)*0.5, 0, _tfStreetName.frame.size.width, 100.0);
    
}


#pragma mark - Navigation Back Button -
-(void)barBackButton{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"PostJob"] isEqualToString:@"last"]) {
        
        for (UIViewController *viewControllrObj in self.navigationController.viewControllers){
            
            if ([viewControllrObj isKindOfClass:[repostJobEmployerCtr class]]){
                [self.navigationController popToViewController:viewControllrObj animated:YES];
            }
        }
    }
    else{
        for (UIViewController *viewControllrObj in self.navigationController.viewControllers){
            if ([viewControllrObj isKindOfClass:[subCategoryCtr class]]){
                [self.navigationController popToViewController:viewControllrObj animated:YES];
            }
        }
    }
    if (_isFrominVitedScreen==YES) {
        for (UIViewController *viewControllrObj in self.navigationController.viewControllers){
            if ([viewControllrObj isKindOfClass:[employerInviteForJobVC class]]){
                [self.navigationController popToViewController:viewControllrObj animated:YES];
            }
        }
    }
}



#pragma mark - TextField Delegates -
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == self.tfStartDate){
        [self.tfStartDate setInputView:obj_StartDatePicker];
        self.tfStartDate.inputAccessoryView =[self toolBar];
        obj_StartDatePicker.datePickerMode = UIDatePickerModeDate;
         [obj_StartDatePicker addTarget:self action:@selector(datePickerDidChangeStartDate:) forControlEvents:UIControlEventValueChanged];
    }
    if(textField == self.tfEndDate){
        [self.tfEndDate setInputView:obj_EndDatePicker];
        self.tfEndDate.inputAccessoryView =[self toolBar];
        obj_EndDatePicker .datePickerMode = UIDatePickerModeDate;
        [obj_EndDatePicker addTarget:self action:@selector(datePickerDidChangeEndDate:) forControlEvents:UIControlEventValueChanged];
    }
    if(textField == self.tfStartHour){
        [self.tfStartHour setInputView:obj_StartHourPicker];
        self.tfStartHour.inputAccessoryView =[self toolBar];
        obj_StartHourPicker .datePickerMode = UIDatePickerModeTime;
         [obj_StartHourPicker addTarget:self action:@selector(datePickerDidChangeStartHour:) forControlEvents:UIControlEventValueChanged];
    }
    if(textField == self.tfEndHour){
        [self.tfEndHour setInputView:obj_EndHourPicker];
        self.tfEndHour.inputAccessoryView =[self toolBar];
        obj_EndHourPicker .datePickerMode = UIDatePickerModeTime;
        [obj_EndHourPicker addTarget:self action:@selector(datePickerDidChangeEndHour:) forControlEvents:UIControlEventValueChanged];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
     NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
if (textField==_tfHoursPerDay || textField ==_tfMoneyPerHour) {
        NSRange spaceRange = [string rangeOfString:@" "];
        if (spaceRange.location != NSNotFound){
            return NO;
        }
        if ([string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet].location != NSNotFound){
            return NO;
        }
    }
    if(self.tfStartDate.text.length>0 && self.tfEndDate.text.length >0 && self.tfHoursPerDay.text.length >0){
        if (noEndDate==0) {
            [self calculateTimePrice:newString];
        }
    }
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField ==self.tfHoursPerDay){
        
        hourDay = [_tfHoursPerDay.text intValue];
        hourDay = hourDay *3600;
        
        if (hourDay>diff) {
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Please enter Valid Time" Message:[NSString stringWithFormat:@" you can enter time upto %@ hour",totalHourMessage] AlertMessage:@"OK"] animated:YES completion:nil];
        }
    }
    if (textField==_tfEndHour) {
        diff =    [obj_EndHourPicker.date timeIntervalSinceReferenceDate] - [obj_StartHourPicker.date timeIntervalSinceReferenceDate];
        totalHourMessage = [self timeFormatted:diff];
    }
    
    if(self.tfStartDate.text.length>0 && self.tfEndDate.text.length >0 && self.tfHoursPerDay.text.length >0 && self.tfMoneyPerHour.text.length>0){
         if (noEndDate==0) {
             [self calculateTimePrice:_tfMoneyPerHour.text];
         }
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.tfJobTitle){
        [theTextField resignFirstResponder];
        [self.tvJobDescription becomeFirstResponder];
    }
    else if (theTextField == self.tfStartDate){
        [ self.tfStartDate resignFirstResponder];
        [ self.tfEndDate becomeFirstResponder];
    }
    else if (theTextField ==  self.tfEndDate){
        [self.tfEndDate resignFirstResponder];
        [self.tfStartHour becomeFirstResponder];
    }
    else if (theTextField ==self.tfStartHour ){
        [self.tfStartHour resignFirstResponder];
        [self.tfEndHour becomeFirstResponder];
    }
    else if (theTextField == self.tfEndHour){
        [self.tfEndHour resignFirstResponder];
    }
    else if (theTextField == self.tfHoursPerDay){
        [ self.tfHoursPerDay resignFirstResponder];
        [ self.tfMoneyPerHour becomeFirstResponder];
    }
    else if(theTextField == self.tfMoneyPerHour ){
        [self.tfMoneyPerHour resignFirstResponder];
    }
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}



#pragma  mark - Selector datePickerDidChangeDate -
- (void)datePickerDidChangeStartDate:(UIDatePicker *)sender {
    self.tfStartDate.text = [dateFormatter stringFromDate:sender.date];
}


- (void)datePickerDidChangeEndDate:(UIDatePicker *)sender {
    
    fordatePickerStart = [dateFormatter stringFromDate:obj_StartDatePicker.date];
    
    fordatePickerEnd = [dateFormatter stringFromDate:sender.date];
    
    if ([fordatePickerStart compare:fordatePickerEnd] == NSOrderedAscending) {
        self.tfEndDate.text = [dateFormatter stringFromDate:sender.date];
    }
}


-(void)datePickerDidChangeEndHour :(UIDatePicker *)sender{
    startDate = [hourFormatter stringFromDate:obj_StartHourPicker.date];
   endDate = [hourFormatter stringFromDate:sender.date];
    if ([startDate compare:endDate] == NSOrderedAscending) {
        self.tfEndHour.text = [hourFormatter stringFromDate:sender.date];
    }
}


-(void)datePickerDidChangeStartHour:(UIDatePicker *)sender{
    self.tfStartHour.text = [hourFormatter stringFromDate:sender.date];
}


#pragma  mark - ToolBarDatePicker
-(UIView *)toolBar{
     obj_ToolBar = [[UIToolbar alloc] initWithFrame: CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,45)];
    obj_ToolBar.barStyle = UIBarStyleDefault;
    obj_ToolBar.barTintColor = [UIColor whiteColor];
    UIBarButtonItem *btnNext = [[UIBarButtonItem alloc] initWithTitle:@"NEXT" style:UIBarButtonItemStylePlain target:self action:@selector(nextAction)];
    [btnNext setTintColor:[UIColor blackColor]];
    UIBarButtonItem *spaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [obj_ToolBar setItems:[NSArray arrayWithObjects:spaceLeft,btnNext, nil] animated:YES];
    return obj_ToolBar;
}



-(void)nextAction{
    BOOL start = [self.tfStartDate isFirstResponder];
    BOOL end = [self.tfEndDate isFirstResponder];
    BOOL endHour = [self.tfEndHour isFirstResponder];
    BOOL startHour = [self.tfStartHour isFirstResponder];
    if(start==YES){
        _tfStartDate.text =[dateFormatter stringFromDate:obj_StartDatePicker.date];
        [self.tfStartDate resignFirstResponder];
        [self.tfEndDate becomeFirstResponder];
    }
    if(end==YES){
        
        fordatePickerStart = [dateFormatter stringFromDate:obj_StartDatePicker.date];
        
        fordatePickerEnd = [dateFormatter stringFromDate:obj_EndDatePicker.date];
        if ([fordatePickerStart compare:fordatePickerEnd] == NSOrderedSame) {
            _tfEndDate.text =[dateFormatter stringFromDate:obj_EndDatePicker.date];
        }
        
        else{
        if ([fordatePickerStart compare:fordatePickerEnd] == NSOrderedAscending) {
            _tfEndDate.text =[dateFormatter stringFromDate:obj_EndDatePicker.date];
        }else{
            [self presentViewController:[GlobalMethods AlertWithTitle:@"" Message:@"Date must be greater than startdate" AlertMessage:@"OK"] animated:YES completion:nil];
        }
    }
        [self.tfEndDate resignFirstResponder];
        [self.tfStartHour becomeFirstResponder];
    }
    if(startHour==YES){
        _tfStartHour.text = [hourFormatter stringFromDate:obj_StartHourPicker.date];
        [self.tfStartHour resignFirstResponder];
        [self.tfEndHour becomeFirstResponder];
    }
    if(endHour==YES){
        startDate = [hourFormatter stringFromDate:obj_StartHourPicker.date];
        endDate = [hourFormatter stringFromDate:obj_EndHourPicker.date];
        
        if ([startDate compare:endDate] == NSOrderedAscending) {
            _tfEndHour.text = [hourFormatter stringFromDate:obj_EndHourPicker.date];
            diff =    [obj_EndHourPicker.date timeIntervalSinceReferenceDate] - [obj_StartHourPicker.date timeIntervalSinceReferenceDate];
            
            totalHourMessage = [self timeFormatted:diff];
        } else {
            [self presentViewController:[GlobalMethods AlertWithTitle:@"" Message:@"Time must be greater than starttime" AlertMessage:@"OK"] animated:YES completion:nil];
        }
        [self.tfEndHour resignFirstResponder];
    }
}


- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 100, 5);
}


- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 5, 100);
}

#pragma mark - Place search Textfield Delegates -
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict{
    [self.view endEditing:YES];
    Location = responseDict.coordinate;
    NSString *req = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",Location.latitude,Location.longitude];
    if ([GlobalMethods InternetAvailability]) {
        [self usingNsurljsonParsing:req];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}


-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField{
}


-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField{
}


-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index{
    if(index%2==0){
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - IBActions -
- (IBAction)noEndDateClicked:(id)sender {
    self.noEndDateBtn.selected = !self.noEndDateBtn.selected;
    if(self.noEndDateBtn.selected){
        noEndDate = 1;
        _tfEndDate.hidden=YES;
        _tfEndDate.text = @"Date";
    }
    else{
        noEndDate=0;
        if ([_tfEndDate.text isEqualToString:@"Date"]) {
            _tfEndDate.text = @"";
        }
        _tfEndDate.hidden = NO;
    }
}

- (IBAction)onClickAdd:(id)sender {
    
    count ++;
    self.lblCounter.text = [NSString stringWithFormat:@"%d",count];
}


- (IBAction)onClickSubtract:(id)sender {
    if(count>1){
    count --;
    self.lblCounter.text = [NSString stringWithFormat:@"%d",count];
    }
}


#pragma mark - workingDay selected -
- (IBAction)onClickCheckBox1:(id)sender {
  self.btnCheckBox1.selected = !self.btnCheckBox1.selected;
    if(self.btnCheckBox1.selected){
        workingDay = 1;
        if(self.tfStartDate.text.length>0 && self.tfEndDate.text.length >0 && self.tfHoursPerDay.text.length >0 && self.tfMoneyPerHour.text.length>0){
            if (noEndDate==0) {
                [self calculateTimePrice:_tfMoneyPerHour.text];
        }        }
    }
    else{
    workingDay = 0;
        if(self.tfStartDate.text.length>0 && self.tfEndDate.text.length >0 && self.tfHoursPerDay.text.length >0 && self.tfMoneyPerHour.text.length>0){
            if (noEndDate==0) {
                [self calculateTimePrice:_tfMoneyPerHour.text];
            }        }
    }
}


#pragma mark - Same location selected -
- (IBAction)onClickCheckBox2:(id)sender {
    
  self.btnCheckBox2.selected = !self.btnCheckBox2.selected;
    
    if(self.btnCheckBox2.selected){
            sameLocation = 1;
            _addressView.hidden = YES;
            _addressViewHeightConstraints.constant = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];

        } completion:^(BOOL finished) {
            
        }];
    }
    else{
            sameLocation = 0;
            _addressView.hidden = NO;
            _addressViewHeightConstraints.constant = addressViewHeight;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
        }];
    }
}


#pragma mark - finish job selected -
- (IBAction)onClickFinishJobPost:(id)sender {
    
    if (noEndDate==1) {
        _tfEndDate.text = @"Date";
    }
    
if (_tfJobTitle.text.length==0) {
    [self presentViewController:[GlobalMethods AlertWithTitle:@"Job title is required" Message:@"Please enter the job title" AlertMessage:@"OK"] animated:YES completion:nil];
}else{
 if (_tvJobDescription.text.length==0) {
    [self presentViewController:[GlobalMethods AlertWithTitle:@"JobDescription is required" Message:@"Please enter the job description" AlertMessage:@"OK"] animated:YES completion:nil];
    }else{
        if (_tfStartDate.text.length==0) {
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Start date  is required" Message:@"Please enter the  start date" AlertMessage:@"OK"] animated:YES completion:nil];
        }else{
            if (_tfEndDate.text.length==0) {
            [self presentViewController:[GlobalMethods AlertWithTitle:@"End date  is required" Message:@"Please enter the  end date" AlertMessage:@"OK"] animated:YES completion:nil];
            }else{
            if (_tfStartHour.text.length==0) {
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Start hour  is required" Message:@"Please enter the  start hour" AlertMessage:@"OK"] animated:YES completion:nil];
            }else{
                if (self.tfEndHour.text.length==0){
                [self presentViewController:[GlobalMethods AlertWithTitle:@"End hour  is required" Message:@"Please enter the  end hour" AlertMessage:@"OK"] animated:YES completion:nil];
                }else{
                    if (self.tfHoursPerDay.text.length==0){
                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Hours per day  is required" Message:@"Please enter the  hours per day" AlertMessage:@"OK"] animated:YES completion:nil];
                    }else{
                    if (self.tfMoneyPerHour.text.length==0){
                        [self presentViewController:[GlobalMethods AlertWithTitle:@"Hours per day  is required" Message:@"Please enter the  hours per day" AlertMessage:@"OK"] animated:YES completion:nil];
                    }else{
                        if (hourDay>diff) {
                            [self presentViewController:[GlobalMethods AlertWithTitle:@"Please enter Valid Time" Message:[NSString stringWithFormat:@" you can enter time upto %@ hour",totalHourMessage] AlertMessage:@"OK"] animated:YES completion:nil];
                        }
                        else{
                        if (_isFrominVitedScreen==YES){
                        if (kAppDel.obj_jobPostingPriceBalance.jobPostingPrice <=kAppDel.obj_jobPostingPriceBalance.balance) {
                                [self postJobById];
                            }
                        else{
                                noBalance *noBalance = [self.storyboard instantiateViewControllerWithIdentifier:@"noBalance"];
                                UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:noBalance];
                                obj_nav.definesPresentationContext = YES;
                                obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
                                [self presentViewController:obj_nav animated:YES completion:nil];
                            }
                            
                            }
                    else{
                                
                    if (kAppDel.obj_jobPostingPriceBalance.jobPostingPrice <=kAppDel.obj_jobPostingPriceBalance.balance) {
                        [self PostJob];
                    }
                    else{
                    noBalance *noBalance = [self.storyboard instantiateViewControllerWithIdentifier:@"noBalance"];
                    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:noBalance];
                        obj_nav.definesPresentationContext = YES;
                    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
                    [self presentViewController:obj_nav animated:YES completion:nil];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}}}
}


#pragma mark - btnCameraClicked -
- (IBAction)btnCameraClicked:(id)sender{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate =self;
    _imagePicker.allowsEditing = YES;
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
                                    _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                    [self presentViewController:_imagePicker animated:YES completion:nil];
                                }
                                else
                                {
                                    [self presentViewController:[GlobalMethods AlertWithTitle:@"Camera missing" Message:@"It seems that no camera is attached to this device" AlertMessage:@"OK"]animated:YES completion:nil];
                                }
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                            {
                                _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                [self presentViewController:_imagePicker animated:YES completion:nil];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}


#pragma mark - _imagePicker Delegates.
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    kAppDel.EmployerProfileImage = chosenImage;
    _profileImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - PostJobByID -
-(void)postJobById{
    
    if ([GlobalMethods InternetAvailability]) {
       
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        
        [_param setObject:@"postJobById" forKey:@"methodName"];

        [_param setObject:self.tfJobTitle.text forKey:@"jobTitle"];
    
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
       
        [_param setObject:self.categoryId forKey:@"categoryId"];
        
        [_param setObject:self.subCategoryId forKey:@"subCategoryId"];
        
        [_param setObject:_tvJobDescription.text forKey:@"description"];

        [_param setObject:_employeeID forKey:@"assignJobseekerId"];
       
        [_param setObject:_tfStartDate.text forKey:@"startDate"];

        if (noEndDate==0) {
            [_param setObject:self.tfEndDate.text forKey:@"endDate"];
        }else{
            [_param setObject:@"" forKey:@"endDate"];
        }

        [_param setObject:_tfStartHour.text forKey:@"startHour"];

        [_param setObject:_tfEndHour.text forKey:@"endHour"];

        [_param setObject:[NSNumber numberWithFloat:totalhours] forKey:@"totalHours"];

        [_param setObject:[NSNumber numberWithInteger:workingDay] forKey:@"workingDay"];

        
        [_param setObject:self.tfHoursPerDay.text forKey:@"hoursPerDay"];

        [_param setObject:_tfMoneyPerHour.text forKey:@"rate"];

        [_param setObject:[NSNumber numberWithInteger:totalAmount ] forKey:@"totalAmount"];
        
        [_param setObject:[NSNumber numberWithInteger:sameLocation] forKey:@"sameLocationOfTheCompany"];

        if (sameLocation == 1) {
            
            [_param setObject:@"" forKey:@"streetName"];
            [_param setObject:@"" forKey:@"zip"];
            [_param setObject:@"" forKey:@"state"];
            [_param setObject:@"" forKey:@"city"];
            [_param setObject:@"" forKey:@"address1"];
            [_param setObject:@"" forKey:@"address2"];
            
        }else{
            [_param setObject:_tfStreetName.text forKey:@"streetName"];
            [_param setObject:_tfZipCode.text forKey:@"zip"];
            [_param setObject:_tfState.text forKey:@"state"];
            [_param setObject:_tfCity.text forKey:@"city"];
            [_param setObject:_tfStreetNumber.text forKey:@"address1"];
            [_param setObject:_tfComplement.text forKey:@"address2"];
        }
        
        [_param setObject:[NSNumber numberWithInteger:noEndDate] forKey:@"long_term_job"];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [kAppDel.progressHud hideAnimated:YES];
            
            [self AlertAction:[responseObject valueForKey:@"message"]];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}


#pragma mark - PostJob -
-(void)PostJob{
    if ([GlobalMethods InternetAvailability]) {
        
        parameterDictionary = [[NSMutableDictionary alloc] init];
        
        [parameterDictionary setObject:@"postJob" forKey:@"methodName"];
        
        [parameterDictionary setObject:self.tfJobTitle.text forKey:@"jobTitle"];
        
        [parameterDictionary setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
        
        [parameterDictionary setObject:self.categoryId forKey:@"categoryId"];
        
        [parameterDictionary setObject:self.subCategoryId forKey:@"subCategoryId"];
        
        [parameterDictionary setObject:self.tvJobDescription.text forKey:@"description"];
        
        [parameterDictionary setObject:self.lblCounter.text forKey:@"noOfPosition"];
        
        [parameterDictionary setObject:self.tfStartDate.text forKey:@"startDate"];
        
        if (noEndDate==0) {
            [parameterDictionary setObject:self.tfEndDate.text forKey:@"endDate"];
        }else{
        [parameterDictionary setObject:@"" forKey:@"endDate"];
        }
        
        [parameterDictionary setObject:[NSNumber numberWithInteger:totalhours] forKey:@"totalHours"];
        
        [parameterDictionary setObject:self.tfStartHour.text forKey:@"startHour"];
        
        [parameterDictionary setObject:self.tfEndHour.text forKey:@"endHour"];
        [parameterDictionary setObject:[NSNumber numberWithInteger:workingDay] forKey:@"workingDay"];
        
        [parameterDictionary setObject:self.tfHoursPerDay.text forKey:@"hoursPerDay"];
        
        [parameterDictionary setObject:self.tfMoneyPerHour.text forKey:@"rate"];
        
        [parameterDictionary setObject:[NSNumber numberWithInteger:totalAmount ] forKey:@"totalAmount"];
        
        [parameterDictionary setObject:[NSNumber numberWithInteger:sameLocation] forKey:@"sameLocationOfTheCompany"];
        
        if (sameLocation == 1) {
            
            [parameterDictionary setObject:@"" forKey:@"streetName"];
            [parameterDictionary setObject:@"" forKey:@"zip"];
            [parameterDictionary setObject:@"" forKey:@"state"];
            [parameterDictionary setObject:@"" forKey:@"city"];
            [parameterDictionary setObject:@"" forKey:@"address1"];
            [parameterDictionary setObject:@"" forKey:@"address2"];
            
        }else{
            
            [parameterDictionary setObject:_tfStreetName.text forKey:@"streetName"];
            [parameterDictionary setObject:_tfZipCode.text forKey:@"zip"];
            [parameterDictionary setObject:_tfState.text forKey:@"state"];
            [parameterDictionary setObject:_tfCity.text forKey:@"city"];
            [parameterDictionary setObject:_tfStreetNumber.text forKey:@"address1"];
            [parameterDictionary setObject:_tfComplement.text forKey:@"address2"];
        }
        
        [parameterDictionary setObject:[NSNumber numberWithFloat:totalhours] forKey:@"journeyHours"];
        
        [parameterDictionary setObject:[NSNumber numberWithInteger:noEndDate] forKey:@"long_term_job"];
        
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        
        
        [kAFClient POST:MAIN_URL parameters:parameterDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [kAppDel.progressHud hideAnimated:YES];
            
            [self AlertAction:[responseObject valueForKey:@"message"]];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}


#pragma mark - Unarchiving data
-(void)unarchivingData{
    NSData *registerData= [[NSUserDefaults standardUserDefaults] objectForKey:@"employerRegister"];
    if (registerData!=nil) {
        kAppDel.obj_responseDataOC = [NSKeyedUnarchiver unarchiveObjectWithData:registerData];
    }
    else{
    NSData *loginObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"employerLogin"];
    if (loginObject!=nil) {
        kAppDel.obj_responseDataOC = [NSKeyedUnarchiver unarchiveObjectWithData:loginObject];
        }
    }
    
    NSData *Balance =[[NSUserDefaults standardUserDefaults] objectForKey:@"jobPostingPriceBalance"];
    
    if (Balance!=nil) {
        kAppDel.obj_jobPostingPriceBalance = [NSKeyedUnarchiver unarchiveObjectWithData:Balance];
    }
}

#pragma mark - AlertAction -
-(void)AlertAction:(NSString*)Message{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:Message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                        
                          MenuCtr *obj_MenuCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuCtr"];
                          
                          [self.navigationController pushViewController:obj_MenuCtr animated:YES];
                      }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - Initial -
-(void)Initial{
    obj_EndDatePicker  = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,44,[UIScreen mainScreen].bounds.size.width, 253)];
    obj_StartDatePicker  = [[UIDatePicker alloc] initWithFrame:obj_EndDatePicker.frame];
    obj_StartDatePicker.minimumDate = [NSDate date];
    obj_EndDatePicker.minimumDate = [NSDate date];
    obj_StartHourPicker  = [[UIDatePicker alloc] initWithFrame:obj_EndDatePicker.frame];
    obj_EndHourPicker  = [[UIDatePicker alloc] initWithFrame:obj_EndDatePicker.frame];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    hourFormatter = [[NSDateFormatter alloc] init];
    [hourFormatter setDateFormat:@"HH:mm"];
    count = 1;
}

#pragma mark - timeFormatted -
- (NSString *)timeFormatted:(int)totalSeconds{
//    int seconds = totalSeconds % 60;
//    int minutes = (totalSeconds / 60) % 60;
   int hours = totalSeconds / 3600;
    
//    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    
    return [NSString stringWithFormat:@"%2d",hours];
}



#pragma mark - weekDaysFromCurrentDays -
-(void)weekDaysFromCurrentDays{
     excludingWeekDay = 0;
    includingWeekDay = 0;
    NSInteger sunday = 1;
    NSInteger saturday = 7;
    NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay:1];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [dateFormatter dateFromString:_tfStartDate.text];
    while ([currentDate compare:[dateFormatter dateFromString:_tfEndDate.text]] == NSOrderedAscending) {
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday fromDate:currentDate];
        if (dateComponents.weekday != saturday && dateComponents.weekday != sunday) {
            excludingWeekDay++;
        }
        includingWeekDay++;
        currentDate = [calendar dateByAddingComponents:oneDay
                                                toDate:currentDate
                                               options:0];
    }
}


#pragma mark - usingNsurljsonParsing -
-(void)usingNsurljsonParsing:(NSString *)urlAsString
{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    NSString *encodedUrlAsString = [urlAsString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error){
    if ([response isKindOfClass:[NSHTTPURLResponse class]]){
        NSError *jsonError;
        json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError){
            } else{
        dispatch_async(dispatch_get_main_queue(), ^(void){
        NSArray *StateCity = [[json valueForKey:@"results"]valueForKey:@"address_components"];
                                
        NSMutableDictionary *dict = [StateCity objectAtIndex:0];
                                
    for (int i = 0; i<dict.count; i++) {
                                    
    NSArray *type = [[dict valueForKey:@"types"]objectAtIndex:i];
    if ([type containsObject:@"administrative_area_level_1"]) {
        _tfState.text = [[dict valueForKey:@"long_name"]objectAtIndex:i];
                    }
    if ([type containsObject:@"administrative_area_level_2"]) {
        _tfCity.text = [[dict valueForKey:@"long_name"]objectAtIndex:i];
                    }
    if ([type containsObject:@"postal_code"]) {
        _tfZipCode.text = [[dict valueForKey:@"long_name"]objectAtIndex:i];
                    }
                    }
                });
            }
        }
    } else{
            }
    }] resume];
}


#pragma mark - Calculating Total hour&Price -
-(void)calculateTimePrice:(NSString*)MoneyPerHour{
    
    [self weekDaysFromCurrentDays];
    
    if (workingDay==0) {
        if (excludingWeekDay==0) {
            excludingWeekDay =1;
        }
        totalhours = excludingWeekDay * [_tfHoursPerDay.text intValue];
        totalAmount =  totalhours *[MoneyPerHour intValue];
    }
    if (workingDay==1) {
        if (includingWeekDay==0) {
            includingWeekDay =1;
        }
        totalhours = includingWeekDay * [_tfHoursPerDay.text  intValue];
        totalAmount = totalhours *[MoneyPerHour intValue];
    }
    self.tfTotallPay.text = [NSString stringWithFormat:@"$%ld",(long)totalAmount];
}


#pragma mark -jobDetailbyId -
-(void)jobDetailbyId{
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setObject:@"jobDetailbyId" forKey:@"methodName"];
        
    [param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
        
        [param setObject:_jobId forKey:@"jobId"];
        
        [param setObject:@"" forKey:@"jobSeekerId"];
       
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        
        [kAFClient POST:MAIN_URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        _tfJobTitle.text = [[responseObject valueForKey:@"data"]valueForKey:@"jobTitle"];
        _tvJobDescription.text = [[responseObject valueForKey:@"data"]valueForKey:@"jobDescription"];
        
        self.lblCounter.text  =[[responseObject valueForKey:@"data"]valueForKey:@"position"];
            
        count = [[[responseObject valueForKey:@"data"]valueForKey:@"position"]intValue];
      
        noEndDate =(NSInteger)[[responseObject valueForKey:@"data"]valueForKey:@"long_term_job"];
            
            if (noEndDate==1) {
                _tfEndDate.hidden=YES;
                _tfEndDate.text = @"Date";
            }
            
        _tfStartDate.text = [[responseObject valueForKey:@"data"]valueForKey:@"start_date"];
        _tfEndDate.text = [[responseObject valueForKey:@"data"]valueForKey:@"end_date"];
        _tfStartHour.text = [[responseObject valueForKey:@"data"]valueForKey:@"start_hour"];
        _tfEndHour.text = [[responseObject valueForKey:@"data"]valueForKey:@"end_hour"];

    workingDay = (NSInteger)[[responseObject valueForKey:@"data"]valueForKey:@"working_day"];
            
            if (workingDay==1) {
                self.btnCheckBox1.selected = YES;
            }
            _tfHoursPerDay.text = [[responseObject valueForKey:@"data"]valueForKey:@"hoursPerDay"];
            
            _tfHoursPerDay.text = [[responseObject valueForKey:@"data"]valueForKey:@"hoursPerDay"];
            
            _tfMoneyPerHour.text =   [[responseObject valueForKey:@"data"]valueForKey:@"hourlyRate"];
            
            totalhours = [[[responseObject valueForKey:@"data"]valueForKey:@"totalHour"] floatValue];
            
           _categoryId =[[responseObject valueForKey:@"data"]valueForKey:@"categoryId"];
            
            _subCategoryId =[[responseObject valueForKey:@"data"]valueForKey:@"subCategoryId"];
            
            sameLocation = [[[responseObject valueForKey:@"data"]valueForKey:@"same_as_company_location"]intValue];
            
            if (sameLocation==1) {
                self.btnCheckBox2.selected = NO;
                
                sameLocation = 0;
                _addressView.hidden = NO;
                _addressViewHeightConstraints.constant = addressViewHeight;
                [UIView animateWithDuration:0.5 animations:^{
                    [self.view layoutIfNeeded];
                    
                } completion:^(BOOL finished) {
                    
                }];
            }
            
            _tfStreetName.text = [[responseObject valueForKey:@"data"]valueForKey:@"streetName"];
            _tfStreetNumber.text = [[responseObject valueForKey:@"data"]valueForKey:@"address1"];
            _tfComplement.text = [[responseObject valueForKey:@"data"]valueForKey:@"address2"];
            _tfZipCode.text = [[responseObject valueForKey:@"data"]valueForKey:@"zip"];
            _tfState.text = [[responseObject valueForKey:@"data"]valueForKey:@"state"];
            _tfCity.text = [[responseObject valueForKey:@"data"]valueForKey:@"city"];
            
            [kAppDel.progressHud hideAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
   
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];

    }
}
@end
