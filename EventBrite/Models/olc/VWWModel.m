//
// VWWModel.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWModel.h"

@implementation VWWModel

- (NSString *)descriptionForKeys:(NSString *)first, ... {
    NSMutableString *desc = [NSMutableString stringWithFormat:@"<%@:%p %@:%@",
                             NSStringFromClass([self class]), self,
                             first, [self valueForKey:first]];

    va_list args;
    va_start(args, first);
    for (NSString *key = nil; (key = va_arg(args, NSString *)); ) {
        [desc appendFormat:@" %@:%@", key, [self valueForKey:key]];
    }

    return [desc stringByAppendingString:@">"];
}

@end
