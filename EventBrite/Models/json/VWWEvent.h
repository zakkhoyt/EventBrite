//
// VWWEvent.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
//  Documentation: http://developer.eventbrite.com/doc/events/event_search/

#import "VWWModel.h"
#import <CoreLocation/CoreLocation.h>
#import "VWWEventOrganizer.h"
#import "VWWEventVenue.h"
#import "VWWEventTicket.h"

@interface VWWEvent : VWWModel
+(id)eventWithDictionary:(NSDictionary *)dictionary;
-(id)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *boxBackgroundColor;
@property (nonatomic, strong) UIColor *boxBorderColor;
@property (nonatomic, strong) UIColor *boxHeaderBackgorundColor;
@property (nonatomic, strong) UIColor *boxHeaderTextColor;
@property (nonatomic, strong) UIColor *boxTextColor;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *capacity;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desciption;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSURL *logo;

// These are sub objects (not default types, but made of default types)
@property (nonatomic, strong) VWWEventOrganizer *organizer;
@property (nonatomic, strong) VWWEventVenue *venue;
@property (nonatomic, strong) NSMutableArray *tickets;

@end
