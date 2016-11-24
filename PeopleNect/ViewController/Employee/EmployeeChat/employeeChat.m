//
//  employeeChat.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeChat.h"

@interface employeeChat ()
{
    NSTimer *Timer;
    NSString *userType;
}
@end

@implementation employeeChat
#pragma mark - View LifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    userType = @"1";
 Timer = [NSTimer scheduledTimerWithTimeInterval: 0.2 target: self selector:@selector(chatHistory)userInfo: nil repeats:NO];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:32.0/255.0 green:88.0/255.0 blue:140.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
     self.navigationItem.leftBarButtonItem = [GlobalMethods customNavigationBarButton:@selector(barBackButton) Target:self Image:@"arrow-left"];
}


#pragma mark - TableView DataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _chatHistoryArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    employeeChatCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"employeeChatCell" forIndexPath:indexPath];
    
    NSString *Time = [[_chatHistoryArray valueForKey:@"Time"]objectAtIndex:indexPath.row];
    
    if ([Time length] > 0) {
    Time = [Time substringToIndex:[Time length] - 3];
    }
    
    Cell.chatTime.text = Time;
    
    Cell.userName.text = [[_chatHistoryArray valueForKey:@"SenderName"]objectAtIndex:indexPath.row];
    
    Cell.userDesc.text = [[_chatHistoryArray valueForKey:@"Message"]objectAtIndex:indexPath.row];
    
    NSString *url_Img = [[_chatHistoryArray valueForKey:@"SenderPic"]objectAtIndex:indexPath.row];
[Cell.profilePic sd_setImageWithURL: [NSURL URLWithString:url_Img]placeholderImage:[UIImage imageNamed:@"plceholder"]];
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    employeeMainChat *obj_employeeMainChat = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeMainChat"];
    
    obj_employeeMainChat.arrayHistory = [_chatHistoryArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:obj_employeeMainChat animated:YES];
}

#pragma mark - Navigation Bar Back Button -
-(void)barBackButton
{
//    [GlobalMethods dataTaskCancel];
     if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"Chat"] isEqualToString:@"Employee"])
     {
         for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
         {
             if ([viewControllrObj isKindOfClass:[employeeJobNotification class]])
             {
//                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.navigationController popToViewController:viewControllrObj animated:YES];
//                 });
             }
         }
     }
    else{
        for (UIViewController *viewControllrObj in self.navigationController.viewControllers){
        if ([viewControllrObj isKindOfClass:[MenuCtr class]])
            {
            [self.navigationController popToViewController:viewControllrObj animated:YES];
            }
        }
    }
}

#pragma mark - ChatList -

-(void)chatHistory
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    _chatHistoryArray = [[NSMutableArray alloc]init];
    
    kAppDel.progressHud = [GlobalMethods ShowProgressHud:self.view];
    
    [_param setObject:@"chatHistory" forKey:@"methodName"];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"recieverId"];
    
    [_param setObject:userType forKey:@"userType"];
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [kAppDel.progressHud hideAnimated:YES];
    _chatHistoryArray = [responseObject valueForKey:@"data"];
        
//        NSLog(@"Response OBject  %@ and count %ld",_chatHistoryArray,_chatHistoryArray.count);
        
        _chatHistoryTableView.delegate = self;
        _chatHistoryTableView.dataSource = self;
        [_chatHistoryTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
        [kAppDel.progressHud hideAnimated:YES];

    }];
}
@end
