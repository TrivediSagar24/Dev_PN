//
//  responseDataOC.m
//  PeopleNect
//
//  Created by Apple on 24/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "responseDataOC.h"

#pragma mark - responseDataOCForEmployer -

@implementation responseDataOC
-(responseDataOC *) initWithDictionary:(NSMutableDictionary *)dictionary{
    
    if(self == [super init]){
        self.employerId = [[dictionary  valueForKey:@"data"  ]  valueForKey:@"employerId"];
        
        self.employerName =[[dictionary valueForKey:@"data"] valueForKey:@"name"];
        self.employerSurname = [[dictionary valueForKey:@"data"] valueForKey:@"surname"];
        self.employerPhoneNumber = [[dictionary valueForKey:@"data"] valueForKey:@"phoneNo"];
        self.employerFullName = [[dictionary valueForKey:@"data"] valueForKey:@"employerName"];
        self.employerEmail = [[dictionary valueForKey:@"data"] valueForKey:@"email"];
        self.employerCountryCode = [[dictionary valueForKey:@"data"] valueForKey:@"country_code"];
        self.employerCompanyAddress = [[dictionary valueForKey:@"data"] valueForKey:@"companyaddress"];
        self.employerProfilePic = [[dictionary valueForKey:@"data"] valueForKey:@"profilePic"];
        self.employerCompanyName = [[dictionary valueForKey:@"data"] valueForKey:@"companyName"];
        self.employerZipCode = [[dictionary valueForKey:@"data"] valueForKey:@"zip"];
        self.employerNumber = [[dictionary valueForKey:@"data"] valueForKey:@"number"];
        self.employerComplement = [[dictionary valueForKey:@"data"] valueForKey:@"complement"];
        
        _employerLocationLat = [[dictionary valueForKey:@"data"] valueForKey:@"lat"];
        _employerLocationLong = [[dictionary valueForKey:@"data"] valueForKey:@"lng"];
    }
    
    return self;
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.employerId = [decoder decodeObjectForKey:@"employerId"];
        
        self.employerName =[decoder decodeObjectForKey:@"name"];
        self.employerSurname = [decoder decodeObjectForKey:@"surname"];
        self.employerPhoneNumber = [decoder decodeObjectForKey:@"phoneNo"];
        self.employerFullName = [decoder decodeObjectForKey:@"employerName"];
        self.employerEmail = [decoder decodeObjectForKey:@"email"];
        self.employerCountryCode = [decoder decodeObjectForKey:@"country_code"];
        self.employerCompanyAddress = [decoder decodeObjectForKey:@"companyaddress"];
        self.employerProfilePic = [decoder decodeObjectForKey:@"profilePic"];
        self.employerCompanyName = [decoder decodeObjectForKey:@"companyName"];
        self.employerZipCode = [decoder decodeObjectForKey:@"zip"];
        self.employerNumber = [decoder decodeObjectForKey:@"number"];
        self.employerComplement = [decoder decodeObjectForKey:@"complement"];
        _employerLocationLat = [decoder decodeObjectForKey:@"lat"];
        _employerLocationLong = [decoder decodeObjectForKey:@"lng"];
    }
    return self;
}
/*------ Encode All Properties ------*/

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.employerId forKey:@"employerId"];
    [coder encodeObject:self.employerName forKey:@"name"];
    [coder encodeObject:self.employerPhoneNumber forKey:@"phoneNo"];
    [coder encodeObject:self.employerSurname forKey:@"surname"];
    [coder encodeObject:self.employerFullName forKey:@"employerName"];
    [coder encodeObject:self.employerCompanyName forKey:@"companyName"];
    [coder encodeObject:self.employerEmail forKey:@"email"];
    [coder encodeObject:self.employerCountryCode forKey:@"country_code"];
    [coder encodeObject:self.employerCompanyAddress forKey:@"companyaddress"];
    [coder encodeObject:self.employerProfilePic forKey:@"profilePic"];
    [coder encodeObject:self.employerZipCode forKey:@"zip"];
    [coder encodeObject:self.employerNumber forKey:@"number"];
    [coder encodeObject:self.employerComplement forKey:@"complement"];
