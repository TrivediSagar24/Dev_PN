//
//  employerInviteForJobVC.h
//  PeopleNect
//
//  Created by Narendra Pandey on 08/09/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "SubcategoryInfo.h"
#import "PN_Constants.h"
#import "UIButton+WebCache.h"
#import "employerInviteForJobCell.h"
#import "employeeAvailability.h"
#import "inviteForPostedJob.h"

@interface employerInviteForJobVC : UIViewController
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *obj_CollectionView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UIButton *chatBtn;
@property (strong, nonatomic) IBOutlet UIButton *busyBtn;
@property (strong, nonatomic) IBOutlet UILabel *chatLabel;
@property (strong, nonatomic) IBOutlet UIView *ProfileView;
@property (strong, nonatomic) IBOutlet UIView *leftViewArrow;
@property (strong, nonatomic) IBOutlet UIView *rightViewArrow;
@property (strong, nonatomic) IBOutlet UIButton *ProfileBtn;
@property (strong, nonatomic) IBOutlet UIView *invitedJobView;
@property (strong, nonatomic) IBOutlet UIButton *postedJobBtn;
@property (strong, nonatomic) IBOutlet UIView *chatView;
@property (strong, nonatomic) IBOutlet UIView *busyView;

@property (strong,nonatomic) NSString *employeeName;
@property (strong,nonatomic) NSString *employeeImage;
@property (strong,nonatomic) NSString *employeeCategory;
@property (strong,nonatomic) NSString *categoryID;
@property (strong,nonatomic) NSString *subCategoryID;
@property (strong,nonatomic) NSString *employeeExpYears;
@property (strong,nonatomic) NSString *employeeDistance;
@property (strong,nonatomic) NSString *employeeDescription;
@property (strong,nonatomic) NSString  *employeeRatings;
@property (strong, nonatomic) NSString *employeeId;
@property (nonatomic,assign) NSInteger employeeSelected;
@property (strong, nonatomic) NSMutableArray *_chatHistoryArray;
@property(nonatomic)BOOL isfromOpenJobSelected;
@property(strong,nonatomic)NSMutableArray *invitedJobListArray;


- (IBAction)onClickMenu:(id)sender;
- (IBAction)onClickChat:(id)sender;
- (IBAction)onClickBtnLeft:(id)sender;
- (IBAction)onClickBtnRight:(id)sender;
- (IBAction)busyBtnClicked:(id)sender;
- (IBAction)invitedForNewJobClicked:(id)sender;
- (IBAction)inviteForPostedJobClicked:(id)sender;

@end
