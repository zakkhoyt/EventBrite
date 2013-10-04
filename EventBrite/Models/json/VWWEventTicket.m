//
//  VWWEventTicket.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventTicket.h"

@implementation VWWEventTicket

-(id)initWithDictionary:(NSDictionary*)dictionary{
    if (dictionary == nil) {
        return nil;
    }
    
    self = [super init];
    if(self){
        _ID = [dictionary numberForKey:@"id"];
        _name = [dictionary stringForKey:@"name"];
        _description = [dictionary stringForKey:@"description"];
        _type = [dictionary numberForKey:@"type"];
        _max = [dictionary numberForKey:@"max"];
        _min = [dictionary numberForKey:@"min"];
        _currency = [dictionary stringForKey:@"currency"];
        _price = [dictionary numberForKey:@"price"];
        _displayPrice = [dictionary numberForKey:@"display_price"];
        _startDate = [dictionary dateForKey:@"start_date"];
        _endDate = [dictionary dateForKey:@"end_date"];
        _quantityAvailable = [dictionary stringForKey:@"quantity_available"];
        _quantitySold = [dictionary stringForKey:@"quantity_sold"];
        _visible = [dictionary boolForKey:@"visible"];
    }
    return self;
}

+(VWWEventTicket*)eventTicketWithDictionary:(NSDictionary *)dictionary{
    return [[VWWEventTicket alloc]initWithDictionary:dictionary];
}



@end
