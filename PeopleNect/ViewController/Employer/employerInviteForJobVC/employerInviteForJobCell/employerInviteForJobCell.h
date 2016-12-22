//
//  employerInviteForJobCell.h
//  PeopleNect
//
//  Created by Narendra Pandey on 09/09/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubcategoryInfo.h"
#import "PN_Constants.h"

@interface employerInviteForJobCell : UICollectionViewCell
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UILabel *lblEmployeeCategory;

@property (strong, nonatomic) IBOutlet UILabel *lblEmployeeName;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UIImageView *imgStarRating5;
@property (strong, nonatomic) IBOutlet UIImageView *imgStarRating4;
@property (strong, nonatomic) IBOutlet UIImageView *imgStarRating3;
@property (strong, nonatomic) IBOutlet UIImageView *imgStarRating2;
@property (strong, nonatomic) IBOutlet UIImageView *imgStarRating1;
@property (strong, nonatomic) IBOutlet UICollectionView *obj_SubcategoryCV;
@property (strong, nonatomic) IBOutlet UIView *CellView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *CategoryDistanceWidthConstraints;

@property (strong, nonatomic) IBOutlet UILabel *lblDistance;
@end
