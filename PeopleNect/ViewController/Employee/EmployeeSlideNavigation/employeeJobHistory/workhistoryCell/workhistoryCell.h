//
//  workhistoryCell.h
//  PeopleNect
//
//  Created by Apple on 07/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface workhistoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (strong, nonatomic) IBOutlet UILabel *reviewLbl;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UIImageView *twoStar;
@property (strong, nonatomic) IBOutlet UIImageView *threeStar;
@property (strong, nonatomic) IBOutlet UIImageView *fourStar;
@property (strong, nonatomic) IBOutlet UIImageView *fiveStar;

@property (strong, nonatomic) IBOutlet UIImageView *oneStar;
@end
