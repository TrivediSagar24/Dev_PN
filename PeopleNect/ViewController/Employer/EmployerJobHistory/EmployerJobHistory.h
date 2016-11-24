//
//  EmployerJobHistory.h
//  PeopleNect
//
//  Created by Apple on 25/10/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface EmployerJobHistory : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *jobHistoryLbl;
@property (strong, nonatomic) IBOutlet UICollectionView *jobHistoryCollectionView;

@end
