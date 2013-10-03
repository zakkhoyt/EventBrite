
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

@end
