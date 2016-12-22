//
//  inviteForPostedJob.h
//  PeopleNect
//
//  Created by Narendra Pandey on 16/11/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "postedJobCell.h"
#import "postedJobCell.h"
#import "GlobalMethods.h"

@interface inviteForPostedJob : UIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *postedJobTableView;
@property(strong,nonatomic) NSMutableDictionary *allJobs;
@property(strong,nonatomic) NSString *EmployeeName;


@end
