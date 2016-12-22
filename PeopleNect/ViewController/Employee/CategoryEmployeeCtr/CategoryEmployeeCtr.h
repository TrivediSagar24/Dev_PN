//
//  CategoryEmployeeCtr.h
//  PeopleNect
//
//  Created by Narendra Pandey on 8/1/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryCollectionCollectionViewCell.h"
#import "PN_Constants.h"
#import "GlobalMethods.h"
#import "employeeViewController.h"
#import "subCategoryCtr.h"
#import "EmployeeSettings.h"
#import "repostJobEmployerCtr.h"
@interface CategoryEmployeeCtr : UIViewController
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionCategory;

@property (strong, nonatomic) IBOutlet UIView *profileView;
@property(strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property(nonatomic)BOOL iscomingFromSettingCtr;
@property(strong,nonatomic)NSString *selectedCategoryId;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;

- (IBAction)btnCameraClicked:(id)sender;
- (IBAction)popViewBackClicked:(id)sender;



@end
