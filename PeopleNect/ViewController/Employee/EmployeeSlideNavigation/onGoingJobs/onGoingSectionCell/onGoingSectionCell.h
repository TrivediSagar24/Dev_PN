//
//  onGoingSectionCell.h
//  PeopleNect
//
//  Created by Apple on 06/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface onGoingSectionCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *companyNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *kmLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *ratingLbl;
@property (strong, nonatomic) IBOutlet UIImageView *starImg;
@property (strong, nonatomic) IBOutlet UILabel *jobDescriptionLbl;
@property (strong, nonatomic) IBOutlet UIImageView *mapImg;
@property (strong, nonatomic) IBOutlet UILabel *addressLbl;
@property (strong, nonatomic) IBOutlet UIImageView *clockImg;
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;

@property (strong, nonatomic) IBOutlet UIButton *followBtn;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@end
