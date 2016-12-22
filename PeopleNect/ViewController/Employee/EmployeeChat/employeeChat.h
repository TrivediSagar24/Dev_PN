//
//  employeeChat.h
//  PeopleNect
//
//  Created by Narendra Pandey on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "employeeChatCell.h"
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "employeeMainChat.h"
#import "employeeJobNotification.h"
#import "UIImageView+WebCache.h"
#import "MenuCtr.h"
@interface employeeChat : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *chatHistoryTableView;
@property(strong,nonatomic) NSMutableArray *chatHistoryArray;
@end
