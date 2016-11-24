//
//  responseDataOC.h
//  PeopleNect
//
//  Created by Apple on 24/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface responseDataOC : NSObject
@property (nonatomic,strong) NSString *employerId;
@property (nonatomic,strong) NSString *employerCompanyName;
@property (nonatomic,strong) NSString *employerFullName;
@property (nonatomic,strong) NSString *employerName;
@property (nonatomic,strong) NSString *employerCountryCode;
@property (nonatomic,strong) NSString *employerEmail;
@property (nonatomic,strong) NSString  *employerPhoneNumber;
@property (nonatomic,strong) NSString  *employerSurname;
@property (nonatomic,strong) NSString  *employerS;
-(instancetype) initWithDictionary:(NSMutableDictionary *)dictionary;
@end

@interface responseUpdateEmployerDetails: NSObject
@property (nonatomic,strong) NSString *employerCompanyName;
@property (nonatomic,strong) NSString  *employerCompanyAddress;
@property (nonatomic,strong) NSString  *employerProfilePic;

-(responseUpdateEmployerDetails*) initWithDictionary:(NSMutableDictionary *)dictionary;
@end
