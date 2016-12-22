//
//  seeDetailsNotification.m
//  PeopleNect
//
//  Created by Narendra Pandey on 07/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "seeDetailsNotification.h"

@interface seeDetailsNotification ()
{
    UIGestureRecognizer *seeDetailsGesture;
    NSString *startDate, *endDate;
    NSDate *start, *end;
}
@end

@implementation seeDetailsNotification
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
   seeDetailsGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeDetailsClicked:)];
[_seeDetailsView addGestureRecognizer:seeDetailsGesture];
    self.view.alpha = 0.0;
    [self jobDetail];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}


#pragma mark - IBActions -
- (IBAction)ScheduleClicked:(id)sender {
    
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted,NSError* error){
            if(!granted){
            NSString *message = @"Hey! PeopleNect Can't access your Calendar... check your privacy settings to let it in!";
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self presentViewController:[GlobalMethods AlertWithTitle:@"Warning" Message:message AlertMessage:@"Ok"] animated:YES completion:nil];
                });
            }else{
                
                EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
                addController.event = [self createEvent:eventStore];
                addController.eventStore = eventStore;
                
                [self presentViewController:addController animated:YES completion:nil];
                addController.editViewDelegate = self;
                }
        }];
    }
}


#pragma mark - eventEditDelegates -
- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action{
    if (action ==EKEventEditViewActionCanceled) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (action==EKEventEditViewActionSaved) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - createEvent -
-(EKEvent*)createEvent:(EKEventStore*)eventStore{
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.title = _jobTitleLbl.text;
    
    event.startDate = start;
    event.endDate = end;
    
    event.location=_bottomAddress;
    event.allDay = YES;
    event.notes = _jobDescription;
    
    NSString* calendarName = @"PeopleNect Calendar";
    EKCalendar* calendar;
    EKSource* localSource;
    for (EKSource *source in eventStore.sources){
        if (source.sourceType == EKSourceTypeCalDAV &&
            [source.title isEqualToString:@"iCloud"]){
            localSource = source;
            break;
        }
    }
    if (localSource == nil){
        for (EKSource *source in eventStore.sources){
            if (source.sourceType == EKSourceTypeLocal){
                localSource = source;
                break;
            }
        }
    }
    calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:eventStore];
    calendar.source = localSource;
    calendar.title = calendarName;
    NSError* error;
   [eventStore saveCalendar:calendar commit:YES error:&error];
    return event;
}


#pragma mark - IBActions -
- (IBAction)CloseClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(IBAction)seeDetailsClicked:(id)sender{
    NSString* url = [NSString stringWithFormat:@"http://maps.apple.com/?ll=%f,%f",_location.latitude,_location.longitude];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}


#pragma mark - JobdetailWebService -
-(void)jobDetail{
    
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        [_param setObject:@"jobDetailbyId" forKey:@"methodName"];
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"jobSeekerId"];
        [_param setObject:_jobId forKey:@"jobId"];
        
        //    [_param setObject:@"10" forKey:@"jobSeekerId"];
        //    [_param setObject:@"12" forKey:@"jobId"];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            self.view.alpha = 1.0;
            
            _totalHourLbl.text = [NSString stringWithFormat:@"Total hours %@",[[responseObject valueForKey:@"data"]valueForKey:@"totalHour"]];
            
            _priceHourLbl.text = [NSString stringWithFormat:@"$%@/h",[[responseObject valueForKey:@"data"]valueForKey:@"hourlyRate"]];
            
            _dateTimeLbl.text = [NSString stringWithFormat:@"%@ at %@",[[responseObject valueForKey:@"data"]valueForKey:@"start_date"],[[responseObject valueForKey:@"data"]valueForKey:@"start_hour"]];
            
            _jobTitleLbl.text = [[responseObject valueForKey:@"data"]valueForKey:@"jobTitle"];
            
            _bottomJobPriceLbl.text =[NSString stringWithFormat:@"%@/h",[[responseObject valueForKey:@"data"]valueForKey:@"hourlyRate"]];
            
            _companyName.text = [[responseObject valueForKey:@"data"]valueForKey:@"company_name"];
            
            NSString *distance = [[responseObject valueForKey:@"data"]valueForKey:@"distance"] ;
            
            double distanceValues = [distance doubleValue];
            
            _distanceLbl.text = [NSString stringWithFormat:@"%.02fkm",distanceValues];
            
            _bottomDateLbl.text = [[responseObject valueForKey:@"data"]valueForKey:@"start_date"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            start = [dateFormatter dateFromString: _bottomDateLbl.text];
            
            end = [dateFormatter dateFromString:[[responseObject valueForKey:@"data"]valueForKey:@"end_date"]];
            
            _bottomRatingLbl.text = _ratings;
            
            _jobDescriptionLbl.text = _jobDescription;
            
            _bottomAddressLbl.text = _bottomAddress;
            
            _location = CLLocationCoordinate2DMake([[[responseObject valueForKey:@"data"]valueForKey:@"JobLat"]doubleValue],[[[responseObject valueForKey:@"data"]valueForKey:@"JobLng"]doubleValue]);
            
            
            [kAppDel.progressHud hideAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];

    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];

    }
}

@end
