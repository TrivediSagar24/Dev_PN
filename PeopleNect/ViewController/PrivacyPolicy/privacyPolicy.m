//
//  privacyPolicy.m
//  PeopleNect
//
//  Created by  Narendra Pandey on 15/12/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "privacyPolicy.h"

@interface privacyPolicy ()

@end

@implementation privacyPolicy
#pragma mark - View LifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    gestureRecognizer.delegate = self;
    [self.privacyPolicyWebView addGestureRecognizer:gestureRecognizer];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.privacyPolicyWebView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
#pragma mark - dismissView -
-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - gesture Delegates -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
