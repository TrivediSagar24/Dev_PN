//
//  selectedEmployeeInfo.h
//  PeopleNect
//
//  Created by Apple on 29/09/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectedEmployeeInfo : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *chatBtn;
@property (strong, nonatomic) IBOutlet UILabel *chatLbl;
@property (strong, nonatomic) IBOutlet UILabel *freeLbl;

@property (strong, nonatomic) IBOutlet UIButton *freeBtn;
@property (strong, nonatomic) IBOutlet UIButton *MenuClicked;
 


- (IBAction)freeBtnClicked:(id)sender;
- (IBAction)chatClicked:(id)sender;

@end
