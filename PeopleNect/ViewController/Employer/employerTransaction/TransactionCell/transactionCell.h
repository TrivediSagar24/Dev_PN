//
//  transactionCell.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface transactionCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *circularLbl;
@property (strong, nonatomic) IBOutlet UILabel *lineLbl;
@property (strong, nonatomic) IBOutlet UILabel *invitedLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;

@end
