//
// VWWEvent.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWModel.h"
#import <CoreLocation/CoreLocation.h>
#import "VWWEventOrganizer.h"
#import "VWWEventVenue.h"
#import "VWWEventTicket.h"

@interface VWWEvent : VWWModel
+(id)eventWithDictionary:(NSDictionary *)dictionary;
-(id)initWithDictionary:(NSDictionary *)dictionary;
@property (nonatomic, strong) VWWEventOrganizer *organizer;
@property (nonatomic, strong) VWWEventVenue *venue;
@property (nonatomic, strong) NSMutableArray *tickets;
@property (nonatomic, strong) NSString *title;
@end
