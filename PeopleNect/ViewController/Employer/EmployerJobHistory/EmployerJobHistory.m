//
//  EmployerJobHistory.m
//  PeopleNect
//
//  Created by Apple on 25/10/16.
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
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EmployerjJobHistoryCollectionCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmployerjJobHistoryCollectionCell" forIndexPath:indexPath];
    
    return Cell;
}

#pragma mark - employeesJobsHistory -
-(void)employerJobHistory{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    [_param setObject:@"closedJobs" forKey:@"methodName"];
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [kAppDel.progressHud hideAnimated:YES];
        
        _jobHistoryCollectionView.delegate = self;
        _jobHistoryCollectionView.dataSource = self;
        [_jobHistoryCollectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];
    }];
}


@end
