//
//  VWWEvent.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VWWManagedObject.h"

@class VWWEventOrganizer, VWWEventTicket, VWWEventVenue, VWWSearchResults;

@interface VWWEvent : VWWManagedObject

@property (nonatomic, retain) NSNumber * capacity;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSString * distance;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * backgroundColor;
@property (nonatomic, retain) NSString * boxBackgroundColor;
@property (nonatomic, retain) NSString * boxBorderColor;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSNumber * uuid;
@property (nonatomic, retain) NSString * boxHeaderBackgroundColor;
@property (nonatomic, retain) NSString * boxHeaderTextColor;
@property (nonatomic, retain) NSString * boxTextColor;
@property (nonatomic, retain) VWWEventOrganizer *eventOrganizer;
@property (nonatomic, retain) VWWEventVenue *eventVenue;
@property (nonatomic, retain) VWWSearchResults *searchResults;
@property (nonatomic, retain) NSSet *eventTickets;
@end

@interface VWWEvent (CoreDataGeneratedAccessors)

- (void)addEventTicketsObject:(VWWEventTicket *)value;
- (void)removeEventTicketsObject:(VWWEventTicket *)value;
- (void)addEventTickets:(NSSet *)values;
- (void)removeEventTickets:(NSSet *)values;

@end
