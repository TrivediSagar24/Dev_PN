//
//  repostJobEmployerCtr.m
//  PeopleNect
//
//  Created by Narendra Pandey on 9/22/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "repostJobEmployerCtr.h"

@interface repostJobEmployerCtr (){
    NSMutableArray *closeJobArray;
    UIImageView *profileImageView;
    
}
@end
@implementation repostJobEmployerCtr

#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
[self closeJob];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"arrow"];
    
    if (kAppDel.EmployerProfileImage==nil) {
    }
    else{
    }
    
    _profileImage.layer.cornerRadius = kDEV_PROPROTIONAL_Height(96)/2;
    
    _profileImage.layer.masksToBounds = YES;
    
    if (kAppDel.EmployerProfileImage==nil) {
        _profileImage.image = [UIImage imageNamed:@"profile"];
    }
    else{
        _profileImage.image = kAppDel.EmployerProfileImage;
    }
}




-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



#pragma mark - Navigation Bar Back Button
-(void)barBackButton
{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
    {
        if ([viewControllrObj isKindOfClass:[MenuCtr class]])
        {
            [self.navigationController popToViewController:viewControllrObj animated:YES];
        }
    }
}


#pragma mark - tableView Datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (closeJobArray.count==0) {
        return 1;
    }
    else
    {
        return closeJobArray.count+1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    repostCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"repostCell" forIndexPath:indexPath];
    if (indexPath.row==0) {
        Cell.jobTitle.hidden = YES;
        Cell.priceLbl.hidden = YES;
        Cell.arrowBtn.hidden = YES;
        Cell.respostJobLbl.hidden = YES;
        Cell.repostLbl.hidden = NO;
        Cell.closeBtn.hidden = NO;
    }
    else
    {
    Cell.jobTitle.hidden = NO;
    Cell.priceLbl.hidden = NO;
    Cell.arrowBtn.hidden = NO;
    Cell.respostJobLbl.hidden = NO;
    Cell.repostLbl.hidden = YES;
    Cell.closeBtn.hidden = YES;
    
        Cell.borderLabel.hidden = NO;

        if ([closeJobArray count]==0) {
            Cell.borderLabel.hidden = YES;
        }
        if (indexPath.row == closeJobArray.count+1) {
            Cell.borderLabel.hidden = YES;
        }
        
    Cell.jobTitle.text = [[closeJobArray valueForKey:@"jobTitle"]objectAtIndex:indexPath.row-1];
        
    Cell.priceLbl.text = [NSString stringWithFormat:@"$ %@/h",[[closeJobArray valueForKey:@"rate"] objectAtIndex:indexPath.row-1]];
    }
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [[NSUserDefaults standardUserDefaults ]setObject:@"repost" forKey:@"PostJob"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        CategoryEmployeeCtr *obj_CategoryEmployeeCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
        [self.navigationController pushViewController:obj_CategoryEmployeeCtr animated:YES];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults ]setObject:@"last" forKey:@"PostJob"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        EmployerLastDetailsCtr *obj_EmployerLastDetailsCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployerLastDetailsCtr"];
        
        obj_EmployerLastDetailsCtr.jobId = [[closeJobArray objectAtIndex:indexPath.row-1]valueForKey:@"jobId"];
       
        obj_EmployerLastDetailsCtr.repostProfileURL = [[closeJobArray objectAtIndex:indexPath.row-1]valueForKey:@"pictureUrl"];

        [self.navigationController pushViewController:obj_EmployerLastDetailsCtr animated:YES];
    }
}


#pragma mark - CloseJob -
-(void)closeJob{
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        closeJobArray = [[NSMutableArray alloc]init];
        
        [_param setObject:@"closedJobs" forKey:@"methodName"];
        
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [kAppDel.progressHud hideAnimated:YES];
            closeJobArray = [responseObject valueForKey:@"data"];
            if (closeJobArray.count==0) {
                [[NSUserDefaults standardUserDefaults ]setObject:@"repost" forKey:@"PostJob"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                CategoryEmployeeCtr *obj_CategoryEmployeeCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryEmployeeCtr"];
                [self.navigationController pushViewController:obj_CategoryEmployeeCtr animated:YES];
            }
            _respostTableView.delegate = self;
            _respostTableView.dataSource = self;
            [_respostTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            _respostTableView.delegate = self;
            _respostTableView.dataSource = self;
            [_respostTableView reloadData];
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}
@end
