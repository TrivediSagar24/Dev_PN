//
//  responseDataOC.m
//  PeopleNect
//
//  Created by Apple on 24/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "responseDataOC.h"



@implementation responseDataOC
-(instancetype) initWithDictionary:(NSMutableDictionary *)dictionary{
    
    self = [super init];
    
    if(self){
        self.employerId = [[dictionary  valueForKey:@"data"  ]  valueForKey:@"employerId"];
      
         self.employerName =[[dictionary valueForKey:@"data"] valueForKey:@"name"];
         self.employerSurname = [[dictionary valueForKey:@"data"] valueForKey:@"surname"];
         self.employerPhoneNumber = [[dictionary valueForKey:@"data"] valueForKey:@"phoneNo"];
         self.employerFullName = [[dictionary valueForKey:@"data"] valueForKey:@"employerName"];
         self.employerEmail = [[dictionary valueForKey:@"data"] valueForKey:@"email"];
         self.employerCountryCode = [[dictionary valueForKey:@"data"] valueForKey:@"country_code"];
     
    
    }
    
    return self;
    
    }
@end

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