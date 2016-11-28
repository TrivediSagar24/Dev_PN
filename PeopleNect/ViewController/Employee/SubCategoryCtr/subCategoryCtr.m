//
//  subCategoryCtr.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/2/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "subCategoryCtr.h"
#import "PN_Constants.h"
#import "GlobalMethods.h"
#import "subCategoryCollectionCell.h"
#import "lastRegisterCtr.h"
#import "EmployerLastDetailsCtr.h"
@interface subCategoryCtr ()
{
    NSMutableArray *selectedSubCategoryArray,*selectedIndexPath;
    NSArray *selectedItems;
    NSString *userId,*EmployeeUserId;
    BOOL Navigater;
    int checkedSetting;
}
@end
@implementation subCategoryCtr
@synthesize CategoryUserId,imagePicker;
#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    Navigater = NO;
    checkedSetting = 0;
    EmployeeUserId = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"];
    selectedSubCategoryArray = [[NSMutableArray alloc]init];
    
    _SubCategoryName = [[NSMutableArray alloc]init];
    _mutDictSubCategoryList = [[NSMutableDictionary alloc]init];
    selectedIndexPath = [[NSMutableArray alloc]init];
    userId = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployeeUserId"];
    _navigateButton.hidden = NO;
    if (userId.length==0) {
        userId=  [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"];
        _navigateButton.hidden = YES;
    }

    self.subCategoryCollectionView.backgroundColor = [UIColor clearColor];

    if ( _iscomingFromSettingCtr==YES)
    {
        selectedItems = [kAppDel.obj_responseEmployeeUserDetail.Employee_sub_category_id componentsSeparatedByString:@","];
        
        checkedSetting = 1;
    }
     [self subCategoryId];
    
    _subCategoryCollectionView.allowsMultipleSelection = YES;
    
    _profileImage.layer.cornerRadius = kDEV_PROPROTIONAL_Height(96)/2;
    
    _profileImage.layer.masksToBounds = YES;
    if (EmployeeUserId.length==0){
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


//-(void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    
//    self.btnCamera.layer.cornerRadius = self.btnCamera.frame.size.height/2;
//    
//    self.btnCamera.layer.masksToBounds = YES;
//    if (kAppDel.EmployerProfileImage==nil) {
//    }
//    else{
//        self.btnCamera.layer.borderWidth = 1;
//    }
//    if (_iscomingFromSettingCtr == NO) {
//          self.btnCamera.layer.borderColor = [UIColor colorWithRed:220/255 green:220/255 blue:220/255 alpha:1.0].CGColor;
//    }
//}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (EmployeeUserId.length==0) {
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
        self.navigationItem.hidesBackButton = YES;
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.translucent = NO;
        self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(popViewBackClicked:) Target:self Image:@"Gray_right_arrow_"];
        if (kAppDel.EmployerProfileImage==nil) {
            
        }
        else{
        }
    }
    else{
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    }

if (_iscomingFromSettingCtr==YES)
    {
        _arrowRightImg.hidden = YES;
        _lblNextBtnTitle.text = @"Save";
    }
}


