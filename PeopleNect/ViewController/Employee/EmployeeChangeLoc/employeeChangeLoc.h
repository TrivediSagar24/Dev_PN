//
//  employeeChangeLoc.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PN_TextFieldGlobalMethod.h"
#import "employeeLocationCell.h"
@import GoogleMaps;
#import <GoogleMaps/GoogleMaps.h>
@import GooglePlaces;
#import <CoreData/CoreData.h>
#import "MVPlaceSearchTextField.h"
#import "employeeJobNotification.h"
#import "GlobalMethods.h"

@interface employeeChangeLoc : UIViewController
<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,PlaceSearchTextFieldDelegate>


@property (strong, nonatomic) IBOutlet MVPlaceSearchTextField *tfZipStreetName;

@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UILabel *lastSearchLbl;
@property (strong, nonatomic) IBOutlet UITableView *lastSearchTableView;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong) NSMutableArray *changeLocationData;

- (IBAction)closeBtnClicked:(id)sender;

@end
