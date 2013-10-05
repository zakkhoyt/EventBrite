//
//  VWWRESTParser.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>
@class VWWEvents;
@class VWWEvent;
@class VWWPagination;
@class VWWError;
@class VWWSearchResults;

@interface VWWRESTParser : NSObject
//+(BOOL)parseJSON:(id)json event:(VWWEvent**)event;
+(BOOL)parseJSON:(id)json searchResults:(VWWSearchResults**)searchResults error:(VWWError**)error;
@end
