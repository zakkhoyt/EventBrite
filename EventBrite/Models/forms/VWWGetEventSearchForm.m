//
//  VWWGetEventSearchForm.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWGetEventSearchForm.h"

@implementation VWWGetEventSearchForm
- (NSDictionary *)httpParametersDictionary {
    NSMutableDictionary *dictionary = [super paramDictionary];
    [self setObject:self.keywords forKey:kVWWKeywordsKey inDictionary:dictionary];
    [self setObject:self.city forKey:kVWWCityKey inDictionary:dictionary];
    [self setObject:self.address forKey:kVWWAddressKey inDictionary:dictionary];
    [self setObject:self.region forKey:kVWWRegionKey inDictionary:dictionary];
    [self setObject:self.postalCode forKey:kVWWPostalCodeKey inDictionary:dictionary];
    [self setObject:self.country forKey:kVWWCountryKey inDictionary:dictionary];
    return dictionary;
}

@end
