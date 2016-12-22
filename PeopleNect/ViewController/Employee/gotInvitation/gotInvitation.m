
//
//  gotInvitation.m
//  PeopleNect
//
//  Created by Narendra Pandey on 9/12/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "gotInvitation.h"

@interface gotInvitation ()

@end

@implementation gotInvitation
#pragma mark - ViewLifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

#pragma mark - IBActions -
- (IBAction)AcceptClicked:(id)sender {
}

- (IBAction)refuseClicked:(id)sender {
}

- (IBAction)DecideLaterClicked:(id)sender {
}
@end
