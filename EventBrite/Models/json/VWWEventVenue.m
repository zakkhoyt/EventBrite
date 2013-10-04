//
//  VWWEventVenue.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventVenue.h"

@implementation VWWEventVenue
-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (dictionary == nil) {
        return nil;
    }
    
    self = [super init];
    if(self){
        _ID = [dictionary numberForKey:@"id"];
        _name = [dictionary stringForKey:@"name"];
        _address = [dictionary stringForKey:@"address"];
        _address2 = [dictionary stringForKey:@"address_2"];
        _city = [dictionary stringForKey:@"city"];
        _region = [dictionary stringForKey:@"region"];
        _postalCode = [dictionary stringForKey:@"postal_code"];
        _country = [dictionary stringForKey:@"country"];
        _countryCode = [dictionary stringForKey:@"country_code"];
        _longitude = [dictionary numberForKey:@"longitude"];
        _latitude = [dictionary numberForKey:@"latitude"];
        _latLong = [dictionary stringForKey:@"Lat-Long"];
    }
    return self;
}

+(VWWEventVenue*)eventVenueWithDictionary:(NSDictionary *)dictionary{
    return [[VWWEventVenue alloc]initWithDictionary:dictionary];
}

@end
