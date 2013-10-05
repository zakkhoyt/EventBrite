//
//  VWWEvent.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEvent.h"
#import "NSDictionary+TypedGetters.h"
#import "VWWEventOrganizer.h"
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
    self.title = [dictionary stringForKey:@"title"];
    

    
    self.backgroundColor = [dictionary stringForKey:@"background_color"];
    self.boxBackgroundColor = [dictionary stringForKey:@"box_background_color"];
    self.boxBorderColor = [dictionary stringForKey:@"box_border_color"];
    self.boxHeaderBackgroundColor  = [dictionary stringForKey:@"box_header_background_color"];
    self.boxHeaderTextColor = [dictionary stringForKey:@"box_header_text_color"];
    self.boxTextColor = [dictionary stringForKey:@"box_text_color"];
    
    self.uuid = [dictionary numberForKey:@"id"];
    self.capacity = [dictionary numberForKey:@"capacity"];
    self.startDate = [dictionary dateForKey:@"start_date"];
    self.title = [dictionary stringForKey:@"title"];
    self.about = [dictionary stringForKey:@"description"];
    self.distance = [dictionary stringForKey:@"distance"];
    self.logo = [dictionary stringForKey:@"logo"];

    
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
    return [NSString stringWithFormat:@""];
}

@end