[coder encodeObject:self.employerLocationLat forKey:@"lat"];
[coder encodeObject:self.employerLocationLong forKey:@"lng"];
}

@end



#pragma mark - responseUpdateEmployerDetails -
@implementation responseUpdateEmployerDetails
-(responseUpdateEmployerDetails *)initWithDictionary:(NSMutableDictionary *)dictionary{

    if(self == [super init]){
    
        self.employerCompanyName = [[dictionary valueForKey:@"data"] valueForKey:@"companyName"];
        self.employerCompanyAddress = [[dictionary valueForKey:@"data"] valueForKey:@"companyaddress"];
        self.employerProfilePic = [[dictionary valueForKey:@"data"] valueForKey:@"profilePic"];
        
    }
    return self;
    
}
@end


#pragma mark - jobPostingPriceBalance -
@implementation jobPostingPriceBalance

-(jobPostingPriceBalance *)initWithDictionary:(NSMutableDictionary *)dictionary{
    if (self = [super init]) {
        
        _jobPostingPrice = [[dictionary valueForKey:@"data"]valueForKey:@"jobPostingPrice"];
        _jobInvitationPrice =[[dictionary valueForKey:@"data"]valueForKey:@"jobInvitationPrice"];
        _balance = [[dictionary valueForKey:@"data"]valueForKey:@"balance"];
        _jobInvitationFavouritePrice = [[dictionary valueForKey:@"data"]valueForKey:@"jobInvitationFavouritePrice"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_jobPostingPrice forKey:@"jobPostingPrice"];
    [coder encodeObject:_jobInvitationPrice forKey:@"jobInvitationPrice"];
    
    [coder encodeObject:_balance forKey:@"balance"];


}


- (id)initWithCoder:(NSCoder *)decoder
    {
        if (self = [super init])
        {
            _jobPostingPrice = [decoder decodeObjectForKey:@"jobPostingPrice"];
            _jobInvitationPrice = [decoder decodeObjectForKey:@"jobInvitationPrice"];
            _balance = [decoder decodeObjectForKey:@"balance"];

        }
        return self;
    }

@end


#pragma mark - reponseGmailFacebookLogin -
@implementation reponseGmailFacebookLogin

-(reponseGmailFacebookLogin*) initWithDictionary:(NSMutableDictionary *)dictionary{
    
    _Employee_Response = [[NSMutableDictionary alloc]init];
    
    if(self = [super init])
    {
        _Employee_Response = dictionary;
        
        _Employee_category_id  = [[dictionary valueForKey:@"data"] valueForKey:@"category_id"];
        
       _Employee_category_name= [[dictionary valueForKey:@"data"] valueForKey:@"category_name"];
        
        _Employee_country_code= [[dictionary valueForKey:@"data"] valueForKey:@"country_code"];
        
       _Employee_email= [[dictionary valueForKey:@"data"] valueForKey:@"email"];
        
       _Employee_exp_years= [[dictionary valueForKey:@"data"] valueForKey:@"exp_years"];
        
      _Employee_first_name= [[dictionary valueForKey:@"data"] valueForKey:@"first_name"];
        
        _Employee_hourly_compensation= [[dictionary valueForKey:@"data"] valueForKey:@"hourly_compensation"];
        
      _Employee_jobseeker_profile_pic= [[dictionary valueForKey:@"data"] valueForKey:@"jobseeker_profile_pic"];
        
      _Employee_last_name= [[dictionary valueForKey:@"data"] valueForKey:@"last_name"];
        
        _Employee_phone= [[dictionary valueForKey:@"data"] valueForKey:@"phone"];
        
       _Employee_profile_description= [[dictionary valueForKey:@"data"] valueForKey:@"profile_description"];
        
       _Employee_streetName= [[dictionary valueForKey:@"data"] valueForKey:@"streetName"];
        
        _Employee_sub_category_id= [[dictionary valueForKey:@"data"] valueForKey:@"sub_category_id"];
        
       _Employee_sub_category_name= [[dictionary valueForKey:@"data"] valueForKey:@"sub_category_name"];
        
        _Employee_UserId= [[dictionary valueForKey:@"data"] valueForKey:@"userId"];
    }
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_Employee_category_id forKey:@"category_id"];
    
    [coder encodeObject:_Employee_category_name forKey:@"category_name"];
    
    [coder encodeObject:_Employee_country_code forKey:@"country_code"];

    [coder encodeObject:_Employee_email forKey:@"email"];
    
    [coder encodeObject:_Employee_exp_years forKey:@"exp_years"];

    [coder encodeObject:_Employee_first_name forKey:@"first_name"];

    [coder encodeObject:_Employee_hourly_compensation forKey:@"hourly_compensation"];
   
    [coder encodeObject:_Employee_jobseeker_profile_pic forKey:@"jobseeker_profile_pic"];
    
    [coder encodeObject:_Employee_last_name forKey:@"last_name"];

    [coder encodeObject:_Employee_phone forKey:@"phone"];

    [coder encodeObject:_Employee_profile_description forKey:@"profile_description"];

    [coder encodeObject:_Employee_streetName forKey:@"streetName"];

    [coder encodeObject:_Employee_sub_category_id forKey:@"sub_category_id"];

    [coder encodeObject:_Employee_sub_category_name forKey:@"sub_category_name"];

    [coder encodeObject:_Employee_UserId forKey:@"userId"];
    
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        _Employee_category_id = [decoder decodeObjectForKey:@"category_id"];
        _Employee_category_name = [decoder decodeObjectForKey:@"category_name"];
        _Employee_country_code = [decoder decodeObjectForKey:@"country_code"];
        _Employee_email = [decoder decodeObjectForKey:@"email"];
        _Employee_exp_years = [decoder decodeObjectForKey:@"exp_years"];
        _Employee_first_name = [decoder decodeObjectForKey:@"first_name"];
        _Employee_hourly_compensation = [decoder decodeObjectForKey:@"hourly_compensation"];
        _Employee_jobseeker_profile_pic = [decoder decodeObjectForKey:@"jobseeker_profile_pic"];
        _Employee_last_name = [decoder decodeObjectForKey:@"last_name"];
        _Employee_phone = [decoder decodeObjectForKey:@"phone"];
        _Employee_profile_description = [decoder decodeObjectForKey:@"profile_description"];
        _Employee_streetName = [decoder decodeObjectForKey:@"streetName"];
        _Employee_sub_category_id = [decoder decodeObjectForKey:@"sub_category_id"];
        _Employee_sub_category_name = [decoder decodeObjectForKey:@"sub_category_name"];
        _Employee_UserId = [decoder decodeObjectForKey:@"userId"];
    }
    return self;
}



