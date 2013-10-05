//
//  VWWError.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWError.h"
#import "NSDictionary+TypedGetters.h"
@implementation VWWError
- (id)initWithDictionary:(NSDictionary *)dictionary{
    if (dictionary == nil) {
        return nil;
    }
    
    self = [super init];
    if(self){
        _message = [dictionary stringForKey:@"error_message"];
        _type = [dictionary stringForKey:@"error_type"];
    }
    return self;
}

#pragma mark Public methods
+(id)errorWithDictionary:(NSDictionary *)dictionary{
    return [[VWWError alloc]initWithDictionary:dictionary];
}

@end
