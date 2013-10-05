//
//  VWWEventsSearch.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventsSearch.h"


@implementation VWWEventsSearch

@dynamic address;
@dynamic city;
@dynamic country;
@dynamic keywords;
@dynamic postalCode;
@dynamic region;
@dynamic searchResults;

-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context{
}
-(NSString*)description{
    return [NSString stringWithFormat:@""];
}

@end
