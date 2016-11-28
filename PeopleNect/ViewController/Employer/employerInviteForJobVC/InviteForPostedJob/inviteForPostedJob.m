
//
//  inviteForPostedJob.m
//  PeopleNect
//
//  Created by Apple on 16/11/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "inviteForPostedJob.h"

@interface inviteForPostedJob ()

@end

@implementation inviteForPostedJob
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allJobs = [[NSMutableDictionary alloc]init];

    [self openJobs];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}


#pragma mark - Tableview Datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_allJobs.count==0) {
        return 1;
    }else
    return _allJobs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    postedJobCell *obj_postedJobCell  = [tableView dequeueReusableCellWithIdentifier:@"postedJobCell" forIndexPath:indexPath];
    
    obj_postedJobCell.inviteLbl.text = @"invite";
    
    if (indexPath.row==0) {
        obj_postedJobCell.closeImagView.hidden = NO;
        obj_postedJobCell.inviteLbl.hidden = YES;
        obj_postedJobCell.rightArrowImg.hidden = YES;
        
        obj_postedJobCell.jobTitleLbl.text = _EmployeeName;
        obj_postedJobCell.jobPriceLbl.text = @"For:";
    }
    
    else{
        obj_postedJobCell.closeImagView.hidden = YES;
        obj_postedJobCell.inviteLbl.hidden = NO;
        obj_postedJobCell.rightArrowImg.hidden = NO;
        
    obj_postedJobCell.jobTitleLbl.text = [[_allJobs valueForKey:@"job"]objectAtIndex:indexPath.row];
        
        obj_postedJobCell.jobTitleLbl.text =
        [NSString stringWithFormat:@"$ %@/h",[[_allJobs valueForKey:@"price"] objectAtIndex:indexPath.row]];
    }
    obj_postedJobCell.whiteBorderLbl.hidden = NO;

    if (indexPath.row==_allJobs.count-1) {
        obj_postedJobCell.whiteBorderLbl.hidden = YES;
    }
    return obj_postedJobCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
    [self dismissViewControllerAnimated:YES completion:nil];
    }
}



#pragma mark - openJobs -
-(void)openJobs{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    if ([GlobalMethods InternetAvailability]) {
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        [_param setObject:@"openJobs" forKey:@"methodName"];
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [kAppDel.progressHud hideAnimated:YES];
            
            NSLog(@"response object %@",responseObject);
            
            if ([[[responseObject valueForKey:@"data"]valueForKey:@"currentJobs"] count]>0) {
                
                [_allJobs setObject:[[[responseObject valueForKey:@"data"] valueForKey:@"currentJobs"] valueForKey:@"jobTitle"] forKey:@"job"];
                
                [_allJobs setObject:[[[responseObject valueForKey:@"data"] valueForKey:@"currentJobs"] valueForKey:@"rate"] forKey:@"price"];
            }
            
            
            if ([[[responseObject valueForKey:@"data"]valueForKey:@"jobsForGuest"] count]>0) {
                
                [_allJobs setObject:[[[responseObject valueForKey:@"data"] valueForKey:@"jobsForGuest"] valueForKey:@"jobTitle"] forKey:@"job"];
                
                
                [_allJobs setObject:[[[responseObject valueForKey:@"data"] valueForKey:@"jobsForGuest"] valueForKey:@"rate"] forKey:@"price"];
            }
            
            _postedJobTableView.delegate = self;
            _postedJobTableView.dataSource = self;
            
            [_postedJobTableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];

    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];

    }
}

@end
