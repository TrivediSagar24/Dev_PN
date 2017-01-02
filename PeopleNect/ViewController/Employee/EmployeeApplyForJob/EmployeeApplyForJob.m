//
//  EmployeeApplyForJob.m
//  PeopleNect
//
//  Created by Narendra Pandey on 9/6/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "EmployeeApplyForJob.h"

@interface EmployeeApplyForJob ()

@end

@implementation EmployeeApplyForJob
#pragma mark - View LifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self label:_jobTitleCmpyLbl];
    
    _jobTitleCmpyLbl.text = [NSString stringWithFormat:@"Follow up on @%@\n at @%@",_jobTitle,_companyName];
    
    _ApplicationSentlbl.text = _applicationSent;
    
    _waitingLbl.text = _applicationWaiting;
    
    _waitingFeedback.text =_applicationFeedback;

    if ([_wait isEqualToString:@"wait"]) {
        [self waitingDotLabel];
    }
    if ([_result isEqualToString:@"selected"]) {
       
        _feedbackImageView.image = [UIImage imageNamed:@"like_"];
        [self waitingDotLabel];
    }
    if ([_result isEqualToString:@"rejected"]) {
//        _feedbackImageView.image = [UIImage imageNamed:@"like_"];
        [self waitingDotLabel];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"Gray_right_arrow_"];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self radiusLbl];
    if ([_wait isEqualToString:@"wait"]|| [_result isEqualToString:@"selected"] || [_result isEqualToString:@"rejected"]) {
        [self waitingImage];
    }
}

#pragma mark - barBackButton  -
-(void)barBackButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UILabel Text  -
-(void)label:(UILabel*)label
{
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
}


-(void)radiusLbl
{
    _applicationLbl.layer.cornerRadius = _applicationLbl.frame.size.height/2;
    _applicationLbl.layer.masksToBounds = YES;
    _applicationLblTwo.layer.cornerRadius = _applicationLblTwo.frame.size.height/2;
    _applicationLblTwo.layer.masksToBounds = YES;
    _applicationLblThree.layer.cornerRadius = _applicationLblThree.frame.size.height/2;
    _applicationLblThree.layer.masksToBounds = YES;
    _waitingOneLbl.layer.cornerRadius = _waitingOneLbl.frame.size.height/2;
    _waitingOneLbl.layer.masksToBounds = YES;
    _waitingTwoLbl.layer.cornerRadius = _waitingTwoLbl.frame.size.height/2;
    _waitingTwoLbl.layer.masksToBounds = YES;
    _waitingThreeLbl.layer.cornerRadius = _waitingThreeLbl.frame.size.height/2;
    _waitingThreeLbl.layer.masksToBounds = YES;
    _waitingThreeLbl.alpha = 0.5;
}

-(void)waitingDotLabel{
    _waitingOneLbl.backgroundColor = RGBCOLOR(54.0, 230.0, 34.0);
    _waitingTwoLbl.backgroundColor = RGBCOLOR(54.0, 230.0, 34.0);
    _waitingThreeLbl.backgroundColor = RGBCOLOR(54.0, 230.0, 34.0);
}


-(void)waitingImage {
    _waitingImageView.frame = CGRectMake(_rightSent.frame.origin.x, _waitingImageView.frame.origin.y, _rightSent.frame.size.width, _rightSent.frame.size.height);
    _waitingImageView.image = [UIImage imageNamed:@"right_active"];
}


#pragma mark - IBActions  -
- (IBAction)searchAgainClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
