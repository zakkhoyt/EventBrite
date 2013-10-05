//
//  VWWEventsSummary.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/4/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventsSummary.h"
//#import "VWWEventSearchFilter.h"
//#import "VWWSearchResults.h"
#import "VWWEventSearchFilter.h"

@implementation VWWEventsSummary

@dynamic firstEvent;
@dynamic numShowing;
@dynamic lastEvent;
@dynamic totalItems;
@dynamic searchResults;
@dynamic searchFilters;



-(void)populateWithDictionary:(NSDictionary *)dictionary context:(NSManagedObjectContext*)context{
//    self.filters = dictionary[@"filters"];
    self.firstEvent = dictionary[@"first_event"];
    self.lastEvent = dictionary[@"last_event"];
    self.numShowing = dictionary[@"num_showing"];
    self.totalItems = dictionary[@"total_items"];
    
//    VWWEventSearchFilter *filter = [NSEntityDescription
//                                 insertNewObjectForEntityForName:@"VWWEventSearchFilter"
//                                 inManagedObjectContext:context];
    
//    self.searchFilters
//    NSDictionary *filtersDictionary = dictionary[@"filters"];
//    if(filtersDictionary){
//        [filter populateWithDictionary:filtersDictionary context:context];
//    }
}

-(NSString*)description{
    return [NSString stringWithFormat:@""];
}



@end
