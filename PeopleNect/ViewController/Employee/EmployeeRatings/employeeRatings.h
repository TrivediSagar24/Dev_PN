//
//  employeeRatings.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"

@interface employeeRatings : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *regularLbl;
@property (strong, nonatomic) IBOutlet UIButton *twoStar;
@property (strong, nonatomic) IBOutlet UIButton *threeStar;
@property (strong, nonatomic) IBOutlet UIButton *fourStar;
@property (strong, nonatomic) IBOutlet UIButton *fiveStar;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@property (strong, nonatomic) IBOutlet UIButton *oneStar;


- (IBAction)OneStaeClicked:(id)sender;
- (IBAction)twoStarClicked:(id)sender;
- (IBAction)threeStarClicked:(id)sender;
- (IBAction)SendClicked:(id)sender;
- (IBAction)fourStarClicked:(id)sender;
- (IBAction)fiveStarClicked:(id)sender;

@end
