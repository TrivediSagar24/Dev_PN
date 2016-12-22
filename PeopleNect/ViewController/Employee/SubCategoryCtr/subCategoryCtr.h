//
//  subCategoryCtr.h
//  PeopleNect
//
//  Created by Narendra Pandey on 8/2/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployeeSettings.h"
#import "CategoryEmployeeCtr.h"
@interface subCategoryCtr : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)NSString *CategoryUserId;
@property(strong,nonatomic)NSString *CategoryName;
@property(strong,nonatomic)NSMutableArray *SubCategoryName;
@property (strong, nonatomic) IBOutlet UIView *profileView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;

@property (strong, nonatomic) IBOutlet UICollectionView *subCategoryCollectionView;
@property (strong, nonatomic) NSMutableDictionary *mutDictSubCategoryList;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property(strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIImageView *arrowRightImg;
@property(nonatomic)BOOL iscomingFromSettingCtr;
@property (strong, nonatomic) IBOutlet UILabel *lblNextBtnTitle;
@property (strong, nonatomic) IBOutlet UIButton *navigateButton;

- (IBAction)popViewBackClicked:(id)sender;
- (IBAction)btnNextClicked:(id)sender;
@end
