//
//  repostCell.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/22/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface repostCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *repostLbl;
@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (strong, nonatomic) IBOutlet UILabel *respostJobLbl;
@property (strong, nonatomic) IBOutlet UIButton *arrowBtn;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong, nonatomic) IBOutlet UILabel *borderLabel;

@end
