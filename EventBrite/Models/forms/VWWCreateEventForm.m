//
//  VWWCreateEventForm.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWCreateEventForm.h"

@implementation VWWCreateEventForm
- (NSDictionary *)httpParametersDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [self setObject:self.title forKey:@"title" inDictionary:dictionary];
    [self setObject:self.longitude forKey:@"longitude" inDictionary:dictionary];
    [self setObject:self.latitude forKey:@"latitude" inDictionary:dictionary];
//    [self setObject:self.startAt forKey:@"start_at" inDictionary:dictionary];
    return dictionary;
}
@end
