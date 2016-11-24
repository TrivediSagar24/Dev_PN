//
//  GlobalMethods.m
//  PeopleNect
//
//  Created by Apple on 29/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "GlobalMethods.h"

@implementation GlobalMethods
+(UIBarButtonItem *)customNavigationBarButton:(SEL)selector{
    UIBarButtonItem *backBarItem;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
    
    [button setImage:[UIImage imageNamed:@"Gray_right_arrow_.png"] forState:UIControlStateNormal];
    
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    backBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return backBarItem;
}
@end
