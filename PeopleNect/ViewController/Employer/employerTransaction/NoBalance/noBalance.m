//
//  noBalance.m
//  PeopleNect
//
//  Created by Apple on 30/09/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "noBalance.h"

@interface noBalance ()
{
    NSInteger selectedIndex;
    NSString *selectedbalance;
}
@end

@implementation noBalance
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    [self packageListing];
    _addBalanceBtn.hidden = YES;
    selectedIndex = 0;
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}


#pragma mark - IBAction -
- (IBAction)CloseBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)addBtnClicked:(id)sender {
    
    if ([GlobalMethods InternetAvailability]) {
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        NSLog(@"selectedbalance%@",selectedbalance);
        payment.amount = [[NSDecimalNumber alloc] initWithString:selectedbalance];
        payment.currencyCode = @"USD";
        payment.shortDescription = @"human Resource";
        payment.items = nil;
        payment.paymentDetails = nil;
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                    configuration:self.payPalConfig
                                                                                                         delegate:self];
        [self presentViewController:paymentViewController animated:YES completion:nil];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}


#pragma mark - collectionView Datasource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _packageCredit.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NoBalanceCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NoBalanceCell" forIndexPath:indexPath];
    Cell.packageCreditLbl.text = [_packageCredit objectAtIndex:indexPath.item];
    if (indexPath.item==selectedIndex) {
        Cell.packageView.backgroundColor = [UIColor whiteColor];
        Cell.packageCreditLbl.textColor = [UIColor colorWithRed:36.0/255.0 green:36.0/255.0 blue:36.0/255.0 alpha:1];
    }
    else{
    Cell.packageView.backgroundColor = [UIColor clearColor];
    Cell.packageCreditLbl.textColor = [UIColor whiteColor];
    }
        return Cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NoBalanceCell *Cell = (NoBalanceCell*)[_PackagePriceCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.item inSection:0]];
    selectedIndex = indexPath.item;
    selectedbalance = [_packageCredit objectAtIndex:indexPath.item];
    Cell.packageView.backgroundColor = [UIColor clearColor];
    Cell.packageCreditLbl.textColor = [UIColor whiteColor];
    if (indexPath.item==selectedIndex) {
        Cell.packageView.backgroundColor = [UIColor whiteColor];
        Cell.packageCreditLbl.textColor = [UIColor colorWithRed:36.0/255.0 green:36.0/255.0 blue:36.0/255.0 alpha:1];
    }
    else{
        Cell.packageView.backgroundColor = [UIColor clearColor];
        Cell.packageCreditLbl.textColor = [UIColor whiteColor];
    }
    [_PackagePriceCollectionView reloadData];
}


#pragma mark - collectionView flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = collectionView.frame.size.width/3;
    return CGSizeMake(width, collectionView.frame.size.height);
}


#pragma mark - packageListing -
-(void)packageListing{
    
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        _packageCredit = [[NSMutableArray alloc]init];
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        [_param setObject:@"packageListing" forKey:@"methodName"];
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            _packageCredit = [[responseObject valueForKey:@"data"]valueForKey:@"amount"];
            selectedbalance = [_packageCredit objectAtIndex:0];
            [kAppDel.progressHud hideAnimated:YES];
            _PackagePriceCollectionView.delegate = self;
            _PackagePriceCollectionView.dataSource = self;
            [_PackagePriceCollectionView reloadData];
            _addBalanceBtn.hidden = NO;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}

#pragma mark - PayPalPaymentDelegate -
- (void)payPalPaymentDidCancel:(nonnull PayPalPaymentViewController *)paymentViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)payPalPaymentViewController:(nonnull PayPalPaymentViewController *)paymentViewController
                willCompletePayment:(nonnull PayPalPayment *)completedPayment
                    completionBlock:(nonnull PayPalPaymentDelegateCompletionBlock)completionBlock{
    NSDictionary *confirmation = completedPayment.confirmation;
    [self addbalance:[[confirmation valueForKey:@"response"]valueForKey:@"id"]];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - addBalance -
-(void)addbalance:(NSString *)paymentid{
    if ([GlobalMethods InternetAvailability]) {
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        [_param setObject:@"addBalanceFromPayPal" forKey:@"methodName"];
        [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"employerId"];
        [_param setObject:paymentid forKey:@"paymentId"];
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [kAppDel.progressHud hideAnimated:YES];
            [self presentViewController:[GlobalMethods AlertWithTitle:[responseObject valueForKey:@"message"] Message:[NSString stringWithFormat:@"You have added %@ $",[responseObject valueForKey:@"amount"]] AlertMessage:@"OK"] animated:YES completion:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];

    }
}
@end
