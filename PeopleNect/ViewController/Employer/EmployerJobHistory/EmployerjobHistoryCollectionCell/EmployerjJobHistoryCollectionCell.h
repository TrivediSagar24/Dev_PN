//
//  EmployerjJobHistoryCollectionCell.h
//  PeopleNect
//
//  Created by Narendra Pandey on 25/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployerjJobHistoryCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (strong, nonatomic) IBOutlet UILabel *reviewLbl;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UIImageView *oneStar;
@property (strong, nonatomic) IBOutlet UIImageView *twoStar;
@property (strong, nonatomic) IBOutlet UIImageView *threeStar;
@property (strong, nonatomic) IBOutlet UIImageView *fourStar;
@property (strong, nonatomic) IBOutlet UIImageView *fiveStar;

@end
