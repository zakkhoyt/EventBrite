//
// VWWEvent.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//

#import "VWWEvent.h"


@interface VWWEvent ()

@end

@implementation VWWEvent


#pragma mark Private methods


- (id)initWithDictionary:(NSDictionary *)dictionary{
    if (dictionary == nil) {
        return nil;
    }
    
    self = [super init];
    if(self){
        
        _title = [dictionary stringForKey:@"title"];
        
        NSDictionary *organizerDictionary = [dictionary objectForKey:@"organizer"];
        _organizer = [VWWEventOrganizer eventOrganizerWithDictionary:organizerDictionary];
        
        NSDictionary *venueDictionary = [dictionary objectForKey:@"venue"];
        _venue = [VWWEventVenue eventVenueWithDictionary:venueDictionary];
        
        _tickets = [@[]mutableCopy];
        NSArray *ticketsArray = [dictionary objectForKey:@"tickets"];
        for(NSDictionary *ticketDictionary in ticketsArray){
            NSDictionary *d = ticketDictionary[@"ticket"];
            VWWEventTicket *ticket = [VWWEventTicket eventTicketWithDictionary:d];
            [_tickets addObject:ticket];
        }
        
        _backgroundColor = [dictionary colorForKey:@"background_color"];
        _boxBackgroundColor = [dictionary colorForKey:@"box_background_color"];
        _boxBorderColor = [dictionary colorForKey:@"box_border_color"];
        _boxHeaderBackgorundColor  = [dictionary colorForKey:@"box_header_background_color"];
        _boxHeaderTextColor = [dictionary colorForKey:@"box_header_text_color"];
        _boxTextColor = [dictionary colorForKey:@"box_text_color"];
        
        _ID = [dictionary numberForKey:@"id"];
        _capacity = [dictionary numberForKey:@"capacity"];
        _startDate = [dictionary dateForKey:@"start_date"];
        _title = [dictionary stringForKey:@"title"];
        _desciption = [dictionary stringForKey:@"description"];
        _distance = [dictionary stringForKey:@"distance"];
        _logo = [dictionary urlForKey:@"logo"];
        
    }
    return self;
}

#pragma mark Public methods
+(id)eventWithDictionary:(NSDictionary *)dictionary{
    return [[VWWEvent alloc]initWithDictionary:dictionary];
}



@end
