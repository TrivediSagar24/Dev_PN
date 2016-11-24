//
//  employeeChangeLoc.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/8/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeChangeLoc.h"

@interface employeeChangeLoc () {
    NSString *placeName,*address;
    CLLocationCoordinate2D Location;
    employeeJobNotification *obj_employeeJobNotification;
}
@end

@implementation employeeChangeLoc

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma mark - View LifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tfZipStreetName.placeSearchDelegate = self;
    _tfZipStreetName.delegate = self;
//    _tfZipStreetName.strApiKey = @"AIzaSyCDi2dklT-95tEHqYoE7Tklwzn3eJP-MtM";
    _tfZipStreetName.strApiKey = @"AIzaSyB9U-Ssv6A9Tt2keQtZyWMuadHoELYeGlk";
    _tfZipStreetName.superViewOfList = self.view;
    _tfZipStreetName.autoCompleteShouldHideOnSelection = YES;
    _tfZipStreetName.maximumNumberOfAutoCompleteRows = 5;
    
    obj_employeeJobNotification = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeJobNotification"];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ChangeLocation"];
    _changeLocationData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [_lastSearchTableView reloadData];
    
    [self _tfStreetNameBorderImage];
    
        //Optional Properties
    
        _tfZipStreetName.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
        _tfZipStreetName.autoCompleteBoldFontName = @"HelveticaNeue";
        _tfZipStreetName.autoCompleteTableCornerRadius=0.0;
        _tfZipStreetName.autoCompleteRowHeight=35;
        _tfZipStreetName.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
        _tfZipStreetName.autoCompleteFontSize=14;
        _tfZipStreetName.autoCompleteTableBorderWidth=1.0;
        _tfZipStreetName.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
        _tfZipStreetName.autoCompleteShouldHideOnSelection=YES;
        _tfZipStreetName.autoCompleteShouldHideClosingKeyboard=YES;
        _tfZipStreetName.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
        _tfZipStreetName.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_tfZipStreetName.frame.size.width)*0.5, _searchBtn.frame.origin.y+_searchBtn.frame.size.height, _tfZipStreetName.frame.size.width, 200.0);
}

#pragma mark - Place search Textfield Delegates
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict{
    [self.view endEditing:YES];
    placeName = responseDict.name;
    Location = responseDict.coordinate;
    address = responseDict.formattedAddress;
}

-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index{
    if(index%2==0){
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}


#pragma mark - TableView Datasource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _changeLocationData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    employeeLocationCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"employeeLocationCell" forIndexPath:indexPath];
    
    NSManagedObject *data = [_changeLocationData objectAtIndex:indexPath.row];
  
    [Cell.SearchLbl setText:[NSString stringWithFormat:@"%@", [data valueForKey:@"placeName"]]];
    
    [Cell.searchStreetLbl setText:[data valueForKey:@"address"]];
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSManagedObject *data = [_changeLocationData objectAtIndex:indexPath.row];
    CLLocationCoordinate2D selectedLocation = CLLocationCoordinate2DMake([[data valueForKey:@"latitude"]doubleValue], [[data valueForKey:@"longitude"]doubleValue]);
    kAppDel.changeCount = 1;
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",selectedLocation.latitude] forKey:@"changeLat"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",selectedLocation.longitude] forKey:@"changeLong"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[NSUserDefaults standardUserDefaults] setObject:@"changeLocation"   forKey:@"Location"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBActions -
- (IBAction)SearchClicked:(id)sender {
    
    if (_tfZipStreetName.text.length>0) {
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        NSManagedObject *changeLocationSetting = [NSEntityDescription insertNewObjectForEntityForName:@"ChangeLocation" inManagedObjectContext:context];
        
        [changeLocationSetting setValue:placeName forKey:@"placeName"];
        
        [changeLocationSetting setValue:address forKey:@"address"];
        
        [changeLocationSetting setValue:[NSString stringWithFormat:@"%f",Location.latitude] forKey:@"latitude"];
        
        [changeLocationSetting setValue:[NSString stringWithFormat:@"%f",Location.longitude] forKey:@"longitude"];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        [[NSUserDefaults standardUserDefaults] setObject:@"changeLocation"forKey:@"Location"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",Location.latitude] forKey:@"changeLat"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",Location.longitude] forKey:@"changeLong"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        kAppDel.changeCount = 1;

        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self presentViewController:[GlobalMethods AlertWithTitle:@"" Message:@"Please enter Location" AlertMessage:@"OK"]animated:YES completion:nil];
    }
}
- (IBAction)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextFieldDelegate -
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)_tfStreetNameBorderImage{
    
    /* Border
    UILabel *borderlabel = [[UILabel alloc]initWithFrame:CGRectMake(_tfZipStreetName.frame.origin.x, _tfZipStreetName.frame.origin.y+_tfZipStreetName.frame.size.height-1, _tfZipStreetName.frame.size.width, 1)];
    
    [self.view addSubview:borderlabel];
    
    borderlabel.backgroundColor = [UIColor grayColor];
     */
    
    UIView *paddingLeftImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tfZipStreetName.layer.frame.size.height, _tfZipStreetName.layer.frame.size.height)];
    
    UIButton * btn = [[UIButton alloc]init];
    
    btn.frame = CGRectMake(0, 0, _tfZipStreetName.layer.frame.size.height, _tfZipStreetName.layer.frame.size.height);
    
    [btn setImage:[UIImage imageNamed:@"search_icon_"] forState:UIControlStateNormal];
    
    [paddingLeftImage addSubview:btn];
    
    _tfZipStreetName.leftViewMode = UITextFieldViewModeAlways;
    
    _tfZipStreetName.leftView = paddingLeftImage;
}
@end
