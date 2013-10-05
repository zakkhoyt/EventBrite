//
//  VWWManagedObject.h
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <CoreData/CoreData.h>
//#import "NSDictionary+TypedGetters.h"
//#import "VWWEventOrganizer.h"
//#import "VWWEventSearchFilter.h"
//#import "VWWEventsSearch.h"
//#import "VWWEventTicket.h"
//#import "VWWEvent.h"
//#import "VWWEventsSummary.h"

@interface VWWManagedObject : NSManagedObject
-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context;
-(NSString*)description;
@end
