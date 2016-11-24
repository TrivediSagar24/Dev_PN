//
//  MenuCtr.h
//  PeopleNect
//
//  Created by Apple on 23/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "JSCustomBadge.h"
#import "ViewController.h"
#import "MainCollectionVeiwCell.h"
#import "employerMainTVCell.h"
#import "PN_Constants.h"
#import "GlobalMethods.h"
#import "UIImageView+WebCache.h"
#import "SlideNavigationController.h"
#import "employerSettings.h"
#import "employerTransaction.h"
#import "employerInviteForJobVC.h"
#import "responseDataOC.h"
#import "MenuCell.h"
#import "employeeChat.h"
#import "employerTransaction.h"
#import "repostJobEmployerCtr.h"
#import <Google-Maps-iOS-Utils/GMUMarkerClustering.h>
#import <GoogleMaps/GoogleMaps.h>
@import GoogleMaps;

@interface MenuCtr : UIViewController
<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate,GMSMapViewDelegate,GMUClusterManagerDelegate>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfMapView;
@property (strong, nonatomic) IBOutlet UIButton *btnAdd;
@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightOfMiddleView;
@property (strong, nonatomic) IBOutlet UILabel *totalRecordEmployee;
@property (strong, nonatomic) IBOutlet GMSMapView *obj_MapView;
@property (strong, nonatomic) IBOutlet UIScrollView *objScrollView;
@property (strong, nonatomic) IBOutlet UITableView *obj_MainTableView;
@property (strong, nonatomic) IBOutlet UICollectionView *obj_MainCollectionView;
@property (strong,nonatomic)    CLLocationManager *locationManager;
@property(strong,nonatomic) UIButton *transaction;
@property(strong,nonatomic)UIButton *chatSelected;
@property(strong,nonatomic)  JSCustomBadge *chatBadge;



- (IBAction)changeLocationClicked:(id)sender;
- (IBAction)ButtonAddClicked:(id)sender;
@end
