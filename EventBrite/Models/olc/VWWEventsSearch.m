//
//  VWWEventsSearch.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWEventsSearch.h"
#import "VWWEvents.h"

@implementation VWWEventsSearch

-(id)init{
    self = [super init];
    if(self){
//        _searchParemeters = [@{}mutableCopy];
    }
    return self;
}

-(NSString*)searchHash{
    NSMutableString *hash = [[NSMutableString alloc]initWithString:@""];
    
    for(NSInteger index = 0; index < self.searchParemeters.count; index++){
        NSString *key = self.searchParemeters.allKeys[index];
        NSString *value = self.searchParemeters.allValues[index];
        [hash appendFormat:@"%@-%@|", key, value];
    }
    return hash;
}

@end