#pragma mark - subCategory Web services
-(void)subCategoryId
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if ([GlobalMethods InternetAvailability]) {
        kAppDel.progressHud =[GlobalMethods ShowProgressHud:self.view];
        
        [dict setObject:@"subCategoryList" forKey:@"methodName"];
        [dict setObject:CategoryUserId forKey:@"categoryId"];
        [dict setObject:userId forKey:@"userId"];
        [kAFClient POST:MAIN_URL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [kAppDel.progressHud hideAnimated:YES];
             
             if ([[responseObject valueForKey:@"status"] isEqual:@1])
             {
                 if ([[responseObject valueForKey:@"message"] isEqualToString:@"No Sub Category Found"]){
                 }
                 else{
                     [_mutDictSubCategoryList setObject:[[responseObject valueForKey:@"subCategoryList"] valueForKey:@"subCategoryName"] forKey:@"subCategoryName"];
                     
                     [_mutDictSubCategoryList setObject:[[responseObject valueForKey:@"subCategoryList"] valueForKey:@"subCategoryId"] forKey:@"subCategoryId"];
                     
                     for (int i = 0; i<[[_mutDictSubCategoryList valueForKey:@"subCategoryId"]count]; i++){
                         [selectedIndexPath addObject:@"0"];
                     }
                     
                     BOOL contain = [[NSSet setWithArray: selectedItems] isSubsetOfSet: [NSSet setWithArray: [_mutDictSubCategoryList valueForKey:@"subCategoryId"]]];
                     
                     
                     if (contain==TRUE) {
                         if (checkedSetting ==1) {
                             for (int i = 0 ; i<selectedItems.count; i++) {
                                 
                                 NSUInteger index = [[_mutDictSubCategoryList valueForKey:@"subCategoryId"] indexOfObject:[selectedItems objectAtIndex:i]];
                                 
                                 [selectedIndexPath replaceObjectAtIndex:index withObject:@"1"];
                                 
                                 [selectedSubCategoryArray addObject:[[_mutDictSubCategoryList valueForKey:@"subCategoryId"]objectAtIndex:index]];
                                 
                                 [_SubCategoryName addObject:[[_mutDictSubCategoryList valueForKey:@"subCategoryName"]objectAtIndex:index]];
                             }
                             
                         }
                         
                     }else{
                         
                     }
                 }
             }
             self.subCategoryCollectionView.delegate = self;
             self.subCategoryCollectionView.dataSource = self;
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [kAppDel.progressHud hideAnimated:YES];
             
         }];

    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"Internet Connection" Message:InternetAvailbility AlertMessage:@"OK"] animated:YES completion:nil];
    }
}


#pragma mark - IBActions
- (IBAction)popViewBackClicked:(id)sender
{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
    {
        if ([viewControllrObj isKindOfClass:[CategoryEmployeeCtr class]])
        {
            [self.navigationController popToViewController:viewControllrObj animated:YES];
        }
    }
}
- (IBAction)btnNextClicked:(id)sender{
    if (_iscomingFromSettingCtr == YES)
    {
    EmployeeSettings *obj_EmployeeSettings = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeSettings"];
        obj_EmployeeSettings.strCategory = _CategoryName;
         obj_EmployeeSettings.strSubCategory = [_SubCategoryName  componentsJoinedByString:@","];
        obj_EmployeeSettings.strCategoryId = CategoryUserId;
        obj_EmployeeSettings.strSubCategoryId = [selectedSubCategoryArray  componentsJoinedByString:@","];
        Navigater = YES;
        if (selectedSubCategoryArray.count>0) {
           [self.navigationController pushViewController:obj_EmployeeSettings animated:YES];
        }else{
            [self presentViewController:[GlobalMethods AlertWithTitle:@"" Message:@"Please Select any one Subcategory" AlertMessage:@"OK"] animated:YES completion:nil];
        }
    }
    if (EmployeeUserId.length==0) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"PostJob"] isEqualToString:@"Slider"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"PostJob"] isEqualToString:@"repost"]) {
            EmployerLastDetailsCtr *obj_EmployerLastDetailsCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployerLastDetailsCtr"];
            obj_EmployerLastDetailsCtr.categoryId = CategoryUserId;
            obj_EmployerLastDetailsCtr.subCategoryId =[selectedSubCategoryArray  componentsJoinedByString:@","];
            Navigater = YES;
            if (selectedSubCategoryArray.count>0) {
                [self.navigationController pushViewController:obj_EmployerLastDetailsCtr animated:YES];
            }else{
                [self presentViewController:[GlobalMethods AlertWithTitle:@"" Message:@"Please Select any one Subcategory" AlertMessage:@"OK"] animated:YES completion:nil];
            }
        }
           }
    if (Navigater == NO) {
            lastRegisterCtr *obj_lastRegisterCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"lastRegisterCtr"];
            obj_lastRegisterCtr.categoryId = CategoryUserId;
            obj_lastRegisterCtr.strsubCategoryId = [selectedSubCategoryArray  componentsJoinedByString:@","];
        if (selectedSubCategoryArray.count>0) {
            [self.navigationController pushViewController:obj_lastRegisterCtr animated:YES];
        }else{
            [self presentViewController:[GlobalMethods AlertWithTitle:@"" Message:@"Please Select any one Subcategory" AlertMessage:@"OK"] animated:YES completion:nil];
        }
        }
}
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

