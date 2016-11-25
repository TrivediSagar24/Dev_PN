//
//  employerInviteForJobVC.m
//  PeopleNect
//
//  Created by Apple on 08/09/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//


#import "employerInviteForJobVC.h"


@interface employerInviteForJobVC ()
{
    NSString *userType;
    NSInteger indexOfChat;
    NSMutableDictionary *EmployeeDetails;
}
@end

@implementation employerInviteForJobVC
#pragma mark - View Life Cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    userType = @"1";
    
    self.ProfileView.clipsToBounds = YES;
      _ProfileBtn.hidden = YES;
    
    self.ProfileView.layer.cornerRadius  =  kDEV_PROPROTIONAL_Height(80)/2;
   
    if (_isfromOpenJobSelected == YES) {
       
        _invitedJobView.hidden = YES;
        _postedJobBtn.hidden = YES;
        
        
    [_profileImage sd_setImageWithURL: [NSURL URLWithString:[[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"proifilePicUrl"]]placeholderImage:[UIImage imageNamed:@"profile"]];
    
    }else{
        
        NSData *EmployeeList= [[NSUserDefaults standardUserDefaults] objectForKey:@"EmployeeList"];
        
        if (EmployeeList!=nil) {
            kAppDel.obj_responseEmployeesList = [NSKeyedUnarchiver unarchiveObjectWithData:EmployeeList];
        }
        
        EmployeeDetails = [[NSMutableDictionary alloc]init];
        
        if ([[kAppDel.obj_responseEmployeesList.employeeAvailabilityStatus objectAtIndex:_employeeSelected] isEqual:@"1"]) {
        }
        [_profileImage sd_setImageWithURL: [NSURL URLWithString:[kAppDel.obj_responseEmployeesList.employeeImage objectAtIndex:_employeeSelected]]placeholderImage:[UIImage imageNamed:@"profile"]];
    }
    
   self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.obj_CollectionView.dataSource = self;
    self.obj_CollectionView.delegate = self;
   
    [self.obj_CollectionView.collectionViewLayout invalidateLayout];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}


