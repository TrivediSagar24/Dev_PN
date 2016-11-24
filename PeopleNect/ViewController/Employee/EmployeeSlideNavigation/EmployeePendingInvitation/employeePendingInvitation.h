//
//  employeePendingInvitation.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/7/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "employeePendingCell.h"

@interface employeePendingInvitation : UIViewController
<UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UILabel *pendingApplicationLbl;
@property (strong, nonatomic) IBOutlet UICollectionView *pendingCollectionView;
@property(strong,nonatomic) NSMutableArray *pendingJobInfo;
@end
