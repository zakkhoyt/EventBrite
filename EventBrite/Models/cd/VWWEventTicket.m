//
//  VWWEventTicket.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventTicket.h"
#import "VWWEvent.h"
#import "NSDictionary+TypedGetters.h"

@implementation VWWEventTicket

@dynamic uuid;
@dynamic name;
@dynamic about;
@dynamic type;
@dynamic max;
@dynamic min;
@dynamic displayPrice;
@dynamic price;
@dynamic startDate;
@dynamic quantityAvailable;
@dynamic endDate;
@dynamic quantitySold;
@dynamic currency;
@dynamic visible;
@dynamic event;

-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context{
    self.uuid = dictionary[@"id"];
    self.name = dictionary[@"name"];
    self.about = dictionary[@"description"];
    self.type = dictionary[@"type"];
    self.min = dictionary[@"min"];
//    self.max = dictionary[@"max"];
    self.max = [dictionary numberForKey:@"max"];
    self.currency = dictionary[@"currency"];
    self.price = dictionary[@"price"];
    self.displayPrice = dictionary[@"display_price"];
    self.startDate = [dictionary dateForKey:@"start_date"];
    self.endDate = [dictionary dateForKey:@"end_date"];
    self.quantityAvailable = dictionary[@"quantity_available"];
    self.quantitySold = dictionary[@"quantity_sold"];
    self.visible = dictionary[@"visible"];
}

-(NSString*)description{
    return [NSString stringWithFormat:@"id: %@"
            @"name: %@"
            @"description: %@"
            @"type: %@"
            @"min: %@"
            @"max: %@"
            @"currency: %@"
            @"price: %@"
            @"display_price: %@"
            @"start_date: %@"
            @"end_date: %@"
            @"quantity_available: %@"
            @"quantity_sold: %@"
            @"visible: %@",
            self.uuid,
            self.name,
            self.about,
            self.type,
            self.min,
            self.max,
            self.currency,
            self.price,
            self.displayPrice,
            self.startDate,
            self.endDate,
            self.quantityAvailable,
            self.quantitySold,
            self.visible];
}

@end
