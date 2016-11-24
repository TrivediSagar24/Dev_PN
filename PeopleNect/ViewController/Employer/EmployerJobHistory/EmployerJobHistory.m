//
//  EmployerJobHistory.m
//  PeopleNect
//
//  Created by Apple on 25/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "EmployerJobHistory.h"

@interface EmployerJobHistory ()

@end

@implementation EmployerJobHistory
#pragma mark - ViewLifecycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    _jobHistoryCollectionView.backgroundColor = [UIColor clearColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark - SlideNavigationController Methods -
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

@end
