//
//  VWWEventsSummary.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VWWManagedObject.h"

@class VWWEventSearchFilter, VWWSearchResults;

@interface VWWEventsSummary : VWWManagedObject

@property (nonatomic, retain) NSNumber * firstEvent;
@property (nonatomic, retain) NSNumber * numShowing;
@property (nonatomic, retain) NSNumber * lastEvent;
@property (nonatomic, retain) NSNumber * totalItems;
@property (nonatomic, retain) VWWSearchResults *searchResults;
@property (nonatomic, retain) NSSet *searchFilters;
@end

@interface VWWEventsSummary (CoreDataGeneratedAccessors)
-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context;

- (void)addSearchFiltersObject:(VWWEventSearchFilter *)value;
- (void)removeSearchFiltersObject:(VWWEventSearchFilter *)value;
- (void)addSearchFilters:(NSSet *)values;
- (void)removeSearchFilters:(NSSet *)values;

@end
