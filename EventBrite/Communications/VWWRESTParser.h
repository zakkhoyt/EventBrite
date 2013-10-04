//
//  VWWRESTParser.h
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import <Foundation/Foundation.h>
@class VWWEvent;
@class VWWPagination;
@class VWWError;
@interface VWWRESTParser : NSObject
//+(BOOL)parseJSON:(id)json event:(VWWEvent**)event;
+(BOOL)parseJSON:(id)json events:(NSArray**)events error:(VWWError**)error;
@end
