//
//  employeeRatings.m
//  PeopleNect
//
//  Created by Narendra Pandey on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeRatings.h"

@interface employeeRatings ()

@end

@implementation employeeRatings
#pragma mark -view LifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}


#pragma mark -IBActions -
- (IBAction)OneStaeClicked:(id)sender {
    _oneStar.selected = !_oneStar.selected;
}


- (IBAction)twoStarClicked:(id)sender {
    _twoStar.selected = !_twoStar.selected;

}


- (IBAction)threeStarClicked:(id)sender {
    _threeStar.selected = !_threeStar.selected;

}


- (IBAction)fourStarClicked:(id)sender {
    _fourStar.selected = !_fourStar.selected;

}


- (IBAction)fiveStarClicked:(id)sender {
    _fiveStar.selected = !_fiveStar.selected;
}


- (IBAction)SendClicked:(id)sender {
    if ([GlobalMethods InternetAvailability]) {
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        
        [_param setValue:@"rateEmployer" forKey:@"methodName"];
        
        [_param setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
        
        [_param setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
        
        [_param setValue:@"4" forKey:@"rating"];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [kAppDel.progressHud hideAnimated:YES];
            
            NSLog(@"Response Object %@",responseObject);
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];

    }
}

@end
