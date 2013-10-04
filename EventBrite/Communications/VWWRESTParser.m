//
//  VWWRESTParser.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWRESTParser.h"
#import "NSDictionary+TypedGetters.h"
#import "VWWPagination.h"
#import "VWWError.h"
#import "VWWEvents.h"
#import "VWWEvent.h"
#import "VWWEventsSummary.h"

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
+(BOOL)parseJSON:(id)json events:(VWWEvents**)events error:(VWWError**)error{
    if(json == nil) return NO;
    
    if([json isKindOfClass:[NSDictionary class]] == NO){
        NSLog(@"** WARNING: %s Expected json dictionary", __func__);
        return NO;
    }
    

    [VWWRESTParser examineDictionary:json forError:error];
    
    *events = [[VWWEvents alloc]init];
    NSArray *eventsDictionaries = (NSArray*)json[@"events"];
    for(NSDictionary *d in eventsDictionaries) {
        if(d[@"summary"]){
            VWWEventsSummary *summary = [VWWEventsSummary eventsSummaryWithDictionary:d[@"summary"]];
            (*events).summary = summary;
        }
        else if(d[@"event"]){
            VWWEvent *event = [VWWEvent eventWithDictionary:d[@"event"]];
            [(*events).events addObject:event];
        }
    }
    
    
    return YES;
    
}

@end