@end

#pragma mark - responseEmployeeUserDetail -

@implementation responseEmployeeUserDetail

-(responseEmployeeUserDetail*) initWithDictionary:(NSMutableDictionary *)dictionary
{
     _Employee_Response = [[NSMutableDictionary alloc]init];
    if(self = [super init])
    {
        _Employee_Response = dictionary;
       _Employee_availability = [[dictionary valueForKey:@"data"] valueForKey:@"availability"];
        
        _Employee_category_id  = [[dictionary valueForKey:@"data"] valueForKey:@"category_id"];
        
        _Employee_category_name= [[dictionary valueForKey:@"data"] valueForKey:@"category_name"];
        
        _Employee_country_code= [[dictionary valueForKey:@"data"] valueForKey:@"country_code"];
        
        _Employee_email= [[dictionary valueForKey:@"data"] valueForKey:@"email"];
        
        _Employee_exp_years= [[dictionary valueForKey:@"data"] valueForKey:@"exp_years"];
        
        _Employee_first_name= [[dictionary valueForKey:@"data"] valueForKey:@"first_name"];
        
        _Employee_hourly_compensation= [[dictionary valueForKey:@"data"] valueForKey:@"hourly_compensation"];
        
        _Employee_jobseeker_profile_pic= [[dictionary valueForKey:@"data"] valueForKey:@"jobseeker_profile_pic"];
        
        _Employee_last_name= [[dictionary valueForKey:@"data"] valueForKey:@"last_name"];
        
        _Employee_phone= [[dictionary valueForKey:@"data"] valueForKey:@"phone"];
        
        _Employee_profile_description= [[dictionary valueForKey:@"data"] valueForKey:@"profile_description"];
        
        _Employee_streetName= [[dictionary valueForKey:@"data"] valueForKey:@"streetName"];
        
        _Employee_sub_category_id= [[dictionary valueForKey:@"data"] valueForKey:@"sub_category_id"];
        
        _Employee_sub_category_name= [[dictionary valueForKey:@"data"] valueForKey:@"sub_category_name"];
        
        
        _Employee_number= [[dictionary valueForKey:@"data"] valueForKey:@"number"];
        
         _Employee_zipcode= [[dictionary valueForKey:@"data"] valueForKey:@"zipcode"];
    }
    
    return self;
}
-(void) encodeWithCoder:(NSCoder *)coder{
    
    [coder encodeObject:_Employee_availability forKey:@"availability"];
    [coder encodeObject:_Employee_category_id  forKey:@"category_id"];
    [coder encodeObject:_Employee_category_name  forKey:@"category_name"];
    [coder encodeObject:_Employee_country_code  forKey:@"country_code"];
    [coder encodeObject:_Employee_email  forKey:@"email"];
    [coder encodeObject:_Employee_exp_years  forKey:@"exp_years"];
    [coder encodeObject:_Employee_first_name  forKey:@"first_name"];
    [coder encodeObject:_Employee_hourly_compensation  forKey:@"hourly_compensation"];
    [coder encodeObject:_Employee_jobseeker_profile_pic  forKey:@"jobseeker_profile_pic"];
    [coder encodeObject:_Employee_last_name  forKey:@"last_name"];
    [coder encodeObject:_Employee_phone  forKey:@"phone"];
    [coder encodeObject:_Employee_profile_description  forKey:@"profile_description"];
    [coder encodeObject:_Employee_streetName  forKey:@"streetName"];
    [coder encodeObject:_Employee_sub_category_id  forKey:@"sub_category_id"];
    [coder encodeObject:_Employee_sub_category_name  forKey:@"sub_category_name"];
    [coder encodeObject:_Employee_number  forKey:@"number"];
    [coder encodeObject:_Employee_zipcode  forKey:@"zipcode"];
}


