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
#import "VWWEvent.h"


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
+(BOOL)parseJSON:(id)json events:(NSArray**)events error:(VWWError**)error{
    if(json == nil) return NO;
    
    
    
    if([json isKindOfClass:[NSDictionary class]] == NO){
        NSLog(@"** WARNING: %s Expected json dictionary", __func__);
    }
    NSDictionary *dictionary = (NSDictionary*)json;

    [VWWRESTParser examineDictionary:dictionary forError:error];
    
    NSMutableArray* mutableEvents = [@[]mutableCopy];
    NSArray *eventsDictionaries = (NSArray*)dictionary[@"events"];
    for(NSDictionary *d in eventsDictionaries) {
        [mutableEvents addObject:[VWWEvent eventWithDictionary:d]];
    }
    *events = [NSArray arrayWithArray:mutableEvents];
    
    return YES;
    
}

@end
