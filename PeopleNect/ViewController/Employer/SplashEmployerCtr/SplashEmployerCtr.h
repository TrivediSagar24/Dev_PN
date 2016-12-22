//
//  SplashEmployerCtr.h
//  PeopleNect
//
//  Created by Narendra Pandey on 10/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SplashEmployerCell.h"
#import "LCAnimatedPageControl.h"
#import "ViewController.h"


@interface SplashEmployerCtr : UIViewController

@property (strong, nonatomic) IBOutlet UICollectionView *objCollectionViewCtr;
@property (strong,nonatomic) LCAnimatedPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIButton *btnRegister;
@property (strong, nonatomic) IBOutlet UIView *pageIndicator;

- (IBAction)onClickRegister:(id)sender;
- (IBAction)onClickProfessional:(id)sender;
- (IBAction)onClickRegistered:(id)sender;

@end
