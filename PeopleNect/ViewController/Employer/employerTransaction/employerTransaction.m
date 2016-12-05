//
//  employerTransaction.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employerTransaction.h"

@interface employerTransaction ()
@end

@implementation employerTransaction
#pragma mark - viewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    _YourBalanceLbl.text = [NSString stringWithFormat:@"Your balance\n $0"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    if ([GlobalMethods InternetAvailability]) {
        [self transactionHistory];
        [self jobPostingPriceAndBalance];
    }
    else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }

    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"Transaction"] isEqualToString:@"Navigation"]){
        self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"Gray_right_arrow_" ];
    }
}


#pragma mark - TableView Datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _transactionHistoryArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    transactionCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"transactionCell" forIndexPath:indexPath];
    Cell.invitedLbl.text = [[_transactionHistoryArray valueForKey:@"comment"] objectAtIndex:indexPath.row];
   
    NSString *Amount = [[_transactionHistoryArray valueForKey:@"amount"] objectAtIndex:indexPath.row];
    
    Amount = [Amount stringByReplacingOccurrencesOfString:@".00" withString:@""];
    
    Amount = [NSString stringWithFormat:@"$%@",Amount];
   
    Cell.priceLbl.text = Amount;
    
   
    NSString *dateString=[[_transactionHistoryArray valueForKey:@"create_date"] objectAtIndex:indexPath.row];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *formattedDate = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"dd/MM"];
   
    NSString *formattedDateString = [dateFormatter stringFromDate:formattedDate];
    
    Cell.dateLbl.text = formattedDateString;
    

    if (indexPath.row == _transactionHistoryArray.count-1) {
        Cell.lineLbl.hidden = YES;
    }else{
        Cell.lineLbl.hidden = NO;
    }
    
    if ([[[_transactionHistoryArray valueForKey:@"action"] objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        //Cell.circularLbl.backgroundColor = [UIColor redColor];
        //Cell.lineLbl.backgroundColor =[UIColor redColor];
       // Cell.dateLbl.textColor = [UIColor redColor];
        Cell.priceLbl.textColor = [UIColor redColor];
        
        Cell.priceLbl.text = [NSString stringWithFormat:@"-%@",Amount];

        //Cell.invitedLbl.textColor = [UIColor redColor];
    }
    if ([[[_transactionHistoryArray valueForKey:@"action"] objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
        Cell.circularLbl.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:75.0/255.0 blue:124.0/255.0 alpha:1];
        Cell.lineLbl.backgroundColor =[UIColor colorWithRed:23.0/255.0 green:75.0/255.0 blue:124.0/255.0 alpha:1];
        Cell.dateLbl.textColor = [UIColor colorWithRed:77.0/255.0 green:77.0/255.0 blue:77.0/255.0 alpha:1];
        Cell.priceLbl.textColor = [UIColor colorWithRed:77.0/255.0 green:77.0/255.0 blue:77.0/255.0 alpha:1];
        Cell.invitedLbl.textColor = [UIColor colorWithRed:77.0/255.0 green:77.0/255.0 blue:77.0/255.0 alpha:1];
    }
    
    return Cell;
}


#pragma mark - IBAction -
- (IBAction)AddBalanceClicked:(id)sender{
    addBalance *obj_addBalance = [self.storyboard instantiateViewControllerWithIdentifier:@"addBalance"];
    [self.navigationController pushViewController:obj_addBalance animated:YES];
}


#pragma mark - SlideNavigationController Methods -
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu{
     if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"Transaction"] isEqualToString:@"Navigation"]){
         return NO;
     }else
    return YES;
}


- (BOOL)slideNavigationControllerShouldDisplayRightMenu{
    return NO;
}


#pragma mark - transactionHistory -
-(void)transactionHistory{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    _transactionHistoryArray = [[NSMutableArray alloc]init];
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    [_param setObject:@"transactionHistory" forKey:@"methodName"];
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [kAppDel.progressHud hideAnimated:YES];
        _YourBalanceLbl.text = [NSString stringWithFormat:@"Your balance\n $%@",[responseObject valueForKey:@"balance"]];
        _transactionHistoryArray = [responseObject valueForKey:@"data"];
        
            [_transactionTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];
    }];
}
#pragma mark - Web Services -
-(void)jobPostingPriceAndBalance
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    [_param setObject:@"jobPostingPriceAndBalance" forKey:@"methodName"];
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
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


#pragma mark - Navigation Bar Back Button
-(void)barBackButton{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers){
        if ([viewControllrObj isKindOfClass:[MenuCtr class]]){
            [self.navigationController popToViewController:viewControllrObj animated:YES];
        }
    }
}
@end