-(id)initWithCoder : (NSCoder *)decoder {
    
    if(self == [super init]){
        _Employee_availability  = [decoder decodeObjectForKey:@"availability"];
        _Employee_category_id = [decoder decodeObjectForKey:@"category_id"];
        _Employee_category_name = [decoder decodeObjectForKey:@"category_name"];
        _Employee_country_code = [decoder decodeObjectForKey:@"country_code"];
        _Employee_email = [decoder decodeObjectForKey:@"email"];
        _Employee_exp_years = [decoder decodeObjectForKey:@"exp_years"];
        _Employee_first_name = [decoder decodeObjectForKey:@"first_name"];
        _Employee_hourly_compensation = [decoder decodeObjectForKey:@"hourly_compensation"];
         _Employee_jobseeker_profile_pic = [decoder decodeObjectForKey:@"jobseeker_profile_pic"];
        _Employee_last_name = [decoder decodeObjectForKey:@"last_name"];
        _Employee_phone = [decoder decodeObjectForKey:@"phone"];
        _Employee_profile_description = [decoder decodeObjectForKey:@"profile_description"];
        _Employee_streetName = [decoder decodeObjectForKey:@"streetName"];
        _Employee_sub_category_id = [decoder decodeObjectForKey:@"sub_category_id"];
        _Employee_sub_category_name = [decoder decodeObjectForKey:@"sub_category_name"];
        _Employee_number = [decoder decodeObjectForKey:@"number"];
        _Employee_zipcode = [decoder decodeObjectForKey:@"zipcode"];
    }
    return self;
}

