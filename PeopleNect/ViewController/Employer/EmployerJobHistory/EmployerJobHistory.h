//
//  EmployerJobHistory.h
//  PeopleNect
//
//  Created by Narendra Pandey on 25/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployerjJobHistoryCollectionCell.h"
#import "GlobalMethods.h"
#import "PN_Constants.h"

@interface EmployerJobHistory : UIViewController
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UILabel *jobHistoryLbl;
@property (strong, nonatomic) IBOutlet UICollectionView *jobHistoryCollectionView;
@property(strong,nonatomic) NSMutableArray *responseHistory;
@end
