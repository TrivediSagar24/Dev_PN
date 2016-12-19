//
//  responseDataOC.h
//  PeopleNect
//
//  Created by Apple on 24/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface responseUpdateEmployerDetails: NSObject
@property (nonatomic,strong) NSString *employerCompanyName;
@property (nonatomic,strong) NSString  *employerCompanyAddress;
@property (nonatomic,strong) NSString  *employerProfilePic;

-(responseUpdateEmployerDetails*) initWithDictionary:(NSMutableDictionary *)dictionary;
@end

@interface jobPostingPriceBalance : NSObject

@property (nonatomic,strong) NSString *jobPostingPrice;
@property (nonatomic,strong) NSString *jobInvitationPrice;
@property (nonatomic,strong) NSString *jobInvitationFavouritePrice;
@property (nonatomic,strong) NSString *balance;

-(jobPostingPriceBalance *) initWithDictionary:(NSMutableDictionary *)dictionary;

@end

@interface reponseGmailFacebookLogin : NSObject



@property (nonatomic,strong) NSString  *Employee_category_id;
@property (nonatomic,strong) NSString  *Employee_category_name;
@property (nonatomic,strong) NSString  *Employee_country_code;
@property (nonatomic,strong) NSString  *Employee_email;
@property (nonatomic,strong) NSString  *Employee_exp_years;
@property (nonatomic,strong) NSString  *Employee_first_name;
@property (nonatomic,strong) NSString  *Employee_hourly_compensation;
@property (nonatomic,strong) NSString  *Employee_jobseeker_profile_pic;
@property (nonatomic,strong) NSString  *Employee_last_name;
@property (nonatomic,strong) NSString  *Employee_phone;
@property (nonatomic,strong) NSString  *Employee_profile_description;
@property (nonatomic,strong) NSString  *Employee_streetName;
@property (nonatomic,strong) NSString  *Employee_sub_category_id;
@property (nonatomic,strong) NSString  *Employee_sub_category_name;
@property (nonatomic,strong) NSString  *Employee_UserId;

@property (nonatomic,strong) NSMutableDictionary  *Employee_Response;


-(reponseGmailFacebookLogin*) initWithDictionary:(NSMutableDictionary *)dictionary;

@end

@interface responseEmployeeUserDetail : NSObject

@property (nonatomic,strong) NSString  *Employee_availability;
@property (nonatomic,strong) NSString  *Employee_country_code;
@property (nonatomic,strong) NSString  *Employee_email;
@property (nonatomic,strong) NSString  *Employee_category_id;
@property (nonatomic,strong) NSString  *Employee_category_name;
@property (nonatomic,strong) NSString  *Employee_exp_years;
@property (nonatomic,strong) NSString  *Employee_first_name;
@property (nonatomic,strong) NSString  *Employee_hourly_compensation;
@property (nonatomic,strong) NSString  *Employee_jobseeker_profile_pic;
@property (nonatomic,strong) NSString  *Employee_last_name;
@property (nonatomic,strong) NSString  *Employee_phone;
@property (nonatomic,strong) NSString  *Employee_profile_description;
@property (nonatomic,strong) NSString  *Employee_streetName;
@property (nonatomic,strong) NSString  *Employee_sub_category_id;
@property (nonatomic,strong) NSString  *Employee_sub_category_name;
@property (nonatomic,strong) NSString  *Employee_number;
@property (nonatomic,strong) NSString  *Employee_zipcode;
@property (nonatomic,strong) NSMutableDictionary  *Employee_Response;


-(responseEmployeeUserDetail*) initWithDictionary:(NSMutableDictionary *)dictionary;

@end


@interface CountryCode : NSObject

@property (nonatomic,strong) NSMutableArray  *countryCode;
@property (nonatomic,strong) NSMutableArray *countryId;

-(CountryCode*) initWithDictionary:(NSMutableDictionary *)dictionary;

@end

@interface EmployeeAreWiseJob : NSObject

@property (nonatomic,strong) NSMutableArray  *areaWiseJob;
@property(nonatomic,strong) NSMutableArray *areaLatitude;
@property(nonatomic,strong)NSMutableArray *areaLongitude;
-(EmployeeAreWiseJob*) initWithDictionary:(NSMutableDictionary *)dictionary;

@end

@interface EmployeeAllJob : NSObject

@property (nonatomic,strong) NSMutableArray  *AllJob;
@property(nonatomic,strong) NSMutableArray *allLatitude;
@property(nonatomic,strong)NSMutableArray *allLongitude;


-(EmployeeAllJob*) initWithDictionary:(NSMutableDictionary *)dictionary;
@end

@interface EmployeeCategory : NSObject

@property (nonatomic,strong) NSMutableDictionary  *categoryList;

-(EmployeeCategory*) initWithDictionary:(NSMutableDictionary *)dictionary;
@end


