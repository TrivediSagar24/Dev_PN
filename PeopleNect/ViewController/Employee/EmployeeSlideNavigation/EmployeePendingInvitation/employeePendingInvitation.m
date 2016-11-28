//
//  employeePendingInvitation.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/7/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeePendingInvitation.h"

@interface employeePendingInvitation ()
{
    NSTimer *Timer;
}
@end

@implementation employeePendingInvitation
#pragma mark - View LifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    _pendingCollectionView.backgroundColor = [UIColor clearColor];
    Timer = [NSTimer scheduledTimerWithTimeInterval: 0.3 target: self selector:@selector(GetPendingInvitation)userInfo: nil repeats:NO];
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


#pragma mark - collectionView Delegates and DataSources -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_pendingJobInfo count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    employeePendingCell *obj_employeePendingCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"employeePendingCell" forIndexPath:indexPath];
    
    obj_employeePendingCell.jobTitleLbl.text = [[_pendingJobInfo valueForKey:@"jobTitle"]objectAtIndex:indexPath.item];
    obj_employeePendingCell.priceLbl.text = [NSString stringWithFormat:@"$ %@/h",[[_pendingJobInfo valueForKey:@"rate"] objectAtIndex:indexPath.item]];
    obj_employeePendingCell.companyNameLbl.text = [[_pendingJobInfo valueForKey:@"companyName"]objectAtIndex:indexPath.item];
    obj_employeePendingCell.lblKm.text = [[_pendingJobInfo valueForKey:@"distance"]objectAtIndex:indexPath.item];
    obj_employeePendingCell.StartDateKLbl.text = [[_pendingJobInfo valueForKey:@"date"]objectAtIndex:indexPath.item];
    obj_employeePendingCell.lblRatings.text = [[_pendingJobInfo valueForKey:@"rating"]objectAtIndex:indexPath.item];
    obj_employeePendingCell.jobDescriptionLbl.text =
    [[_pendingJobInfo valueForKey:@"description"]objectAtIndex:indexPath.item];
    obj_employeePendingCell.lblAddress.text =  [[_pendingJobInfo valueForKey:@"address"]objectAtIndex:indexPath.item];
    obj_employeePendingCell.lblTotalHour.text = [NSString stringWithFormat:@"Start hour %@/ Total hours %@",[[_pendingJobInfo valueForKey:@"startHour"]objectAtIndex:indexPath.item],[[_pendingJobInfo valueForKey:@"totalHours"]objectAtIndex:indexPath.item]];
    obj_employeePendingCell.acceptBtn.tag = indexPath.item;
    obj_employeePendingCell.refuseBtn.tag = indexPath.item;
    [  obj_employeePendingCell.acceptBtn addTarget:self action:@selector(acceptBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [  obj_employeePendingCell.refuseBtn addTarget:self action:@selector(refuseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return obj_employeePendingCell;
}


-(void)acceptBtnClicked:(UIButton*)sender
{
    NSString *jobId = [[_pendingJobInfo valueForKey:@"jobId"]objectAtIndex:sender.tag];
    [self AcceptInvitation:@"1" jobid:jobId indexPath:sender.tag];
}


-(void)refuseBtnClicked:(UIButton*)sender
{
    NSString *jobId = [[_pendingJobInfo valueForKey:@"jobId"]objectAtIndex:sender.tag];
    [self AcceptInvitation:@"0" jobid:jobId indexPath:sender.tag];
}


#pragma mark - collectionView flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize calCulateSizze =[(NSString*)[NSString stringWithFormat:@" %@ ",[[_pendingJobInfo valueForKey:@"description"]objectAtIndex:indexPath.row]]  sizeWithAttributes:NULL];
    CGFloat lineCount = calCulateSizze.width/227.203125;
    int result = (int)ceilf(lineCount);
      CGFloat height = (result*10)+200;
  return CGSizeMake(collectionView.frame.size.width,height);
}


#pragma mark - GetPendingInvitation -
-(void)GetPendingInvitation
{
    if ([GlobalMethods InternetAvailability]) {
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        _pendingJobInfo = [[NSMutableArray alloc]init];
        
        [_param setObject:@"getPendingInvitations" forKey:@"methodName"];
        
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [kAppDel.progressHud hideAnimated:YES];
            _pendingJobInfo = [[responseObject valueForKey:@"data"]mutableCopy];
            _pendingCollectionView.delegate = self;
            _pendingCollectionView.dataSource = self;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}


#pragma mark - Accept Invitation -
-(void)AcceptInvitation:(NSString*)accept jobid:(NSString *)JobId indexPath:(NSInteger)indexPath{
    
    if ([GlobalMethods InternetAvailability]) {
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        [_param setObject:@"acceptJobInvitation" forKey:@"methodName"];
        
        [_param setObject:accept forKey:@"accept"];
        
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"] forKey:@"userId"];
        
        [_param setObject:JobId forKey:@"jobId"];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [kAppDel.progressHud hideAnimated:YES];
            
            if ([accept isEqual:@"1"]) {
                [self presentViewController:[GlobalMethods AlertWithTitle:nil Message:@"Invitation accepted" AlertMessage:@"OK"]animated:YES completion:nil];
            }
            if ([accept isEqual:@"0"]) {
                [self presentViewController:[GlobalMethods AlertWithTitle:nil Message:@"Invitation refused" AlertMessage:@"OK"]animated:YES completion:nil];
            }
            
            
            [_pendingJobInfo removeObjectAtIndex:indexPath];
            [_pendingCollectionView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}

@end
