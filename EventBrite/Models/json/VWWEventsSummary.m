//
//  VWWEventsSummary.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventsSummary.h"

@implementation VWWEventsSummary

- (id)initWithDictionary:(NSDictionary *)dictionary{
    if (dictionary == nil) {
        return nil;
    }
    
    self = [super init];
    if(self){
        _filters = dictionary[@"filters"];
        _firstEvent = dictionary[@"first_event"];
        _lastEvent = dictionary[@"last_event"];
        _numShowing = dictionary[@"num_showing"];
        _totalItems = dictionary[@"total_items"];
    }
    return self;
}


+(id)eventsSummaryWithDictionary:(NSDictionary *)dictionary{
    return [[VWWEventsSummary alloc]initWithDictionary:dictionary];
}





@end
