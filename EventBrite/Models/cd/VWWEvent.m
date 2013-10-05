//
//  VWWEvent.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEvent.h"
#import "VWWEventOrganizer.h"
#import "VWWEventTicket.h"
#import "VWWEventVenue.h"
#import "VWWSearchResults.h"
#import "NSDictionary+TypedGetters.h"

@implementation VWWEvent

@dynamic capacity;
@dynamic title;
@dynamic about;
@dynamic distance;
@dynamic logo;
@dynamic backgroundColor;
@dynamic boxBackgroundColor;
@dynamic boxBorderColor;
@dynamic startDate;
@dynamic uuid;
@dynamic boxHeaderBackgroundColor;
@dynamic boxHeaderTextColor;
@dynamic boxTextColor;
@dynamic eventOrganizer;
@dynamic eventVenue;
@dynamic searchResults;
@dynamic eventTickets;


-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context{
    self.title = dictionary[@"title"];
    
    
    
    self.backgroundColor = dictionary[@"background_color"];
    self.boxBackgroundColor = dictionary[@"box_background_color"];
    self.boxBorderColor = dictionary[@"box_border_color"];
    self.boxHeaderBackgroundColor  = dictionary[@"box_header_background_color"];
    self.boxHeaderTextColor = dictionary[@"box_header_text_color"];
    self.boxTextColor = dictionary[@"box_text_color"];
    
    self.uuid = dictionary[@"id"];
    self.capacity = dictionary[@"capacity"];
    self.startDate = [dictionary dateForKey:@"start_date"];
    self.title = dictionary[@"title"];
    self.about = dictionary[@"description"];
    self.distance = dictionary[@"distance"];
    self.logo = dictionary[@"logo"];
    
    
    //NSDictionary *organizerDictionary = [dictionary objectForKey:@"organizer"];
    VWWEventOrganizer *organizer = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"VWWEventOrganizer"
                                    inManagedObjectContext:context];
    
    [organizer populateWithDictionary:dictionary context:context];
    self.eventOrganizer = organizer;
    
    
    
    
    
    
    //
    //    NSDictionary *venueDictionary = [dictionary objectForKey:@"venue"];
    //    self.venue = [VWWEventVenue eventVenueWithDictionary:venueDictionary];
    //
    //    _tickets = [@[]mutableCopy];
    //    NSArray *ticketsArray = [dictionary objectForKey:@"tickets"];
    //    for(NSDictionary *ticketDictionary in ticketsArray){
    //        NSDictionary *d = ticketDictionary[@"ticket"];
    //        VWWEventTicket *ticket = [VWWEventTicket eventTicketWithDictionary:d];
    //        [self.tickets addObject:ticket];
    //    }
    
    
    
}

-(NSString*)description{
    return [NSString stringWithFormat:@"backgroundColor: %@"
            @"boxBackgroundColor: %@"
            @"boxBorderColor: %@"
            @"boxHeaderBackgroundColor: %@"
            @"boxHeaderTextColor: %@"
            @"boxTextColor: %@"
            @"id: %@"
            @"capacity: %@"
            @"start_date: %@"
            @"title: %@"
            @"about: %@"
            @"distance: %@"
            @"logo: %@",
            self.backgroundColor,
            self.boxBackgroundColor,
            self.boxBorderColor,
            self.boxHeaderBackgroundColor,
            self.boxHeaderTextColor,
            self.boxTextColor,
            self.uuid,
            self.capacity,
            self.startDate,
            self.title,
            self.about,
            self.distance,
            self.logo];
}

@end
