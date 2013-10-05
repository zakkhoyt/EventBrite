//
//  VWWEventTicket.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VWWManagedObject.h"

@class VWWEvent;

@interface VWWEventTicket : VWWManagedObject

@property (nonatomic, retain) NSNumber * uuid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSNumber * max;
@property (nonatomic, retain) NSNumber * min;
@property (nonatomic, retain) NSString * displayPrice;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSNumber * quantityAvailable;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * quantitySold;
@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSNumber * visible;
@property (nonatomic, retain) VWWEvent *event;

@end
