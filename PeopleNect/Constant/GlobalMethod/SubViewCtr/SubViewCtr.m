//
//  SubViewCtr.m
//  PeopleNect
//
//  Created by Narendra Pandey on 01/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "SubViewCtr.h"
#import "PN_Constants.h"

@implementation SubViewCtr

+(instancetype)sharedInstance{

    static SubViewCtr *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken , ^{
        
    sharedInstance = [[SubViewCtr alloc] init];
        //Do any other initialization
        
    });
    return sharedInstance;
}


- (id)init {
    if (self = [super init]) {
      //  Do intialization here
        _obj_PickerView= [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44,[UIScreen mainScreen].bounds.size.width, 253)];
        
        _obj_ToolBar = [[UIToolbar alloc] initWithFrame: CGRectMake(0,0,
                                                                   [UIScreen mainScreen].bounds.size.width,45)];
        
        _obj_ToolBar.barStyle = UIBarStyleDefault;
        _obj_ToolBar.barTintColor = [UIColor whiteColor];

        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        _activityIndicator.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 200);
        
        [self addSubview: _activityIndicator];
        
        [_activityIndicator startAnimating];
        
        /*--Input view to textfield--*/
        [self addSubview: _obj_ToolBar];
        [self addSubview:_obj_PickerView];
        
        self.frame =  CGRectMake(0, 0, SYSTEM_SCREEN_SIZE.width, _obj_ToolBar.frame.size.height + _obj_PickerView.frame.size.height);

    }
    return self;
}

-(void)toolBarPickerWithSelector:(SEL)selector Target:(UIViewController *)target{
    /*---ToolBar in Picker----*/
    UIBarButtonItem *btnNext = [[UIBarButtonItem alloc] initWithTitle:@"NEXT" style:UIBarButtonItemStylePlain target:target action:selector];
    [btnNext setTintColor:[UIColor blackColor]];
    UIBarButtonItem *spaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [_obj_ToolBar setItems:[NSArray arrayWithObjects:spaceLeft,btnNext, nil] animated:YES];
}


@end
