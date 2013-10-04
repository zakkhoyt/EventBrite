//
//  VWWEventTicket.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

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

//id 	The ticket ID.
//name 	The ticket name.
//description 	The ticket description.
//type 	0 for fixed-price tickets, 1 for donations.
//max 	The maximum ticket quantity per order for this event.
//min 	The minimum ticket quantity per order for this event.
//currency 	The ticket currency, in 3-letter ISO 4217 format (e.g., “USD”).
//price 	The ticket price (not provided if the ticket is a donation).
//start_date 	The date and time when ticket sales start, in ISO 8601 format (e.g., “2007-12-31 23:59:59″).
//end_date 	The date and time when ticket sales stop, in ISO 8601 format (e.g., “2007-12-31 23:59:59″).
//quantity_available 	Number of tickets for sale (requires authentication).
//quantity_sold 	Number of tickets sold (requires authentication).
//visible 	A boolean value indicating whether the ticket is visible on the event registration page.
@end
