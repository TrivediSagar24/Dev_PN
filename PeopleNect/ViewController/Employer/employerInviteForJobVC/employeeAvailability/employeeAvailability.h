//
//  employeeAvailability.h
//  PeopleNect
//
//  Created by Apple on 16/11/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "ViewController.h"
#import "availabilityCell.h"
#import "GlobalMethods.h"

@interface employeeAvailability : UIViewController
<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *availabilityView;


@property (strong, nonatomic) IBOutlet UICollectionView *availableCollectionView;
@property(strong,nonatomic)NSString *employeeUserId;
- (IBAction)closeBtnClicked:(id)sender;

@end