@end

#pragma mark - CountryCode -

@implementation CountryCode

-(CountryCode *)initWithDictionary:(NSMutableDictionary  *)dictionary
{
    if (self = [super init])
    {
        self.countryCode = [[NSMutableArray alloc] init];
        self.countryId = [[NSMutableArray alloc] init];
        self.countryCode = [[dictionary valueForKey:@"data" ]valueForKey:@"countryCode"];
        self.countryId = [[dictionary  valueForKey:@"data"] valueForKey:@"countyId"];
    }
    return self;
}


-(void) encodeWithCoder:(NSCoder *)coder{
    
    [coder encodeObject:self.countryId forKey:@"countryId"];
    [coder encodeObject:self.countryCode  forKey:@"countryCode"];
    
}


-(id)initWithCoder : (NSCoder *)decoder {
    
    if(self == [super init]){
        
        self.countryCode  = [decoder decodeObjectForKey:@"countryCode"];
        self.countryId = [decoder decodeObjectForKey:@"countryId"];
        
    }
    
    return self;
}
@end

#pragma mark - EmployeeAreWiseJob -

@implementation EmployeeAreWiseJob

-(EmployeeAreWiseJob*) initWithDictionary:(NSMutableDictionary *)dictionary
{
    if (self = [super init])
    {
       _areaWiseJob =  [[dictionary valueForKey:@"data"]valueForKey:@"allJobs"];
        
        _areaLatitude = [_areaWiseJob valueForKey:@"latitude"];
        
        _areaLongitude = [_areaWiseJob valueForKey:@"longitude"];
    }
    return self;
}
@end
#pragma mark - EmployeeAllJob -

@implementation EmployeeAllJob

-(EmployeeAllJob*) initWithDictionary:(NSMutableDictionary *)dictionary
{
    if (self = [super init])
    {
        _AllJob =  [[dictionary valueForKey:@"data"]valueForKey:@"allJobs"];
        
        _allLatitude = [_AllJob valueForKey:@"latitude"];
        _allLongitude = [_AllJob valueForKey:@"longitude"];
    }
    return self;
}


@end

#pragma mark - EmployeeCategory -

@implementation EmployeeCategory

-(EmployeeCategory*) initWithDictionary:(NSMutableDictionary *)dictionary
{
    _categoryList = [[NSMutableDictionary alloc]init];
    if (self = [super init])
    {
        [_categoryList setObject: [[dictionary objectForKey:@"categoryList"]valueForKey:@"categoryName"] forKey:@"categoryName"];
        
         [_categoryList setObject: [[dictionary objectForKey:@"categoryList"]valueForKey:@"categoryId"] forKey:@"categoryId"];
       
    }
    return self;
}


@end

#pragma mark - responseCategoryList -

@implementation responseCategoryList

-(responseCategoryList *) initWithDictionary :(NSMutableDictionary *)dictionary{
    
    if(self ==[super init]){
        self.categoryId = [[NSMutableArray alloc] init];
        self.categoryName = [[NSMutableArray alloc] init];
        
        self.categoryName = [[dictionary valueForKey:@"categoryList"] valueForKey:@"categoryName"];
        self.categoryId =[[dictionary valueForKey:@"categoryList"] valueForKey:@"categoryId"];
    }
    
    return  self;
    
}


- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.categoryName forKey:@"categoryName"];
    [coder encodeObject:self.categoryId forKey:@"categoryId"];
    
}


- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.categoryName = [decoder decodeObjectForKey:@"categoryName"];
        self.categoryId  = [decoder decodeObjectForKey:@"categoryId"];
    }
    return self;
}

