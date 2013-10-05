//
//  VWWEventVenue.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventVenue.h"
#import "VWWEvent.h"


@implementation VWWEventVenue

@dynamic uuid;
@dynamic name;
@dynamic address;
@dynamic address2;
@dynamic city;
@dynamic region;
@dynamic postalCode;
@dynamic country;
@dynamic countryCode;
@dynamic longitude;
@dynamic latitude;
@dynamic latLong;
@dynamic event;
-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context{
    self.uuid = dictionary[@"id"];
    self.name = dictionary[@"name"];
    self.address = dictionary[@"address"];
    self.address2 = dictionary[@"address_2"];
    self.city = dictionary[@"city"];
    self.region = dictionary[@"region"];
    self.postalCode = dictionary[@"postal_code"];
    self.country = dictionary[@"country"];
    self.countryCode = dictionary[@"country_code"];
    self.longitude = dictionary[@"longitude"];
    self.latitude = dictionary[@"latitude"];
    self.latLong = dictionary[@"Lat-Long"];
    
}
-(NSString*)description{
    return [NSString stringWithFormat:
            @"id: %@"
            @"name: %@"
            @"address: %@"
            @"address_2: %@"
            @"city: %@"
            @"region: %@"
            @"postal_code: %@"
            @"country: %@"
            @"country_code: %@"
            @"longitude: %@"
            @"latitude: %@"
            @"Lat-Long: %@",
            self.uuid,
            self.name,
            self.address,
            self.address2,
            self.city,
            self.region,
            self.postalCode,
            self.country,
            self.countryCode,
            self.longitude,
            self.latitude,
            self.latLong];
}

@end
