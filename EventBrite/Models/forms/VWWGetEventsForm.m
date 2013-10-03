//
//  VWWGetEventsForm.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWGetEventsForm.h"

@implementation VWWGetEventsForm
- (NSDictionary *)httpParametersDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [self setObject:self.radius forKey:@"radius" inDictionary:dictionary];
    [self setObject:self.longitude forKey:@"longitude" inDictionary:dictionary];
    [self setObject:self.latitude forKey:@"latitude" inDictionary:dictionary];
    [self setBool:self.search forKey:@"search" inDictionary:dictionary];
    [self setBool:self.isActive forKey:@"is_active" inDictionary:dictionary];
    return dictionary;
}
@end
