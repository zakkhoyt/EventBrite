//
//  VWWRESTParser.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWRESTParser.h"
#import "NSDictionary+TypedGetters.h"
//#import "VWWPagination.h"
#import "VWWError.h"
//#import "VWWEvents.h"
#import "VWWEvent.h"
#import "VWWEventsSummary.h"
#import "VWWCoreData.h"
#import "VWWSearchResults.h"

@implementation VWWRESTParser


#pragma mark Private helpers
+(void)examineDictionary:(NSDictionary*)dictionary forError:(VWWError**)error{
    
    NSDictionary *errorDictionary = (NSDictionary*)dictionary[@"error"];
    if(errorDictionary){
        *error = [VWWError errorWithDictionary:errorDictionary];
    }
}

//
//
//+(BOOL)parseJSON:(id)json event:(VWWEvent**)event{
//    if(json == nil) return NO;
//    
//    NSError *jsonError;
//    NSDictionary *dictionary;
//    if([json isKindOfClass:[NSDictionary class]]){
//        dictionary = json;
//    }
//    else{
//        dictionary = [NSJSONSerialization JSONObjectWithData:json
//                                                     options:kNilOptions
//                                                       error:&jsonError];
//        if(jsonError){
//            NSLog(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//            return NO;
//        }
//    }
//    *event = [VWWEvent eventWithDictionary:dictionary];
//    return YES;
//}
+(BOOL)parseJSON:(id)json searchResults:(VWWSearchResults**)searchResults error:(VWWError**)error{
    if(json == nil) return NO;
    
    if([json isKindOfClass:[NSDictionary class]] == NO){
        NSLog(@"** WARNING: %s Expected json dictionary", __func__);
        return NO;
    }
    

    [VWWRESTParser examineDictionary:json forError:error];
    
    
    VWWCoreData *coreData = [VWWCoreData sharedInstance];
    NSManagedObjectContext *context = [coreData managedObjectContext];
    
    
    *searchResults = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"VWWSearchResults"
                                 inManagedObjectContext:context];
    
    
    
//    searchResults{
//        VWWEventsSummary : {
//            firstEvent
//            lastEvent
//            numShowing
//            totalItems
//            VWWEventsSearchFilter{
//                key
//                value
//            }
//        }
//        events[
//               event{
//                   about
//                   colors...
//                   VWWEventOrganizer
//                   VWWEventVenue
//                   tickets[
//                        VWWEventTicket
//                   ]
//               }
//        ]
//        }
//        
//    }
    

    NSMutableSet *eventsSet = [[NSMutableSet alloc]init];
    NSArray *eventsDictionaries = (NSArray*)json[@"events"];
    for(NSDictionary *d in eventsDictionaries) {
        NSDictionary *summaryDictionary = d[@"summary"];
        if(summaryDictionary){
            VWWEventsSummary *summary = [NSEntityDescription
                                         insertNewObjectForEntityForName:@"VWWEventsSummary"
                                         inManagedObjectContext:context];

            [summary populateWithDictionary:summaryDictionary context:context];
            (*searchResults).eventsSummary = summary;
            continue;
        }
        
        NSDictionary *eventDictionary = d[@"event"];
        if(eventDictionary){
            VWWEvent *event = [NSEntityDescription
                                         insertNewObjectForEntityForName:@"VWWEvent"
                                         inManagedObjectContext:context];

            [event populateWithDictionary:eventDictionary context:context];
            [eventsSet addObject:event];
        }
    }

    (*searchResults).events = eventsSet;
    
    // Commit to CoreData
    NSError *cdError;
    if (![context save:&cdError]) {
        NSLog(@"Whoops, couldn't save: %@", [cdError localizedDescription]);
    }

    
    

    
    return YES;
    
}

@end
