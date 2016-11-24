//
//  searchTableViewCell.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "employeeCategoryMapCell.h"
#import "GlobalMethods.h"
#import "PN_Constants.h"

@interface searchTableViewCell : UITableViewCell
<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *ExpandCellClidked;
@property (strong, nonatomic) IBOutlet UILabel *lblPricetag;
@property (strong, nonatomic) IBOutlet UILabel *lblJobTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblRatings;
@property (strong, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (strong, nonatomic) IBOutlet UILabel *lblKM;

@property (strong, nonatomic) IBOutlet UILabel *lblStartDate;
@property (strong, nonatomic) IBOutlet UIView *TopView;

@property (strong, nonatomic) IBOutlet UIView *middleView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *lblBlueBorder;
@property (strong, nonatomic) IBOutlet UIImageView *mapImage;
@property (strong, nonatomic) IBOutlet UILabel *lblSecondPricetag;
@property (strong, nonatomic) IBOutlet UILabel *lblSecondJobDescription;
@property (strong, nonatomic) IBOutlet UICollectionView *employeeMapCategoryCollection;
@property (strong, nonatomic) IBOutlet UILabel *middleViewCompanyName;
@property (strong, nonatomic) IBOutlet UIImageView *middleMapImage;
@property (strong, nonatomic) IBOutlet UILabel *middleStartDate;
@property (strong, nonatomic) IBOutlet UILabel *lblthirdPricetag;
@property (strong, nonatomic) IBOutlet UILabel *middleViewLBLKM;
@property (strong, nonatomic) IBOutlet UIButton *btnCanditatureClicked;
@property (strong, nonatomic) IBOutlet UILabel *BorderLblStraight;
@property (strong, nonatomic) IBOutlet
UILabel *BorderLblStraightSelected;

@property (strong, nonatomic) IBOutlet UILabel *toplLblStraight;
@property (strong, nonatomic) IBOutlet UILabel *middleTopLbl;
@property (strong, nonatomic) IBOutlet UILabel *bottomTopLbl;
@property (strong, nonatomic) IBOutlet UILabel *borderBottomLyingLbl;

- (IBAction)btnCandidatureClicked:(id)sender;


@end
