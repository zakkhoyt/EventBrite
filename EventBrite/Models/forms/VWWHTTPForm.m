//
// VWWHTTPForm.m
//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//
#import "VWWHTTPForm.h"
#import "VWWUtility.h"


const NSInteger kItemsPerPageMax = 999999;

@implementation VWWHTTPForm

- (NSDictionary *)httpParametersDictionary {
    NSAssert(NO, @"Subclasses must implement method");
    return nil;
}

- (NSString *)JSONString {
    NSString *json;
    @autoreleasepool {
        NSAssert(NO, @"check to see that we are doing the right thing here with native json");
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.httpParametersDictionary
                                                           options:0
                                                             error:&error];
        json = [[NSString alloc]initWithBytes:jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];
    }
    
    return json;
}

- (void)setObject:(id)value forKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary {
    if (!value) return;

    if ([value isKindOfClass:[NSURL class]]) {
        dictionary[key] = [value absoluteString];
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        dictionary[key] = [NSString stringWithFormat:@"%d", [value intValue]];
    }
    else if ([value isKindOfClass:[NSDate class]]) {
        dictionary[key] = [[VWWUtility sharedUtility] stringFromDate:value
                                                            usingFormat:@"yyyy'-'MM'-'dd HH':'mm':'ss UTC"];

    }
    else {
        dictionary[key] = value;
    }
}

- (void)setBool:(BOOL)value forKey:(NSString *)key inDictionary:(NSMutableDictionary *)dictionary {
    dictionary[key] = value ? @"true" : @"false";
}



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

- (NSMutableDictionary*)paramDictionary{
    NSMutableDictionary *dictionary = [@{@"app_key" : VWW_EVENT_BRITE_KEY} mutableCopy];
    return dictionary;
}

@end