#pragma mark - Collection View Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (_isfromOpenJobSelected == YES) {
        return _invitedJobListArray.count;
    }
    else
    return [kAppDel.obj_responseEmployeesList.employeeId count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    employerInviteForJobCell *Cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Cell.contentView.frame = Cell.bounds;

    if (_isfromOpenJobSelected == YES) {
       
        self.employeeId = [[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"userId"];
        
        self.employeeExpYears = [[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"experience"];
        
        self.employeeRatings = [[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"userRating"];

        self.employeeCategory = [[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"categoryName"];
        
        self.employeeDistance = [[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"distance"];
        
        NSRange range = [_employeeDistance rangeOfString:@"."];
        
        _employeeDistance = [_employeeDistance substringToIndex:range.location];
        
        self.employeeDescription = [[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"profileDescription"];
        
        Cell.lblEmployeeName.text =[[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"userName"];
        self.employeeName =  Cell.lblEmployeeName.text ;
        Cell.lblEmployeeCategory.text = [NSString stringWithFormat:@"%@ - %@ /",self.employeeCategory,self.employeeExpYears];
        
        [_profileImage sd_setImageWithURL: [NSURL URLWithString:[[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"proifilePicUrl"]]placeholderImage:[UIImage imageNamed:@"profile"]];
        
        NSString *str=[[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"subCategoryName"];

        
        kAppDel.subCategoryFromInvited = [[NSMutableArray alloc] initWithArray:[str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]]];
        
        
        if ([[[_invitedJobListArray objectAtIndex:_employeeSelected] valueForKey:@"availability"] isEqual:@"1"]) {
            _chatBtn.enabled = YES;
            
            indexOfChat = indexPath.row;
            
            [EmployeeDetails setValue:self.employeeId forKey:@"EmployeeUserID"];
            
            [EmployeeDetails setValue:Cell.lblEmployeeName.text forKey:@"DisplyName"];
            
            [EmployeeDetails setValue:[NSURL URLWithString:[[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"proifilePicUrl"]]forKey:@"ProfilePic"];
            
            [EmployeeDetails setValue:  self.employeeCategory forKey:@"employeeCategoryName"];
            
            [_chatBtn setImage:[UIImage imageNamed:@"chatBlue"] forState:UIControlStateNormal];
            
            _chatLabel.textColor = [UIColor colorWithRed:20.0/255.0 green:64.0/255.0 blue:109.0/255.0 alpha:1.0];
        }
        else{
            _chatBtn.enabled = NO;
            
            [_chatBtn setImage:[UIImage imageNamed:@"chatGray"] forState:UIControlStateNormal];
            _chatLabel.textColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
        }
        
        Cell.lblDistance.text = [NSString stringWithFormat:@"%@KM",self.employeeDistance];
        
        Cell.lblDescription.text =  self.employeeDescription;
        
        if(self.employeeRatings > 0)
        {
            
        }
        
    }else{
    
        self.employeeId = [kAppDel.obj_responseEmployeesList.employeeId objectAtIndex:_employeeSelected];
        
        self.employeeExpYears = [kAppDel.obj_responseEmployeesList.employeeExpYears objectAtIndex:_employeeSelected];
        
        self.employeeRatings = [kAppDel.obj_responseEmployeesList.employeeRating objectAtIndex:_employeeSelected];
        
        self.employeeCategory = [kAppDel.obj_responseEmployeesList.employeeCategoryName objectAtIndex:_employeeSelected];
        
        self.employeeDistance = [kAppDel.obj_responseEmployeesList.employeeDistance objectAtIndex:_employeeSelected];
        
        NSRange range = [_employeeDistance rangeOfString:@"."];
        
        _employeeDistance = [_employeeDistance substringToIndex:range.location];
        
        self.employeeDescription = [kAppDel.obj_responseEmployeesList.employeeDescription objectAtIndex:_employeeSelected];
        
        Cell.lblEmployeeName.text =[kAppDel.obj_responseEmployeesList.employeeName objectAtIndex:_employeeSelected];
        
        
        Cell.lblEmployeeCategory.text = [NSString stringWithFormat:@"%@ - %@ /",self.employeeCategory,self.employeeExpYears];
        
        [_ProfileBtn sd_setImageWithURL:[NSURL URLWithString:[kAppDel.obj_responseEmployeesList.employeeImage objectAtIndex:_employeeSelected]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"profile"]];
        
        [_profileImage sd_setImageWithURL: [NSURL URLWithString:[kAppDel.obj_responseEmployeesList.employeeImage objectAtIndex:_employeeSelected]]placeholderImage:[UIImage imageNamed:@"profile"]];
        
        NSString *str=[kAppDel.obj_responseEmployeesList.employeeSubactegoryName objectAtIndex:_employeeSelected];
        
        kAppDel.subCategoryFromInvited = [[NSMutableArray alloc] initWithArray:[str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]]];
        
        
        if ([[kAppDel.obj_responseEmployeesList.employeeAvailabilityStatus objectAtIndex:_employeeSelected] isEqual:@"1"]) {
            _chatBtn.enabled = YES;
            
            indexOfChat = indexPath.row;
            
            [EmployeeDetails setValue:[kAppDel.obj_responseEmployeesList.employeeId objectAtIndex:_employeeSelected] forKey:@"EmployeeUserID"];
            
            [EmployeeDetails setValue:[kAppDel.obj_responseEmployeesList.employeeName objectAtIndex:_employeeSelected] forKey:@"DisplyName"];
            
            [EmployeeDetails setValue:[kAppDel.obj_responseEmployeesList.employeeImage objectAtIndex:_employeeSelected]forKey:@"ProfilePic"];
            
            [EmployeeDetails setValue:  [kAppDel.obj_responseEmployeesList.employeeCategoryName objectAtIndex:_employeeSelected]forKey:@"employeeCategoryName"];
            
            [_chatBtn setImage:[UIImage imageNamed:@"chatBlue"] forState:UIControlStateNormal];
            
            _chatLabel.textColor = [UIColor colorWithRed:20.0/255.0 green:64.0/255.0 blue:109.0/255.0 alpha:1.0];
        }
        else{
            _chatBtn.enabled = NO;
            
            [_chatBtn setImage:[UIImage imageNamed:@"chatGray"] forState:UIControlStateNormal];
            _chatLabel.textColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
        }
        
        Cell.lblDistance.text = [NSString stringWithFormat:@"%@KM",self.employeeDistance];
        
        
        Cell.lblDescription.text =  self.employeeDescription;
        
        if(self.employeeRatings > 0)
        {
            
        }
        
    }
return Cell;
}


-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(employerInviteForJobCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize calCulateSizze;
    if (_isfromOpenJobSelected == YES) {
        calCulateSizze =[(NSString*)[NSString stringWithFormat:@" %@ -%@ %@KM",[[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"experience"],[[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"categoryName"],[[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"distance"]]  sizeWithAttributes:NULL];
        
    }else{
       calCulateSizze =[(NSString*)[NSString stringWithFormat:@" %@ -%@ %@KM",[kAppDel.obj_responseEmployeesList.employeeCategoryName objectAtIndex:indexPath.row],[kAppDel.obj_responseEmployeesList.employeeExpYears objectAtIndex:indexPath.row],[kAppDel.obj_responseEmployeesList.employeeDistance objectAtIndex:indexPath.row]]  sizeWithAttributes:NULL];
        
    }
    cell.CategoryDistanceWidthConstraints.constant = calCulateSizze.width+30;
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
    for (UICollectionViewCell *cell in [self.obj_CollectionView visibleCells]) {
        
    NSIndexPath *indexPath = [self.obj_CollectionView indexPathForCell:cell];
        
        _employeeSelected = indexPath.item;
        
        [UIView setAnimationsEnabled:NO];
        
        [_obj_CollectionView performBatchUpdates:^{
            
            [_obj_CollectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_employeeSelected inSection:0]]];
            
        } completion:^(BOOL finished) {
            [UIView setAnimationsEnabled:YES];
        }];
        
        if (_isfromOpenJobSelected == YES) {
            
            
            
            if ([[[_invitedJobListArray objectAtIndex:_employeeSelected] valueForKey:@"availability"] isEqual:@"1"]) {
                _chatBtn.enabled = YES;
                
                indexOfChat = indexPath.row;
                
                [EmployeeDetails setValue:self.employeeId forKey:@"EmployeeUserID"];
                
                [EmployeeDetails setValue: self.employeeName forKey:@"DisplyName"];
                
                [EmployeeDetails setValue:[NSURL URLWithString:[[_invitedJobListArray objectAtIndex:_employeeSelected]valueForKey:@"proifilePicUrl"]]forKey:@"ProfilePic"];
                
                [EmployeeDetails setValue:  self.employeeCategory forKey:@"employeeCategoryName"];
                
                [_chatBtn setImage:[UIImage imageNamed:@"chatBlue"] forState:UIControlStateNormal];
                
                _chatLabel.textColor = [UIColor colorWithRed:20.0/255.0 green:64.0/255.0 blue:109.0/255.0 alpha:1.0];
            }
            else{
                _chatBtn.enabled = NO;
                
                [_chatBtn setImage:[UIImage imageNamed:@"chatGray"] forState:UIControlStateNormal];
                _chatLabel.textColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
            }

        }else{
            if ([[kAppDel.obj_responseEmployeesList.employeeAvailabilityStatus objectAtIndex:indexPath.row] isEqual:@"1"]) {
                
                _chatBtn.enabled = YES;
                
                indexOfChat = indexPath.row;
                
                [EmployeeDetails setValue:[kAppDel.obj_responseEmployeesList.employeeId objectAtIndex:indexPath.row] forKey:@"EmployeeUserID"];
                
                [EmployeeDetails setValue:[kAppDel.obj_responseEmployeesList.employeeName objectAtIndex:indexPath.row] forKey:@"DisplyName"];
                
                [EmployeeDetails setValue:[kAppDel.obj_responseEmployeesList.employeeImage objectAtIndex:indexPath.row]forKey:@"ProfilePic"];
                
                
                [EmployeeDetails setValue:  [kAppDel.obj_responseEmployeesList.employeeCategoryName objectAtIndex:indexPath.row]forKey:@"employeeCategoryName"];
                
                [_chatBtn setImage:[UIImage imageNamed:@"chatBlue"] forState:UIControlStateNormal];
                
                _chatLabel.textColor = [UIColor colorWithRed:20.0/255.0 green:64.0/255.0 blue:109.0/255.0 alpha:1.0];
            }
            else{
                
                _chatBtn.enabled = NO;
                
                [_chatBtn setImage:[UIImage imageNamed:@"chatGray"] forState:UIControlStateNormal];
                _chatLabel.textColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
            }
        }
    }
}


#pragma mark - IBActions -
- (IBAction)onClickMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onClickChat:(id)sender {
        if (_chatBtn.enabled ==YES) {
            [self chatHistory];
    }
}


- (IBAction)busyBtnClicked:(id)sender {
    employeeAvailability *obj_employeeAvailability =[self.storyboard instantiateViewControllerWithIdentifier:@"employeeAvailability"];
    
    obj_employeeAvailability.employeeUserId = self.employeeId;
    
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:obj_employeeAvailability];
    
    obj_nav.definesPresentationContext = YES;
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:obj_nav animated:YES completion:nil];
}

- (IBAction)invitedForNewJobClicked:(id)sender {
    EmployerLastDetailsCtr *obj_EmployerLastDetailsCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployerLastDetailsCtr"];
    obj_EmployerLastDetailsCtr.isFrominVitedScreen = YES;
    [self.navigationController pushViewController:obj_EmployerLastDetailsCtr animated:YES];
}

- (IBAction)inviteForPostedJobClicked:(id)sender {
    
    inviteForPostedJob *obj_inviteForPostedJob =[self.storyboard instantiateViewControllerWithIdentifier:@"inviteForPostedJob"];
    
    obj_inviteForPostedJob.EmployeeName = self.employeeName;
    
    
    UINavigationController *obj_nav = [[UINavigationController alloc]initWithRootViewController:obj_inviteForPostedJob];
    
    obj_nav.definesPresentationContext = YES;
    obj_nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:obj_nav animated:YES completion:nil];
}



- (IBAction)onClickBtnLeft:(id)sender {

    NSArray *visibleItems = [_obj_CollectionView indexPathsForVisibleItems];
    
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item -1 inSection:currentItem.section];
    
    if (nextItem.row>=0) {
        
        _employeeSelected = nextItem.row;
       
        
        [UIView setAnimationsEnabled:NO];
        
        [_obj_CollectionView performBatchUpdates:^{
            
            [_obj_CollectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_employeeSelected inSection:0]]];
            
        } completion:^(BOOL finished) {
            [UIView setAnimationsEnabled:YES];
        }];
        

        [_obj_CollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

- (IBAction)onClickBtnRight:(id)sender {

    NSArray *visibleItems = [_obj_CollectionView indexPathsForVisibleItems];
    
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item + 1 inSection:currentItem.section];
    
    if ([kAppDel.obj_responseEmployeesList.employeeCategoryName count]-1>=nextItem.item) {
        
        _employeeSelected = nextItem.item;
        
        [UIView setAnimationsEnabled:NO];
        
        [_obj_CollectionView performBatchUpdates:^{
            
            [_obj_CollectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_employeeSelected inSection:0]]];
            
        } completion:^(BOOL finished) {
            [UIView setAnimationsEnabled:YES];
        }];
         [_obj_CollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}




#pragma mark  - chatHistory -
-(void)chatHistory{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    __chatHistoryArray = [[NSMutableArray alloc]init];
    
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    
    [_param setObject:@"chatHistory" forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"recieverId"];
    
    [_param setObject:userType forKey:@"userType"];
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [kAppDel.progressHud hideAnimated:YES];
        
        __chatHistoryArray = [responseObject valueForKey:@"data"];
        
        employeeMainChat *obj_employeeMainChat = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeMainChat"];
        
        if (__chatHistoryArray.count>0) {
            obj_employeeMainChat.arrayHistory = __chatHistoryArray;
        }
        else{
        obj_employeeMainChat.FromEmployerInvite = EmployeeDetails;
        }

        [self.navigationController pushViewController:obj_employeeMainChat animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kAppDel.progressHud hideAnimated:YES];
        
    }];
}

@end
