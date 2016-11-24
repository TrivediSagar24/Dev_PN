//
//  employeeLocationCell.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface employeeLocationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *searchCellView;
@property (strong, nonatomic) IBOutlet UILabel *SearchLbl;
@property (strong, nonatomic) IBOutlet UILabel *searchStreetLbl;
@property (strong, nonatomic) IBOutlet UIImageView *ArrowImage;

@end
