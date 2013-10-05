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
#import "VWWGetEventSearchForm.h"
#import "VWWEventsSearch.h"
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
+(BOOL)parseJSON:(id)json form:(VWWGetEventSearchForm*)form searchResults:(VWWSearchResults**)searchResults error:(VWWError**)error{
    if(json == nil) return NO;
    
    if([json isKindOfClass:[NSDictionary class]] == NO){
        NSLog(@"** WARNING: %s Expected json dictionary", __func__);
        return NO;
    }
    

    [VWWRESTParser examineDictionary:json forError:error];
    
    
    VWWCoreData *coreData = [VWWCoreData sharedInstance];
    NSManagedObjectContext *context = [coreData managedObjectContext];
    
    
    VWWEventsSearch *search = [NSEntityDescription insertNewObjectForEntityForName:@"VWWEventsSearch"
                                                            inManagedObjectContext:context];
    [search populateWithForm:form context:context];

    
    *searchResults = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"VWWSearchResults"
                                 inManagedObjectContext:context];
    

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

    search.searchResults = (*searchResults);
    
    
    
    // Commit to CoreData
    NSError *cdError;
    if (![context save:&cdError]) {
        NSLog(@"Whoops, couldn't save: %@", [cdError localizedDescription]);
        NSAssert(nil, @"Could not save managed context");
    }

    return YES;
    
}

@end
