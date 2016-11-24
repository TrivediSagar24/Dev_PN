//
//  gotInvitation.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/12/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gotInvitation : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblGotInvitation;
@property (strong, nonatomic) IBOutlet UIView *BottomView;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalHour;
@property (strong, nonatomic) IBOutlet UILabel *lblPriceHour;
@property (strong, nonatomic) IBOutlet UILabel *lblTimeDate;
@property (strong, nonatomic) IBOutlet UILabel *lblJobTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblComapanyName;
@property (strong, nonatomic) IBOutlet UILabel *lblKM;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblRatings;
@property (strong, nonatomic) IBOutlet UIImageView *mapImage;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *LblrefuseJob;
@property (strong, nonatomic) IBOutlet UIButton *acceptBtn;
@property (strong, nonatomic) IBOutlet UIButton *refuseBtn;
@property (strong, nonatomic) IBOutlet UIButton *DecideBtn;
- (IBAction)AcceptClicked:(id)sender;
- (IBAction)refuseClicked:(id)sender;
- (IBAction)DecideLaterClicked:(id)sender;
@end
