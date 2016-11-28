//
//  CategoryEmployeeCtr.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/1/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "CategoryEmployeeCtr.h"


@interface CategoryEmployeeCtr ()
{
    NSString *userId,*employeeUserId;
}
@end

@implementation CategoryEmployeeCtr
@synthesize imagePicker;

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userId = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"];
    
    employeeUserId = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"];
    
    if (userId.length==0) {
        userId= [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"];
    }
    [self categoryId];
  
//    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"Setting"] isEqualToString:@"True"])
//    {
//        _backBtn.hidden = NO;
//    }
//    else
//    {
//        _backBtn.hidden = YES;
//    }
    
    if (_iscomingFromSettingCtr ==YES) {
        _backBtn.hidden = NO;
    }else{
        _backBtn.hidden = YES;
    }
    
    _profileImage.layer.cornerRadius = kDEV_PROPROTIONAL_Height(96)/2;
    
    _profileImage.layer.masksToBounds = YES;
    if (employeeUserId.length==0){
        if (kAppDel.EmployerProfileImage==nil) {
            _profileImage.image = [UIImage imageNamed:@"profile"];
        }
        else{
            _profileImage.image = kAppDel.EmployerProfileImage;
        }
    }else{
        _profileImage.image = kAppDel.EmployeeProfileImage;
    }
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (employeeUserId.length==0) {
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
        self.navigationItem.hidesBackButton = YES;
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.translucent = NO;
        self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(popViewBackClicked:) Target:self Image:@"Gray_right_arrow_"];
    }
    else{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    }
}


#pragma mark - collectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (kAppDel.obj_EmployeeCategory.categoryList.count>1)
    {
         return [[kAppDel.obj_EmployeeCategory.categoryList valueForKey:@"categoryId"]count];
    }
    else
    {
        return 0;
    }
   
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   CategoryCollectionCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionCollectionViewCell" forIndexPath:indexPath];
    
    Cell.lblDescription.textAlignment = NSTextAlignmentCenter;
    
    Cell.lblDescription.text = [[kAppDel.obj_EmployeeCategory.categoryList valueForKey:@"categoryName"]objectAtIndex:indexPath.row];
    Cell.lblDescription.textColor = [UIColor colorWithRed:105.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:1];
    Cell.cellView.backgroundColor = [UIColor whiteColor];
    Cell.borderLbl.backgroundColor = [UIColor colorWithRed:143.0/255.0 green:163.0/255.0 blue:186.0/255.0 alpha:1.0];
   
    /*
if ([_selectedCategoryId isEqualToString:[[kAppDel.obj_EmployeeCategory.categoryList valueForKey:@"categoryId"]objectAtIndex:indexPath.row]]) {
    
    Cell.cellView.backgroundColor = [UIColor blueColor];
    Cell.borderLbl.backgroundColor = [UIColor greenColor];
    UIFont* boldFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    [Cell.lblDescription setFont:boldFont];
    Cell.lblDescription.textColor = [UIColor whiteColor];
    
    }
   */
    
    return Cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    subCategoryCtr  *obj_subCategoryCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"subCategoryCtr"];
    
    obj_subCategoryCtr.CategoryUserId = [[kAppDel.obj_EmployeeCategory.categoryList valueForKey:@"categoryId"]objectAtIndex:indexPath.row];
    
     obj_subCategoryCtr.CategoryName = [[kAppDel.obj_EmployeeCategory.categoryList valueForKey:@"categoryName"]objectAtIndex:indexPath.row];
    
    if (_iscomingFromSettingCtr==YES) {
        obj_subCategoryCtr.iscomingFromSettingCtr = YES;
    }
    [self.navigationController pushViewController:obj_subCategoryCtr animated:YES];
}

#pragma mark - collectionView flowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = _collectionCategory.frame.size.width/2;
    
    CGFloat height = _collectionCategory.frame.size.height/4;

       return CGSizeMake(width-10, height-35);
}

#pragma mark - CateGory WebServices

-(void)categoryId
{
    
    if ([GlobalMethods InternetAvailability]) {
        
        kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        
        [dict setObject:@"categoryList" forKey:@"methodName"];
        
        [dict setObject:userId forKey:@"userId"];
        
        [kAFClient POST:MAIN_URL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [kAppDel.progressHud hideAnimated:YES];
             
             kAppDel.obj_EmployeeCategory = [[EmployeeCategory alloc]initWithDictionary:responseObject];
             
             _collectionCategory.delegate = self;
             
             _collectionCategory.dataSource = self;
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [kAppDel.progressHud hideAnimated:YES];
             
         }];

    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}

#pragma  mark - IBAction

- (IBAction)btnCameraClicked:(id)sender
{
    imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate =self;
    
    imagePicker.allowsEditing = YES;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select One" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
    {

        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
        else
        {
            [self presentViewController:[GlobalMethods AlertWithTitle:@"Camera Missing" Message:@"It seems that no camera is attached to this device" AlertMessage:@"OK"]animated:YES completion:nil];
        }
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {

        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)popViewBackClicked:(id)sender
{

    if (_iscomingFromSettingCtr==YES) {
        for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
        {
            if ([viewControllrObj isKindOfClass:[EmployeeSettings class]])
            {
                [self.navigationController popToViewController:viewControllrObj animated:YES];
            }
        }

    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"PostJob"] isEqualToString:@"repost"]) {
        for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
        {
        if ([viewControllrObj isKindOfClass:[MenuCtr class]])
            {
                [self.navigationController popToViewController:viewControllrObj animated:YES];
            }
        }
    }
}

#pragma mark - ImagePicker Delegates.

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    _profileImage.image = chosenImage;
    
    //[self.btnCamera setImage:chosenImage forState:UIControlStateNormal];

    if (employeeUserId.length==0) {
        kAppDel.EmployerProfileImage = chosenImage;
    }else{
    kAppDel.EmployeeProfileImage = chosenImage;
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"PostJob"] isEqualToString:@"Slider"]) {
        return YES;
    }
     if ( _iscomingFromSettingCtr==YES)
     {
         return NO;
     }
    else
        return NO;
}
- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

@end
