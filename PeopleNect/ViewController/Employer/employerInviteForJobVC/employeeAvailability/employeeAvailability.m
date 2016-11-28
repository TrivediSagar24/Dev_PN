//
//  employeeAvailability.m
//  PeopleNect
//
//  Created by Apple on 16/11/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeAvailability.h"

@interface employeeAvailability ()
{
    NSArray *weekDays;
    NSMutableArray *responseSelectedAvailibility,*selectedWeekAvailibility;
}
@end

@implementation employeeAvailability
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    weekDays = @[@"Sun",@"Mon", @"Tues", @"Wed",@"Thurs",@"Fri",@"Sat"];
    selectedWeekAvailibility = [[NSMutableArray alloc]init];

    for (int i = 0; i<weekDays.count; i++) {
        [selectedWeekAvailibility addObject:@"0"];
    }
    
    [self getUserAvailibility];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}


#pragma mark - ViewLifeCycle -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return weekDays.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    availabilityCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"availabilityCell" forIndexPath:indexPath];

    Cell.weekNameLbl.text = [weekDays objectAtIndex:indexPath.row];
    
    if (responseSelectedAvailibility.count>0) {
        
        NSArray *startTimeArray = [[responseSelectedAvailibility valueForKey:@"start_time"]objectAtIndex:0];
        
        NSArray *endTimeArray = [[responseSelectedAvailibility valueForKey:@"end_time"]objectAtIndex:0];
        
        for (int i = 0; i<[[responseSelectedAvailibility firstObject]count]; i++) {
            
            Cell.availabilityLabel.text = [NSString stringWithFormat:@"%@ - %@",[startTimeArray objectAtIndex:i],[endTimeArray objectAtIndex:i]];
        }
    }
    

    if ([[selectedWeekAvailibility objectAtIndex:indexPath.row]isEqualToString:@"0"]) {
        Cell.weekNameLbl.hidden = YES;
        Cell.availabilityLabel.text = @"Not Available";
    }
    
    if ([[selectedWeekAvailibility objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
        Cell.weekNameLbl.hidden = NO;
    }
    
    return Cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.frame.size.width-30, collectionView.frame.size.height/7);
}

- (IBAction)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Get User Availibility -
-(void)getUserAvailibility{
    
    if ([GlobalMethods InternetAvailability]) {
        responseSelectedAvailibility = [[NSMutableArray alloc]init];
        
        NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
        [_param setObject:@"getUserAvailability" forKey:@"methodName"];
        [_param setObject:_employeeUserId forKey:@"userId"];
        
        //    kAppDel.progressHud = [GlobalMethods ShowProgressHud:kAppDel.window];
        
        [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            
            [responseSelectedAvailibility addObject:[responseObject valueForKey:@"data"] ];
            
            NSArray *dayArray = [[responseSelectedAvailibility valueForKey:@"day"] objectAtIndex:0];
            
            for (int i = 0; i<[[responseSelectedAvailibility firstObject]count]; i++) {
                
                NSString *dayIndexString = [dayArray objectAtIndex:i];
                
                int dayIndex = [dayIndexString intValue];
                
                dayIndex = dayIndex-1;
                
                [selectedWeekAvailibility replaceObjectAtIndex:dayIndex withObject:@"1"];
            }
            
            _availableCollectionView.delegate= self;
            _availableCollectionView.dataSource = self;
            [_availableCollectionView reloadData];
            [kAppDel.progressHud hideAnimated:YES];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [kAppDel.progressHud hideAnimated:YES];
            
        }];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];

    }
}
@end
