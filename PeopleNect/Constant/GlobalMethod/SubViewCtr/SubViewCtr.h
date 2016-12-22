//
//  SubViewCtr.h
//  PeopleNect
//
//  Created by Narendra Pandey on 01/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubViewCtr : UIView

+(instancetype)sharedInstance;
@property (strong,nonatomic) UIToolbar *obj_ToolBar;
@property (strong,nonatomic) UIPickerView *obj_PickerView;

@property (strong,nonatomic)  UIActivityIndicatorView *activityIndicator;

-(void)toolBarPickerWithSelector:(SEL)selector Target:(UIViewController *)target;
@end
