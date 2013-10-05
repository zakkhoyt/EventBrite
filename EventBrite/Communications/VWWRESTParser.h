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
@class VWWGetEventSearchForm;

@interface VWWRESTParser : NSObject
//+(BOOL)parseJSON:(id)json event:(VWWEvent**)event;
+(BOOL)parseJSON:(id)json form:(VWWGetEventSearchForm*)form searchResults:(VWWSearchResults**)searchResults error:(VWWError**)error;
@end
