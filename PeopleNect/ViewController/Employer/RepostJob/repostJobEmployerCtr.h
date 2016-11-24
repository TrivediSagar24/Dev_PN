//
//  repostJobEmployerCtr.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/22/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "ViewController.h"
#import "repostCell.h"
#import "MenuCtr.h"
#import "CategoryEmployeeCtr.h"
#import "EmployerLastDetailsCtr.h"
@interface repostJobEmployerCtr : UIViewController
<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *profileView;
@property (strong, nonatomic) IBOutlet UITableView *respostTableView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;

@end
