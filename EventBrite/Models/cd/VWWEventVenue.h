//
//  VWWEventVenue.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VWWManagedObject.h"

@class VWWEvent;

@interface VWWEventVenue : VWWManagedObject

@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * address2;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * latLong;
@property (nonatomic, retain) VWWEvent * event;

@end
