//
//  VWWRESTParser.m
//  VWW
//
//  Created by Zakk Hoyt on 2/12/13.
//
//

#import "VWWRESTParser.h"
#import "NSDictionary+TypedGetters.h"




@implementation VWWRESTParser


#pragma mark Private helpers
+(void)examineDictionary:(NSDictionary*)dictionary forPage:(SMPagination**)page{
    
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




//+(BOOL)parseJSON:(id)json asset:(SMAsset**)asset users:(NSArray**)users{
//    if(json == nil) return NO;
//    
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
//            DDLogError(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//            return NO;
//        }
//    }
//   VWWAsset *tAsset = [SMAsset assetWithDictionary:dictionary];
//    *asset = tAsset;
//    
//
//    NSMutableArray* mutableUsers = [@[]mutableCopy];
//    NSArray *usersDictionaries = (NSArray*)dictionary[@"users"];
//    for(NSDictionary *d in usersDictionaries) {
//        [mutableUsers addObject:[SMUser userWithDictionary:d]];
//    }
//    *users = (NSArray*)mutableUsers;
//
//    
//    
//    return YES;
//}



//+(BOOL)parseJSON:(id)json assets:(NSArray**)assets page:(SMPagination**)page{
//    if(json == nil) return NO;
//    
//    NSError* jsonError;
//    NSDictionary *dictionary;
//    if([json isKindOfClass:[NSDictionary class]]){
//        dictionary = json;
//    }
//    else{
//        dictionary = [NSJSONSerialization JSONObjectWithData:json
//                                                     options:kNilOptions
//                                                       error:&jsonError];
//        if(jsonError){
//            DDLogError(@"%s:%d Error occured while parsing JSON: %@", __FUNCTION__, __LINE__, jsonError.localizedDescription);
//            return NO;
//        }
//    }
//    [VWWRESTParser examineDictionary:dictionary forPage:page];
//    
//    NSMutableArray* mutableAssets = [@[]mutableCopy];
//    NSArray *assetsDictionaries = (NSArray*)dictionary[@"assets"];
//    for(NSDictionary *d in assetsDictionaries) {
//        [mutableAssets addObject:[SMAsset assetWithDictionary:d]];
//    }
//    *assets = (NSArray*)mutableAssets;
//    
//    return YES;
//}


@end
