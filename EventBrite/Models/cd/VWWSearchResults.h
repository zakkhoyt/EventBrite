//
//  VWWSearchResults.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VWWEvent, VWWEventsSearch, VWWEventsSummary;

@interface VWWSearchResults : NSManagedObject

@property (nonatomic, retain) VWWEventsSearch *eventsSearch;
@property (nonatomic, retain) VWWEventsSummary *eventsSummary;
@property (nonatomic, retain) NSSet *events;
@end

@interface VWWSearchResults (CoreDataGeneratedAccessors)


- (void)addEventsObject:(VWWEvent *)value;
- (void)removeEventsObject:(VWWEvent *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