@end

#pragma mark - responseEmployeesList -

@implementation responseEmployeesList

-(responseEmployeesList *)initWithDictionary:(NSMutableDictionary *)dictionary{
    
    self.employeeAvailabilityStatus = [[NSMutableArray alloc] init];
    self.employeeCategoryId = [[NSMutableArray alloc] init];
    self.employeeCategoryName = [[NSMutableArray alloc] init];
    self.employeeDescription = [[NSMutableArray alloc] init];
    self.employeeDistance = [[NSMutableArray alloc] init];
    self.employeeId = [[NSMutableArray alloc] init];
    self.employeeExpYears = [[NSMutableArray alloc] init];
    self.employeeImage = [[NSMutableArray alloc] init];
    self.employeeLatitude= [[NSMutableArray alloc] init];
    self.employeeLongitude = [[NSMutableArray alloc] init];
    self.employeeName = [[NSMutableArray alloc] init];
    self.employeeRate = [[NSMutableArray alloc] init];
    self.employeeRating = [[NSMutableArray alloc] init];
    self.employeeSubcategoryId = [[NSMutableArray alloc] init];
    self.employeeSubactegoryName = [[NSMutableArray alloc] init];
    if(self == [super init]){
    /*---Allocating and initialising the arrays----------*/
        self.employeeAvailabilityStatus = [[dictionary valueForKey:@"data"] valueForKey:@"availabilityStatus"];
        self.employeeCategoryId =[[dictionary valueForKey:@"data"] valueForKey:@"categoryId"];
        self.employeeCategoryName = [[dictionary valueForKey:@"data"] valueForKey:@"categoryName"];
        self.employeeDescription = [[dictionary valueForKey:@"data"] valueForKey:@"description"];
        self.employeeDistance = [[dictionary valueForKey:@"data"] valueForKey:@"distance"];
        self.employeeId = [[dictionary valueForKey:@"data"] valueForKey:@"employeeId"];
        self.employeeExpYears =[[dictionary valueForKey:@"data"] valueForKey:@"exp_years"];
        self.employeeImage = [[dictionary valueForKey:@"data"] valueForKey:@"image_url"];
        self.employeeLatitude=[[dictionary valueForKey:@"data"] valueForKey:@"lat"];
        self.employeeLongitude = [[dictionary valueForKey:@"data"] valueForKey:@"lng"];
        self.employeeName = [[dictionary valueForKey:@"data"] valueForKey:@"name"];
        self.employeeRate = [[dictionary valueForKey:@"data"] valueForKey:@"ratePerHour"];
        self.employeeRating = [[dictionary valueForKey:@"data"]valueForKey:@"rating"];
        self.employeeSubcategoryId = [[dictionary valueForKey:@"data"] valueForKey:@"subCategoryId"];
        self.employeeSubactegoryName = [[dictionary valueForKey:@"data"] valueForKey:@"subCategoryName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    
    [coder encodeObject:self.employeeAvailabilityStatus forKey:@"availabilityStatus"];
    
    [coder encodeObject:self.employeeCategoryId forKey:@"categoryId"];
    
    [coder encodeObject:self.employeeCategoryName forKey:@"categoryName"];

    [coder encodeObject:self.employeeDescription forKey:@"description"];
   
    [coder encodeObject:self.employeeDistance forKey:@"distance"];
    
    [coder encodeObject:self.employeeId forKey:@"employeeId"];

    
    [coder encodeObject:self.employeeExpYears forKey:@"exp_years"];
    
    [coder encodeObject:self.employeeImage forKey:@"image_url"];

    [coder encodeObject:self.employeeLatitude forKey:@"lat"];
    
    [coder encodeObject:self.employeeLongitude forKey:@"lng"];
   
    [coder encodeObject:self.employeeName forKey:@"name"];

    [coder encodeObject:self.employeeRate forKey:@"ratePerHour"];

    [coder encodeObject:self.employeeRating forKey:@"rating"];
    
    [coder encodeObject:self.employeeSubcategoryId forKey:@"subCategoryId"];
    [coder encodeObject:self.employeeSubactegoryName forKey:@"subCategoryName"];

}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]){
        
        self.employeeAvailabilityStatus = [decoder decodeObjectForKey:@"availabilityStatus"];

        self.employeeCategoryId = [decoder decodeObjectForKey:@"categoryId"];

        self.employeeCategoryName = [decoder decodeObjectForKey:@"categoryName"];

        self.employeeDescription = [decoder decodeObjectForKey:@"description"];
        
        self.employeeDistance = [decoder decodeObjectForKey:@"distance"];
       
        self.employeeId = [decoder decodeObjectForKey:@"employeeId"];

        self.employeeExpYears = [decoder decodeObjectForKey:@"exp_years"];

        self.employeeImage = [decoder decodeObjectForKey:@"image_url"];

        self.employeeLatitude = [decoder decodeObjectForKey:@"lat"];

        self.employeeLongitude = [decoder decodeObjectForKey:@"lng"];
        
    self.employeeName = [decoder decodeObjectForKey:@"name"];

    self.employeeRate = [decoder decodeObjectForKey:@"ratePerHour"];
        
        self.employeeRating = [decoder decodeObjectForKey:@"rating"];

        self.employeeSubcategoryId = [decoder decodeObjectForKey:@"subCategoryId"];
        self.employeeSubactegoryName = [decoder decodeObjectForKey:@"subCategoryName"];

    }
    return self;
}


