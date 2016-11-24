//
//  selectedEmployeeInfo.m
//  PeopleNect
//
//  Created by Apple on 29/09/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "selectedEmployeeInfo.h"

@interface selectedEmployeeInfo ()

@end

@implementation selectedEmployeeInfo

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.imgViewEmployePic.image = [UIImage imageNamed:@"profile"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (IBAction)chatClicked:(id)sender {
}
- (IBAction)freeBtnClicked:(id)sender {
}
@end
