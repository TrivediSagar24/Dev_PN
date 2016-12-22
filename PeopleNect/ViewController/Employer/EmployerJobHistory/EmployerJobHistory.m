//
//  EmployerJobHistory.m
//  PeopleNect
//
//  Created by Narendra Pandey on 25/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "EmployerJobHistory.h"

@interface EmployerJobHistory ()
@end

@implementation EmployerJobHistory
#pragma mark - ViewLifecycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    _jobHistoryCollectionView.backgroundColor = [UIColor clearColor];
    [self employerJobHistory];
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
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}
- (BOOL)slideNavigationControllerShouldDisplayRightMenu{
    return NO;
}
#pragma mark - CollectionView Datasource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _responseHistory.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EmployerjJobHistoryCollectionCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmployerjJobHistoryCollectionCell" forIndexPath:indexPath];
    Cell.jobTitleLbl.text = [[_responseHistory valueForKey:@"jobTitle"]objectAtIndex:indexPath.row];
    NSString *rate = [[_responseHistory valueForKey:@"rate"]objectAtIndex:indexPath.row];
    Cell.priceLbl.text = [NSString stringWithFormat:@"$ %@/h",rate];
    Cell.reviewLbl.hidden = YES;
    Cell.starView.hidden = YES;
    return Cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, 45.0);
}
#pragma mark - employeesJobsHistory -
-(void)employerJobHistory{
    if ([GlobalMethods InternetAvailability]) {
        _responseHistory = [[NSMutableArray alloc]init];
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        [_param setObject:@"closedJobs" forKey:@"methodName"];
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _responseHistory = [responseObject valueForKey:@"data"];
            [kAppDel.progressHud hideAnimated:YES];
            _jobHistoryCollectionView.delegate = self;
            _jobHistoryCollectionView.dataSource = self;
            [_jobHistoryCollectionView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];

    }
}
@end
