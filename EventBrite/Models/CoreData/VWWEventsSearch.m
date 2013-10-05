//
//  VWWEventsSearch.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/5/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventsSearch.h"
#import "VWWSearchResults.h"
#import "VWWGetEventSearchForm.h"

@implementation VWWEventsSearch

@dynamic address;
@dynamic city;
@dynamic country;
@dynamic keywords;
@dynamic postalCode;
@dynamic region;
@dynamic searchResults;

-(void)populateWithForm:(VWWGetEventSearchForm*)form context:(NSManagedObjectContext*)context{
    self.address = form.address;
    self.city = form.city;
    self.country = form.country;
    self.keywords = form.keywords;
    self.postalCode = form.postalCode;
    self.region = form.region;
}
-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context{
    return;
}
-(NSString*)description{
    return [NSString stringWithFormat:@"address: %@"
            @"city: %@"
            @"country: %@"
            @"keywords: %@"
            @"postalCode: %@"
            @"region: %@"
            @"searchResults: %@",
            self.address,
            self.city,
            self.country,
            self.keywords,
            self.postalCode,
            self.region,
            self.searchResults];
}

@end
