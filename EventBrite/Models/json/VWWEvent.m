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
//        @property (nonatomic, strong) VWWEventOrganizer *organizer;
//        @property (nonatomic, strong) VWWEventVenue *venue;
//        @property (nonatomic, strong) NSArray *tickets;
//        
//        
//        @property (nonatomic, strong) NSString *title;

        
        
    }
    return self;
}

#pragma mark Public methods
+(id)eventWithDictionary:(NSDictionary *)dictionary{
    return [[VWWEvent alloc]initWithDictionary:dictionary];
}



@end