@interface responseDataOC : NSObject
@property (nonatomic,strong) NSString *employerId;
@property (nonatomic,strong) NSString *employerCompanyName;
@property (nonatomic,strong) NSString *employerFullName;
@property (nonatomic,strong) NSString *employerName;
@property (nonatomic,strong) NSString *employerCountryCode;
@property (nonatomic,strong) NSString *employerEmail;
@property (nonatomic,strong) NSString  *employerPhoneNumber;
@property(nonatomic,strong) NSString  *employerNumber;
@property(nonatomic,strong) NSString  *employerComplement;
@property (nonatomic,strong) NSString  *employerCompanyAddress;
@property (nonatomic,strong) NSString  *employerProfilePic;
@property (nonatomic,strong)NSString *employerZipCode;
@property (nonatomic,strong) NSString  *employerSurname;
@property (nonatomic,strong) NSString  *employerS;
@property (nonatomic,strong) NSString  *employerLocationLat;
@property (nonatomic,strong) NSString  *employerLocationLong;


-(responseDataOC *) initWithDictionary:(NSMutableDictionary *)dictionary;

@end




@interface responseCategoryList : NSObject

@property(nonatomic,strong) NSMutableArray *categoryName;
@property(nonatomic,strong) NSMutableArray *categoryId;
-(responseCategoryList *) initWithDictionary :(NSMutableDictionary *)dictionary;
@end





@interface responseEmployeesList : NSObject

@property (nonatomic,strong) NSMutableArray *employeeAvailabilityStatus;
@property (nonatomic,strong) NSMutableArray  *employeeCategoryId;
@property (nonatomic,strong) NSMutableArray  *employeeCategoryName;
@property (nonatomic,strong) NSMutableArray *employeeDescription;
@property (nonatomic,strong) NSMutableArray  *employeeDistance;
@property (nonatomic,strong) NSMutableArray *employeeId;
@property (nonatomic,strong) NSMutableArray *employeeExpYears;
@property (nonatomic, strong)NSMutableArray  *employeeImage;
@property (nonatomic,strong) NSMutableArray  *employeeLatitude;
@property (nonatomic, strong)NSMutableArray *employeeLongitude;
@property (nonatomic,strong) NSMutableArray  *employeeName;
@property (nonatomic,strong) NSMutableArray *employeeRate;
@property (nonatomic,strong) NSMutableArray  *employeeRating;
@property (nonatomic,strong) NSMutableArray  *employeeSubcategoryId;
@property (nonatomic,strong) NSMutableArray  *employeeSubactegoryName;

-(responseEmployeesList *)initWithDictionary:(NSMutableArray *)Array;
@end


@interface responseRegiserEmployee : NSObject

@property (nonatomic,strong) NSString  *Employee_country_code;
@property (nonatomic,strong) NSString  *Employee_email;
@property (nonatomic,strong) NSString  *Employee_exp_years;
@property (nonatomic,strong) NSString  *Employee_first_name;
@property (nonatomic,strong) NSString  *Employee_hourly_compensation;
@property (nonatomic,strong) NSString  *Employee_jobseeker_profile_pic;
@property (nonatomic,strong) NSString  *Employee_last_name;
@property (nonatomic,strong) NSString  *Employee_number;
@property (nonatomic,strong) NSString  *Employee_phone;
@property (nonatomic,strong) NSString  *Employee_profile_description;
@property (nonatomic,strong) NSString  *Employee_streetName;
@property (nonatomic,strong) NSString  *Employee_zipcode;
@property (nonatomic,strong) NSString  *Employee_UserId;
@property (nonatomic,strong) NSMutableDictionary  *Employee_Response;
@property (nonatomic,strong) NSString  *Employee_category_id;


-(responseRegiserEmployee *)initWithDictionary:(NSMutableDictionary *)dictionary;
@end


@interface FinalRegisteredEmployee : NSObject

@property (nonatomic,strong) NSString  *Employee_category_id;
@property (nonatomic,strong) NSString  *Employee_category_name;
@property (nonatomic,strong) NSString  *Employee_exp_years;
@property (nonatomic,strong) NSString  *Employee_hourly_compensation;
@property (nonatomic,strong) NSString  *Employee_jobseeker_profile_pic;
@property (nonatomic,strong) NSString  *Employee_profile_description;
@property (nonatomic,strong) NSString  *Employee_sub_category_id;
@property (nonatomic,strong) NSString  *Employee_sub_category_name;

-(FinalRegisteredEmployee *)initWithDictionary:(NSMutableDictionary *)dictionary;
@end

@interface EmployerDetails : NSObject

@property (nonatomic,strong) NSString  *ZipCode;
@property (nonatomic,strong) NSString  *StateID;
@property (nonatomic,strong) NSString  *CityID;
@property (nonatomic,strong) NSString  *StateName;
@property (nonatomic,strong) NSString  *cityName;
@property (nonatomic,strong) NSString  *address1;
@property (nonatomic,strong) NSString  *address2;
@property (nonatomic,strong) NSString  *streetName;
@property (nonatomic,strong) NSString  *countryCode;
@property(nonatomic,strong) NSString *countryID;

-(EmployerDetails *)initWithDictionary:(NSMutableDictionary *)dictionary;
@end




