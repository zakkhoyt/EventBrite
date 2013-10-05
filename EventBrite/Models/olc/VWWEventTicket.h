//
//  VWWEventTicket.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//
//  Documentation: http://developer.eventbrite.com/doc/tickets/

#import "VWWModel.h"

@interface VWWEventTicket : VWWModel

+(VWWEventTicket*)eventTicketWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *max;
@property (nonatomic, strong) NSNumber *min;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *displayPrice;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *quantityAvailable;
@property (nonatomic, strong) NSString *quantitySold;
@property (nonatomic) BOOL visible;

@end
