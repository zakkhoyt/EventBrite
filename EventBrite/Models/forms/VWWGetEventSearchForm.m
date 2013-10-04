//
//  VWWGetEventSearchForm.m
//  EventBrite
//
//  Created by Zakk Hoyt on 10/3/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWGetEventSearchForm.h"

@implementation VWWGetEventSearchForm
- (NSDictionary *)httpParametersDictionary {
//    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
  
    NSMutableDictionary *dictionary = [super paramDictionary];
    [self setObject:self.keywords forKey:@"keywords" inDictionary:dictionary];
    [self setObject:self.city forKey:@"city" inDictionary:dictionary];
    return dictionary;
}

@end
