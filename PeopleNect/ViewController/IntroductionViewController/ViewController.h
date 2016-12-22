//
//  ViewController.h
//  PeopleNect
//
//  Created by Narendra Pandey on 26/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "employerTransaction.h"
#import "employerSettings.h"
#import "closeJob.h"
@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UICollectionView *pageCollection;

@property (strong, nonatomic) IBOutlet UIView *pageIndicator;
@property (strong, nonatomic) IBOutlet UIButton *btnRegister;
@property (strong, nonatomic) IBOutlet UIButton *btnAlredy;
@property (strong, nonatomic) IBOutlet UIButton *btnProf;

- (IBAction)btnRegisterClick:(id)sender;
- (IBAction)btnAlreadyClick:(id)sender;
- (IBAction)btnProfessionalClick:(id)sender;

@end

