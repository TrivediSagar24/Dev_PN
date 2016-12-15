//
//  privacyPolicy.m
//  PeopleNect
//
//  Created by Apple on 15/12/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "privacyPolicy.h"

@interface privacyPolicy ()

@end

@implementation privacyPolicy

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

}

-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