@end

#pragma mark - responseRegiserEmployee -

@implementation responseRegiserEmployee

-(responseRegiserEmployee*) initWithDictionary:(NSMutableDictionary *)dictionary{
    
    _Employee_Response = [[NSMutableDictionary alloc]init];
    
    if(self = [super init])
    {
        _Employee_Response = dictionary;
        _Employee_country_code= [[dictionary valueForKey:@"data"] valueForKey:@"country_code"];
        _Employee_email= [[dictionary valueForKey:@"data"] valueForKey:@"email"];
        _Employee_exp_years= [[dictionary valueForKey:@"data"] valueForKey:@"exp_years"];
        _Employee_first_name= [[dictionary valueForKey:@"data"] valueForKey:@"first_name"];
        _Employee_hourly_compensation= [[dictionary valueForKey:@"data"] valueForKey:@"hourly_compensation"];
        _Employee_jobseeker_profile_pic= [[dictionary valueForKey:@"data"] valueForKey:@"jobseeker_profile_pic"];
        _Employee_last_name= [[dictionary valueForKey:@"data"] valueForKey:@"last_name"];
        _Employee_phone= [[dictionary valueForKey:@"data"] valueForKey:@"phone"];
        
        _Employee_category_id = [[dictionary valueForKey:@"data"] valueForKey:@"category_id"];
        
        _Employee_profile_description= [[dictionary valueForKey:@"data"] valueForKey:@"profile_description"];
        _Employee_streetName= [[dictionary valueForKey:@"data"] valueForKey:@"streetName"];
        
        _Employee_UserId= [[dictionary valueForKey:@"data"] valueForKey:@"userId"];
        
        _Employee_zipcode = [[dictionary valueForKey:@"data"] valueForKey:@"zipcode"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
     [coder encodeObject:self.Employee_category_id forKey:@"category_id"];
     [coder encodeObject:self.Employee_zipcode forKey:@"zipcode"];
    [coder encodeObject:self.Employee_UserId forKey:@"userId"];
    [coder encodeObject:self.Employee_jobseeker_profile_pic forKey:@"jobseeker_profile_pic"];
    [coder encodeObject:self.Employee_Response forKey:@"Employee_Response"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.Employee_category_id = [decoder decodeObjectForKey:@"category_id"];
         self.Employee_zipcode = [decoder decodeObjectForKey:@"zipcode"];
    self.Employee_UserId = [decoder decodeObjectForKey:@"userId"];
    self.Employee_jobseeker_profile_pic = [decoder decodeObjectForKey:@"jobseeker_profile_pic"];
    self.Employee_Response = [decoder decodeObjectForKey:@"Employee_Response"];

    }
    return self;
}

@end

#pragma mark - FinalRegisteredEmployee -

@implementation FinalRegisteredEmployee

-(FinalRegisteredEmployee*) initWithDictionary:(NSMutableDictionary *)dictionary{
    
    
    if(self = [super init])
    {
     
        _Employee_exp_years= [[dictionary valueForKey:@"data"] valueForKey:@"exp_years"];
        _Employee_hourly_compensation= [[dictionary valueForKey:@"data"] valueForKey:@"hourly_compensation"];
        _Employee_jobseeker_profile_pic= [[dictionary valueForKey:@"data"] valueForKey:@"jobseeker_profile_pic"];
        
        _Employee_category_id = [[dictionary valueForKey:@"data"] valueForKey:@"category_id"];
        
        _Employee_profile_description= [[dictionary valueForKey:@"data"] valueForKey:@"profile_description"];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.Employee_category_id forKey:@"category_id"];
    [coder encodeObject:self.Employee_jobseeker_profile_pic forKey:@"jobseeker_profile_pic"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.Employee_category_id = [decoder decodeObjectForKey:@"category_id"];
        self.Employee_jobseeker_profile_pic = [decoder decodeObjectForKey:@"jobseeker_profile_pic"];
    }
    return self;
}

@end

#pragma mark - EmployerDetails -

@implementation EmployerDetails

-(EmployerDetails *)initWithDictionary:(NSMutableDictionary *)dictionary
{
    if(self = [super init])
    {
        _ZipCode= [[dictionary valueForKey:@"data"] valueForKey:@"zip"];
        _StateID = [[dictionary valueForKey:@"data"] valueForKey:@"state"];
        _CityID = [[dictionary valueForKey:@"data"] valueForKey:@"city"];
        _StateName = [[dictionary valueForKey:@"data"] valueForKey:@"statename"];
        _cityName = [[dictionary valueForKey:@"data"] valueForKey:@"cityname"];
        _address1 = [[dictionary valueForKey:@"data"] valueForKey:@"address1"];
        _address2 = [[dictionary valueForKey:@"data"] valueForKey:@"address2"];
        _streetName = [[dictionary valueForKey:@"data"] valueForKey:@"street_name"];
        _countryCode = [[dictionary valueForKey:@"data"] valueForKey:@"country_code"];
        _countryID = [[dictionary valueForKey:@"data"]valueForKey:@"country"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_ZipCode forKey:@"zip"];
    [coder encodeObject:_StateID forKey:@"state"];
    [coder encodeObject:_CityID forKey:@"city"];
    [coder encodeObject:_StateName forKey:@"statename"];
    [coder encodeObject:_cityName forKey:@"cityname"];
    [coder encodeObject:_address1 forKey:@"address1"];
    [coder encodeObject:_address2 forKey:@"address2"];
    [coder encodeObject:_streetName forKey:@"street_name"];
    [coder encodeObject:_countryCode forKey:@"country_code"];
    [coder encodeObject:_countryID forKey:@"country"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        _ZipCode = [decoder decodeObjectForKey:@"zip"];
        _StateID = [decoder decodeObjectForKey:@"state"];
        _CityID = [decoder decodeObjectForKey:@"city"];
        _StateName = [decoder decodeObjectForKey:@"statename"];    _cityName = [decoder decodeObjectForKey:@"cityname"];
        _address1 = [decoder decodeObjectForKey:@"address1"];
         _address2 = [decoder decodeObjectForKey:@"address2"];
    _streetName = [decoder decodeObjectForKey:@"street_name"];
    _countryCode = [decoder decodeObjectForKey:@"country_code"];
    _countryID = [decoder decodeObjectForKey:@"country"];
    }
    return self;
}
@end
