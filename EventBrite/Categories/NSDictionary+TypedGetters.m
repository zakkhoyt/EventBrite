

//  EventBrite
//
//  Created by Zakk Hoyt (VaporWareWolf)
//  Copyright (c) 2013. Zakk Hoyt
//


#import "NSDictionary+TypedGetters.h"
#import "VWWUtility.h"

@implementation NSDictionary (TypedGetters)

- (NSString *)stringForKey:(NSString *)key {
    id value = self[key];
    if([value isKindOfClass:[NSString class]]){
        NSString *rString = value;
        if ([rString rangeOfString:@"null"].location != NSNotFound) {
            return @"";
        }
        return rString;
    }
    else{
        return nil;
    }
    
}

- (NSNumber*)numberForKey:(NSString*)key{
    id value = self[key];
    return [value isKindOfClass:[NSNumber class]] ? value : nil;
}

- (NSURL *)urlForKey:(NSString *)key {
    id value = self[key];
    return [value isKindOfClass:[NSString class]] ? [NSURL URLWithString:value] : nil;
}

- (NSDate *)dateForKey:(NSString *)key {
    id value = self[key];
    if([value isKindOfClass:[NSString class]]){
        NSDate *utcDate = [[VWWUtility sharedUtility] internetFormattedDateFromString:value];
        NSDate *localDate = [VWWUtility convertFromUTCToLocal:utcDate];
        return localDate;
    }
    else{
        return nil;
    }
}

- (BOOL)boolForKey:(NSString *)key {
    id value = self[key];
    return [value isKindOfClass:[NSNumber class]] ? [value boolValue] : NO;
}

- (NSInteger)intForKey:(NSString *)key {
    id value = self[key];
    return [value isKindOfClass:[NSNumber class]] ? [value integerValue] : 0;
}

- (NSUInteger)uintForKey:(NSString *)key {
    id value = self[key];
    return [value isKindOfClass:[NSNumber class]] ? [value unsignedIntegerValue] : 0;
}

- (float)floatForKey:(NSString *)key {
    id value = self[key];
    return [value isKindOfClass:[NSNumber class]] ? [value floatValue] : 0.0f;
}


-(UIColor*)colorForKey:(NSString*)key{
    NSScanner* scanner = [NSScanner scannerWithString:key];
    unsigned int hex = 0;
    if ([scanner scanHexInt:&hex]) {
        int r = (hex >> 16) & 0xFF;
        int g = (hex >>  8) & 0xFF;
        int b = (hex      ) & 0xFF;
        return [UIColor colorWithRed:r/(float)0xFF green:g/(float)0xFF blue:b/(float)0xFF alpha:1.0];
    }
    return nil;
}

@end
