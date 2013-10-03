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

#import "VWWEvent.h"


@implementation VWWRESTParser


#pragma mark Private helpers
+(void)examineDictionary:(NSDictionary*)dictionary forPage:(VWWPagination**)page{
    
//    BOOL paramFound = NO;
//    *page = [[SMPagination alloc]init];
//    
//    NSNumber* temp = dictionary[@"per_page"];
//    if(temp){
//        paramFound = YES;
//        (*page).perPage = temp.intValue;
//    }
//    
//    temp = dictionary[@"total_count"];
//    if(temp){
//        paramFound = YES;
//        (*page).totalCount = temp.intValue;
//    }
//    
//    temp = dictionary[@"page_number"];
//    if(temp){
//        paramFound = YES;
//        (*page).pageNumber = temp.intValue + 1;
//    }
//    
//    // If we never found anythign, page should be nil.
//    if(paramFound == NO){
//        *page = nil;
//    }
    
}



+(BOOL)parseJSON:(id)json event:(VWWEvent**)event{
    if(json == nil) return NO;
    
    NSError *jsonError;
    NSDictionary *dictionary;
    if([json isKindOfClass:[NSDictionary class]]){
        dictionary = json;
    }
    else{
        dictionary = [NSJSONSerialization JSONObjectWithData:json
                                                     options:kNilOptions
                                                       error:&jsonError];
        if(jsonError){
            NSLog(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
            return NO;
        }
    }
    *event = [VWWEvent eventWithDictionary:dictionary];
    return YES;
}
+(BOOL)parseJSON:(id)json events:(NSArray**)events page:(VWWPagination**)page{
    if(json == nil) return NO;
    
    NSError *jsonError;
    NSDictionary *dictionary;
    if([json isKindOfClass:[NSDictionary class]]){
        dictionary = json;
    }
    else{
        dictionary = [NSJSONSerialization JSONObjectWithData:json
                                                     options:kNilOptions
                                                       error:&jsonError];
        if(jsonError){
            NSLog(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
            return NO;
        }
    }
    
    [VWWRESTParser examineDictionary:dictionary forPage:page];
    
    NSMutableArray* mutableEvents = [@[]mutableCopy];
    NSArray *eventsDictionaries = (NSArray*)dictionary[@"events"];
    for(NSDictionary *d in eventsDictionaries) {
        [mutableEvents addObject:[VWWEvent eventWithDictionary:d]];
    }
    *events = [NSArray arrayWithArray:mutableEvents];
    
    return YES;
    
}

@end
