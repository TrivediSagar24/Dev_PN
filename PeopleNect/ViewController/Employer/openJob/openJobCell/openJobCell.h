//
//  openJobCell.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/23/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface openJobCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (strong, nonatomic) IBOutlet UIButton *publishBtn;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;

@end