#pragma mark - ImagePicker Delegates.

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _profileImage.image = chosenImage;
    
    //[self.btnCamera setImage:chosenImage forState:UIControlStateNormal];
    if (EmployeeUserId.length==0) {
        kAppDel.EmployerProfileImage = chosenImage;
    }else{
        kAppDel.EmployeeProfileImage = chosenImage;
    }    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - collectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_mutDictSubCategoryList.count>1)
    {
         return [[_mutDictSubCategoryList valueForKey:@"subCategoryId"]count];
    }
    else
    {
        return 0;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    subCategoryCollectionCell *Cell
  = [collectionView dequeueReusableCellWithReuseIdentifier:@"subCategoryCollectionCell" forIndexPath:indexPath];
    
    Cell.subCategoryCollectionCellView.layer.cornerRadius = 20;
    
    [Cell.subCategoryCollectionCellButton setTitle:[NSString stringWithFormat:@" %@ ",[[_mutDictSubCategoryList valueForKey:@"subCategoryName"]objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    
    Cell.subCategoryCollectionCellButton.tag = indexPath.item;
    
    [Cell.subCategoryCollectionCellButton addTarget:self action:@selector(ButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [Cell.subCategoryCollectionCellButton setImage: [ UIImage imageNamed:@"arrow_.png"] forState:UIControlStateSelected];
    
    [Cell.subCategoryCollectionCellButton setTitleColor:[UIColor colorWithRed:186.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
     [Cell.subCategoryCollectionCellButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [Cell.subCategoryCollectionCellButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:32.0/255.0 green:88.0/255.0 blue:140.0/255.0 alpha:1.0]] forState:UIControlStateSelected];

    [Cell.subCategoryCollectionCellButton setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    Cell.subCategoryCollectionCellView.clipsToBounds = YES;

        if ([[selectedIndexPath objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
            
            Cell.subCategoryCollectionCellButton.selected = YES;
            
            [self ButtonSelectedForCell:Cell.subCategoryCollectionCellButton];
        }
        else{
            Cell.subCategoryCollectionCellView.backgroundColor = [UIColor whiteColor];
            Cell.subCategoryCollectionCellButton.selected = NO;
        }
    return Cell;
}


-(void)ButtonSelected:(UIButton*)sender{
    
    if([[selectedIndexPath objectAtIndex:sender.tag] isEqualToString:@"0"]){
            
            [selectedIndexPath replaceObjectAtIndex:sender.tag withObject:@"1"];
            
            [selectedSubCategoryArray addObject:[[_mutDictSubCategoryList valueForKey:@"subCategoryId"]objectAtIndex:sender.tag]];
            
            [_SubCategoryName addObject:[[_mutDictSubCategoryList valueForKey:@"subCategoryName"]objectAtIndex:sender.tag]];
        }
        else{
            [selectedIndexPath replaceObjectAtIndex:sender.tag withObject:@"0"];
            [selectedSubCategoryArray removeObject:[[_mutDictSubCategoryList valueForKey:@"subCategoryId"]objectAtIndex:sender.tag]];
            
            [_SubCategoryName removeObject:[[_mutDictSubCategoryList valueForKey:@"subCategoryName"]objectAtIndex:sender.tag]];
        }
        [_subCategoryCollectionView reloadData];
}

-(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


-(void)ButtonSelectedForCell:(UIButton *)CellButton
{
   CellButton.backgroundColor = [UIColor colorWithRed:32.0/255.0 green:88.0/255.0 blue:140.0/255.0 alpha:1.0];
    CellButton.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    CellButton.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    CellButton.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
}
#pragma mark - collectionView flowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize calCulateSizze =[(NSString*)[NSString stringWithFormat:@" %@ ",[[_mutDictSubCategoryList valueForKey:@"subCategoryName"]objectAtIndex:indexPath.row]]  sizeWithAttributes:NULL];
    
    CGFloat width =calCulateSizze.width+80;
    
    if (width> _subCategoryCollectionView.frame.size.width )
    {
        width = _subCategoryCollectionView.frame.size.width;
    }
    
    return CGSizeMake(width, 50);
}


@end
